import { fallbackCategories, fallbackFeaturedProducts, fallbackStats } from "$lib/data";

export async function load({ locals }) {
  const result = {
    stats: fallbackStats,
    categories: fallbackCategories,
    featuredProducts: fallbackFeaturedProducts,
  };

  try {
    const [{ data: categories, error: categoriesError }, { data: featured, error: featuredError }] =
      await Promise.all([
        locals.supabase
          .from("product_categories")
          .select("name, slug, sort_order")
          .eq("is_active", true)
          .order("sort_order", { ascending: true }),
        locals.supabase
          .from("products")
          .select("slug, name, description, daily_price, image_url, product_categories(name)")
          .eq("is_published", true)
          .eq("is_featured", true)
          .order("created_at", { ascending: false })
          .limit(3),
      ]);

    if (!categoriesError && categories?.length) {
      result.categories = categories.map((category) => ({
        name: category.name,
        slug: category.slug,
      }));
    }

    if (!featuredError && featured?.length) {
      result.featuredProducts = featured.map((product) => ({
        slug: product.slug,
        title: product.name,
        description: product.description,
        image: product.image_url,
        price: product.daily_price ? `AED ${Number(product.daily_price)}` : null,
        category: product.product_categories?.name ?? "Equipment",
      }));
    }
  } catch {
    // Keep the page functional with the local mock data until Supabase is configured.
  }

  return result;
}
