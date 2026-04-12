export async function load({ cookies, locals }) {
  const { session, user } = await locals.safeGetSession();

  return {
    cookies: cookies.getAll(),
    session,
    user,
  };
}
