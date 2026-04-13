create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc'::text, now());
  return new;
end;
$$;

create table if not exists public.product_categories (
  id bigint generated always as identity primary key,
  name text not null unique,
  slug text not null unique,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default timezone('utc'::text, now())
);

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  category_id bigint references public.product_categories(id) on delete set null,
  name text not null,
  slug text not null unique,
  description text,
  daily_price numeric(10, 2),
  image_url text,
  is_featured boolean not null default false,
  is_published boolean not null default true,
  created_at timestamptz not null default timezone('utc'::text, now()),
  updated_at timestamptz not null default timezone('utc'::text, now())
);

create table if not exists public.contact_submissions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  company text,
  email text not null,
  phone text,
  message text not null,
  status text not null default 'new' check (status in ('new', 'in_progress', 'resolved', 'archived')),
  created_at timestamptz not null default timezone('utc'::text, now())
);

create table if not exists public.quote_requests (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null,
  company_name text,
  email text not null,
  mobile_number text not null,
  equipment_needed text not null,
  rental_start date,
  rental_end date,
  delivery_required boolean not null default false,
  delivery_address text,
  notes text,
  status text not null default 'pending' check (status in ('pending', 'quoted', 'won', 'lost', 'archived')),
  created_at timestamptz not null default timezone('utc'::text, now())
);

drop trigger if exists set_products_updated_at on public.products;
create trigger set_products_updated_at
before update on public.products
for each row
execute function public.set_updated_at();

alter table public.product_categories enable row level security;
alter table public.products enable row level security;
alter table public.contact_submissions enable row level security;
alter table public.quote_requests enable row level security;

drop policy if exists "Public can read active categories" on public.product_categories;
create policy "Public can read active categories"
on public.product_categories
for select
to anon, authenticated
using (is_active = true);

drop policy if exists "Public can read published products" on public.products;
create policy "Public can read published products"
on public.products
for select
to anon, authenticated
using (is_published = true);

drop policy if exists "Public can insert contact submissions" on public.contact_submissions;
create policy "Public can insert contact submissions"
on public.contact_submissions
for insert
to anon, authenticated
with check (true);

drop policy if exists "Public can insert quote requests" on public.quote_requests;
create policy "Public can insert quote requests"
on public.quote_requests
for insert
to anon, authenticated
with check (true);

insert into public.product_categories (name, slug, sort_order)
values
  ('Access Platforms', 'access-platforms', 1),
  ('Power Generation', 'power-generation', 2),
  ('Air Compressors & Air Tools', 'air-compressors-air-tools', 3),
  ('Cleaning', 'cleaning', 4),
  ('Power Tools', 'power-tools', 5),
  ('Compaction', 'compaction', 6),
  ('Lighting', 'lighting', 7),
  ('Welding Equipment', 'welding-equipment', 8)
on conflict (slug) do update
set
  name = excluded.name,
  sort_order = excluded.sort_order,
  is_active = true;

insert into public.products (category_id, name, slug, description, daily_price, image_url, is_featured)
values
  (
    (select id from public.product_categories where slug = 'air-compressors-air-tools'),
    'Air Compressor 500 L',
    'air-compressor-500-l',
    'Great belt driven technology developed for simple, dependable site performance in Dubai conditions.',
    180,
    '/product-images/air-compressor-500-l.jpg',
    true
  ),
  (
    (select id from public.product_categories where slug = 'power-tools'),
    'Rotary Hammer Drill',
    'rotary-hammer-drill',
    '26mm SDS rotary hammer drill suited for concrete, anchor work, and fast-paced site tasks.',
    85,
    '/product-images/rotary-hammer-drill.png',
    true
  ),
  (
    (select id from public.product_categories where slug = 'power-tools'),
    'Random Orbital Sander',
    'random-orbital-sander',
    'Smooth finishing performance for workshop, fit-out, and decorating crews across Dubai.',
    65,
    '/product-images/random-orbital-sander.webp',
    true
  )
on conflict (slug) do update
set
  category_id = excluded.category_id,
  name = excluded.name,
  description = excluded.description,
  daily_price = excluded.daily_price,
  image_url = excluded.image_url,
  is_featured = excluded.is_featured,
  is_published = true;
