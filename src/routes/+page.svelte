<script>
  import {
    contact,
    footerCategories,
    navLinks,
    whyPoints,
  } from "$lib/data";

  export let data;

  let mobileMenuOpen = false;
  const year = new Date().getFullYear();

  function closeMobileMenu() {
    mobileMenuOpen = false;
  }
</script>

<svelte:head>
  <title>Toolsa | Construction Equipment Rental in Dubai Since 1993</title>
  <meta
    name="description"
    content="Rent construction equipment, generators, compressors, and industrial tools in Dubai. 30+ years experience, 300+ equipment items. Get a quote today!"
  />
</svelte:head>

<header class="site-header">
  <div class="container">
    <div class="header-row">
      <a class="brand" href="#top" aria-label="Toolsa home">
        <img
          src="https://toolsarental.ae/assets/toolsa-logo-Cc_lfSCs.png"
          alt="Toolsa - Tools & Machinery Hire"
        />
      </a>

      <nav class="nav" aria-label="Primary">
        {#each navLinks as link}
          <a href={link.href}>{link.label}</a>
        {/each}
      </nav>

      <div class="header-actions">
        <a class="btn btn-primary" href="#contact">Request a Quote</a>
        <button
          class="mobile-toggle"
          type="button"
          aria-expanded={mobileMenuOpen}
          aria-controls="mobile-menu"
          aria-label="Toggle menu"
          on:click={() => (mobileMenuOpen = !mobileMenuOpen)}
        >
          <span></span>
        </button>
      </div>
    </div>

    <div class:mobile-menu={true} class:is-open={mobileMenuOpen} id="mobile-menu">
      <nav aria-label="Mobile">
        {#each navLinks as link}
          <a href={link.href} on:click={closeMobileMenu}>{link.label}</a>
        {/each}
        <a class="btn btn-primary" href="#contact" on:click={closeMobileMenu}>Request a Quote</a>
      </nav>
    </div>
  </div>
</header>

<main id="top">
  <section class="hero">
    <div class="container">
      <div class="hero-inner">
        <div class="hero-kicker">Since 1993</div>
        <h1>Construction Equipment Rental in Dubai</h1>
        <p class="hero-tagline">Gear Up, Stress Down</p>
        <p class="hero-copy">
          Premium tools and machinery for construction, industrial, and commercial projects.
          Trusted by Dubai's leading contractors for over 30 years.
        </p>

        <div class="hero-actions">
          <a class="btn btn-primary" href="#contact">Request a Quote</a>
          <a
            class="btn-whatsapp"
            href={contact.whatsappHref}
            target="_blank"
            rel="noopener noreferrer"
          >
            WhatsApp Us
          </a>
        </div>
      </div>
    </div>
  </section>

  <section class="stats-strip" aria-label="Company statistics">
    <div class="container">
      <div class="stats-grid">
        {#each data.stats as stat}
          <div class="stat">
            <strong>{stat.value}</strong>
            <span>{stat.label}</span>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <section class="section-padding" id="categories">
    <div class="container">
      <div class="section-title">
        <h2>Equipment Categories</h2>
        <p>
          Browse our comprehensive range of construction and industrial equipment available for
          hire.
        </p>
      </div>

      <div class="categories-grid">
        {#each data.categories as category}
          <a class="category-card" href="#featured">
            <h3>{category.name}</h3>
          </a>
        {/each}
      </div>

      <div class="section-link">
        <a href="#featured">View All Products <span aria-hidden="true">&rarr;</span></a>
      </div>
    </div>
  </section>

  <section class="section-padding featured" id="featured">
    <div class="container">
      <div class="section-title">
        <h2>Featured Equipment</h2>
        <p>Explore our most popular rental equipment, ready for immediate dispatch.</p>
      </div>

      <div class="products-grid">
        {#each data.featuredProducts as product}
          <article class="product-card">
            <div class="product-media">
              <img src={product.image} alt={product.title} />
            </div>
            <div class="product-content">
              <span class="badge">{product.category}</span>
              <h3>{product.title}</h3>
              <p>{product.description}</p>
              {#if product.price}
                <p class="price">{product.price} <span>/day</span></p>
              {/if}
            </div>
          </article>
        {/each}
      </div>

      <div class="section-link">
        <a class="btn btn-secondary" href="#contact">Browse All Equipment</a>
      </div>
    </div>
  </section>

  <section class="section-padding" id="why-toolsa">
    <div class="container">
      <div class="why-grid">
        <div class="why-copy">
          <h2>Why Choose Toolsa?</h2>
          <p>
            For over three decades, we've been Dubai's go-to partner for reliable equipment
            rental. From small tools to heavy machinery, we deliver quality you can count on.
          </p>

          <ul class="why-list">
            {#each whyPoints as point}
              <li>{point}</li>
            {/each}
          </ul>

          <div class="why-actions">
            <a class="btn btn-outline" href="#contact">Learn More About Us</a>
          </div>
        </div>

        <aside class="cta-box" id="contact">
          <h3>Ready to Get Started?</h3>
          <p>
            Tell us what you need and we'll get back to you with a competitive quote within hours.
          </p>

          <div class="cta-actions">
            <a class="btn btn-primary" href={contact.emailHref}>Request a Quote</a>
            <a
              class="btn-whatsapp"
              href={contact.whatsappHref}
              target="_blank"
              rel="noopener noreferrer"
            >
              WhatsApp Us
            </a>
          </div>
        </aside>
      </div>
    </div>
  </section>
</main>

<footer class="site-footer">
  <div class="container footer-inner">
    <div class="footer-grid">
      <div class="footer-brand">
        <img src="https://toolsarental.ae/assets/toolsa-logo-Cc_lfSCs.png" alt="Toolsa" />
        <p>Dubai's trusted equipment rental partner since 1993.</p>
        <p class="footer-tagline">Gear Up, Stress Down</p>
      </div>

      <div>
        <h4 class="footer-heading">Quick Links</h4>
        <div class="footer-list">
          {#each navLinks as link}
            <a href={link.href}>{link.label}</a>
          {/each}
        </div>
      </div>

      <div>
        <h4 class="footer-heading">Categories</h4>
        <div class="footer-list">
          {#each footerCategories as category}
            <a href="#featured">{category}</a>
          {/each}
        </div>
      </div>

      <div>
        <h4 class="footer-heading">Contact Us</h4>
        <div class="footer-contact">
          <a href={contact.mapHref} target="_blank" rel="noopener noreferrer">{contact.address}</a>
          <a href={contact.phoneHref}>{contact.phoneDisplay}</a>
          <a href={contact.emailHref}>{contact.email}</a>
        </div>
      </div>
    </div>

    <div class="footer-divider">
      <p>&copy; {year} Toolsa Tools &amp; Machinery Hire. All rights reserved.</p>
      <a href="#top">Back to top</a>
    </div>
  </div>
</footer>

<a
  class="btn floating-whatsapp"
  href={contact.whatsappHref}
  target="_blank"
  rel="noopener noreferrer"
  aria-label="Chat on WhatsApp"
>
  &#9990;
</a>
