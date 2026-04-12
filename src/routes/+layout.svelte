<script>
  import "../app.css";
  import { invalidate } from "$app/navigation";
  import { onMount } from "svelte";

  export let data;

  onMount(() => {
    const { data: authListener } = data.supabase.auth.onAuthStateChange((_event, session) => {
      if (session?.access_token !== data.session?.access_token) {
        invalidate("supabase:auth");
      }
    });

    return () => authListener.subscription.unsubscribe();
  });
</script>

<slot />
