## 2024-08-11 - Sequential Component Fetching Bottleneck
**Learning:** The vanilla JS architecture of this site loads HTML fragments for each section sequentially using a `for...await` loop. This creates an unnecessary waterfall of network requests that severely delays time-to-interactive.
**Action:** Replace sequential `for...await` loops with `Promise.all()` when fetching independent resources to enable concurrent loading and reduce total network time.

## 2024-08-11 - Lazy Loading Below-the-Fold Images
**Learning:** The landing page contained numerous images in the gallery, integrations, and support sections that were loading synchronously during the initial page load, creating network contention and delaying Time to Interactive (TTI). Adding the standard `loading="lazy"` attribute to these `<img>` tags fixes this issue efficiently without breaking the user experience.
**Action:** When implementing pages with long scrolls or galleries, always ensure images below the fold have `loading="lazy"` enabled.

## 2024-08-14 - Preloading LCP Assets in Dynamic Architectures
**Learning:** The vanilla JS architecture of this site injects HTML fragments dynamically. This hides crucial Largest Contentful Paint (LCP) images (like hero images) from the browser's initial preload scanner, delaying render times significantly. Also, using `@import` for fonts in CSS blocks CSS parsing and delays font loading.
**Action:** Always preload critical LCP images in the main `index.html` head using `<link rel="preload">` when the image itself is injected dynamically. Move web fonts out of CSS `@import` and into `<link>` tags in the HTML to parallelize resource fetching.

## 2024-08-16 - Synchronous DOM Querying in Scroll Handlers
**Learning:** Querying the DOM (e.g., `document.getElementById`) and manipulating DOM classes synchronously inside high-frequency event listeners like `scroll` causes unnecessary reflows, blocks the main thread, and leads to scroll jank.
**Action:** Always cache DOM element references outside of the event listener, and use `requestAnimationFrame` to throttle and synchronize layout changes with the browser's render cycle during scroll events.

## 2026-08-15 - Dynamic Cache Busting Defeats Caching
**Learning:** Using `Date.now()` as a cache buster parameter for fetching static HTML component fragments effectively forces the browser to re-download all 13 components on every single page load, creating unnecessary network overhead and negatively impacting Time to Interactive (TTI) for return visitors.
**Action:** Use a static version string (e.g., matching the main CSS version) instead of a dynamic timestamp when fetching static HTML fragments. This allows the browser to properly cache the components while still providing a mechanism to bust the cache when the site is updated.

## 2024-08-17 - Pause Background Animations
**Learning:** Interval-based animations (like auto-scrolling galleries) that run constantly in the background even when off-screen cause unnecessary layout calculations (`clientWidth`, `scrollWidth`) and continuous CPU wake-ups, negatively affecting performance and battery life.
**Action:** Always wrap the execution logic of `setInterval` based animations with an `IntersectionObserver` visibility check (`isVisible` flag), so work is skipped when the element is out of the viewport.

## 2026-08-18 - DOM Mutation for Telemetry Pixels
**Learning:** Appending a hidden 1x1 image pixel to `document.body` for tracking/telemetry purposes forces the browser to unnecessarily recalculate layout and repaint, degrading performance on page load.
**Action:** Always create tracking `Image` objects in memory and simply set their `src` attribute to trigger the network request. Never append them to the DOM unless visually required.

## 2026-08-19 - Deferring API Calls using requestIdleCallback
**Learning:** Because the architecture fetches HTML fragments (`src/*.html`) dynamically and re-evaluates all their inner `<script>` tags immediately on insertion, any `fetch` calls or heavy logic in lower fragments (like footers or telemetry sections) will execute synchronously alongside critical LCP elements, blocking bandwidth and CPU. However, deferring based on `IntersectionObserver` causes tracking loss for users who bounce without scrolling.
**Action:** Always wrap non-critical telemetry `fetch` calls or background tracking in `requestIdleCallback` (with a fallback to `setTimeout`) so it doesn't block the main thread and LCP, but still reliably fires regardless of scroll position.

## 2026-08-24 - Optimizing FCP with Sequential Await of Concurrent Fetches
**Learning:** To optimize First Contentful Paint (FCP) when dynamically loading HTML components, awaiting `Promise.all()` blocks rendering until all fetches are complete.
**Action:** Ensure fetches are initiated concurrently but awaited sequentially (e.g., using a `for...of` loop on the fetch promises) so they render as soon as they resolve rather than blocking via `Promise.all()`.
