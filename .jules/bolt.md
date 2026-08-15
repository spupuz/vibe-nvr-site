## 2024-08-11 - Sequential Component Fetching Bottleneck
**Learning:** The vanilla JS architecture of this site loads HTML fragments for each section sequentially using a `for...await` loop. This creates an unnecessary waterfall of network requests that severely delays time-to-interactive.
**Action:** Replace sequential `for...await` loops with `Promise.all()` when fetching independent resources to enable concurrent loading and reduce total network time.

## 2024-08-11 - Lazy Loading Below-the-Fold Images
**Learning:** The landing page contained numerous images in the gallery, integrations, and support sections that were loading synchronously during the initial page load, creating network contention and delaying Time to Interactive (TTI). Adding the standard `loading="lazy"` attribute to these `<img>` tags fixes this issue efficiently without breaking the user experience.
**Action:** When implementing pages with long scrolls or galleries, always ensure images below the fold have `loading="lazy"` enabled.

## 2024-08-14 - Preloading LCP Assets in Dynamic Architectures
**Learning:** The vanilla JS architecture of this site injects HTML fragments dynamically. This hides crucial Largest Contentful Paint (LCP) images (like hero images) from the browser's initial preload scanner, delaying render times significantly. Also, using `@import` for fonts in CSS blocks CSS parsing and delays font loading.
**Action:** Always preload critical LCP images in the main `index.html` head using `<link rel="preload">` when the image itself is injected dynamically. Move web fonts out of CSS `@import` and into `<link>` tags in the HTML to parallelize resource fetching.

## 2026-08-15 - Dynamic Cache Busting Defeats Caching
**Learning:** Using `Date.now()` as a cache buster parameter for fetching static HTML component fragments effectively forces the browser to re-download all 13 components on every single page load, creating unnecessary network overhead and negatively impacting Time to Interactive (TTI) for return visitors.
**Action:** Use a static version string (e.g., matching the main CSS version) instead of a dynamic timestamp when fetching static HTML fragments. This allows the browser to properly cache the components while still providing a mechanism to bust the cache when the site is updated.
