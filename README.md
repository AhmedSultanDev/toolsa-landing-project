# Toolsa Landing Project

SvelteKit + Supabase/Postgres app scaffold for a Toolsa-inspired equipment rental site.

## Stack

- SvelteKit
- Svelte 5
- Supabase SSR + Supabase JS
- Postgres via Supabase

## Setup

1. Copy `.env.example` to `.env`
2. Fill in your Supabase project values
3. Run `npm install`
4. Run `npm run dev`

## Database

The initial schema lives in:

- `supabase/migrations/20260412113000_initial_toolsa_schema.sql`

It creates:

- `product_categories`
- `products`
- `contact_submissions`
- `quote_requests`

It also seeds starter categories and featured products.

## Scripts

- `npm run dev`
- `npm run build`
- `npm run preview`
- `npm run check`

## Structure

- `src/routes/+page.svelte` - landing page UI
- `src/routes/+page.server.js` - homepage data loading from Supabase with local fallback
- `src/hooks.server.js` - Supabase SSR auth/session wiring
- `src/routes/api/contact/+server.js` - contact submission endpoint
- `src/routes/api/quote/+server.js` - quote request endpoint
- `src/lib/server/supabaseAdmin.js` - optional service-role client for server-only operations
- `supabase/migrations/` - Postgres schema and seed SQL
