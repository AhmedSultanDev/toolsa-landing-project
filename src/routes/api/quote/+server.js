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

  const {
    customer_name,
    email,
    mobile_number,
    equipment_needed,
    company_name = null,
    rental_start = null,
    rental_end = null,
    delivery_required = false,
    delivery_address = null,
    notes = null,
  } = payload;

  if (!customer_name || !email || !mobile_number || !equipment_needed) {
    return badRequest("Customer name, email, mobile number, and equipment needed are required.");
  }

  const supabase = createSupabaseAdminClient() ?? locals.supabase;
  const { error } = await supabase.from("quote_requests").insert({
    customer_name,
    company_name,
    email,
    mobile_number,
    equipment_needed,
    rental_start,
    rental_end,
    delivery_required,
    delivery_address,
    notes,
  });

  if (error) {
    return json({ error: error.message }, { status: 500 });
  }

  return json({ ok: true });
}
