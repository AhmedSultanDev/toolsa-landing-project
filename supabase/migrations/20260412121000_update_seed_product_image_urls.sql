update public.products
set image_url = case slug
  when 'air-compressor-500-l' then '/product-images/air-compressor-500-l.jpg'
  when 'random-orbital-sander' then '/product-images/random-orbital-sander.webp'
  when 'rotary-hammer-drill' then '/product-images/rotary-hammer-drill.png'
  else image_url
end
where slug in (
  'air-compressor-500-l',
  'random-orbital-sander',
  'rotary-hammer-drill'
);
