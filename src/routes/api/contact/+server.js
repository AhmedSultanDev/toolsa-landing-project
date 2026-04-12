import { json } from "@sveltejs/kit";
import { createSupabaseAdminClient } from "$lib/server/supabaseAdmin";

function badRequest(message) {
  return json({ error: message }, { status: 400 });
}

export async function POST({ request, locals }) {
  const payload = await request.json().catch(() => null);

  if (!payload) {
    return badRequest("Invalid JSON body.");
  }

  const { name, email, phone, message, company = null } = payload;

  if (!name || !email || !message) {
    return badRequest("Name, email, and message are required.");
  }

  const supabase = createSupabaseAdminClient() ?? locals.supabase;
  const { error } = await supabase.from("contact_submissions").insert({
    name,
    company,
    email,
    phone,
    message,
  });

  if (error) {
    return json({ error: error.message }, { status: 500 });
  }

  return json({ ok: true });
}
