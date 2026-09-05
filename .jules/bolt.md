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

## 2026-08-27 - Sequential Rendering of Concurrent Fetches
**Learning:** Using `Promise.all()` to await dynamically loaded HTML components blocks rendering until *all* components are fetched, delaying First Contentful Paint (FCP).
**Action:** Initiate fetches concurrently but await them sequentially using a `for...of` loop over the promises. This allows earlier components (like the hero section) to render as soon as they resolve, drastically improving perceived load time.
## 2026-08-29 - Targeted Transitions and Will-Change Cleanup
**Learning:** Using `transition: all` globally across multiple components (like `.reveal`, `.btn`, and `.card`) forces the browser to animate *every* paint property change simultaneously. More critically, when used alongside `will-change` (to optimize initial paint on scroll reveal), leaving `will-change` active after an animation completes consumes excess composite memory and can break or override localized component transitions (such as hover states).
**Action:** When implementing scroll reveal animations, explicitly define the transition properties (e.g. `opacity`, `transform`), apply `will-change` strategically, and use an `IntersectionObserver` with a `setTimeout` cleanup to remove animation classes after completion. This frees compositor memory and restores native component interactive states.
## 2026-09-01 - Synchronizing Concurrent Rendering with Paint Cycles
**Learning:** Awaiting concurrent fetch promises sequentially using `for...of` can execute as a single Long Task if the network requests resolve almost instantly (e.g., from browser cache), preventing the browser from painting intermediate UI states.
**Action:** When sequentially rendering a batch of UI components fetched concurrently, use `await new Promise(resolve => requestAnimationFrame(resolve))` to explicitly yield the main thread and synchronize rendering with the browser's paint cycle, avoiding the 4ms penalty of `setTimeout(0)`.
## 2026-09-02 - Caching and Deferring Third-Party API Calls
**Learning:** Fetching data from external third-party APIs (like GitHub releases) directly on every page load causes unnecessary network overhead, introduces the risk of rate limiting, and can block the main thread if not deferred, delaying critical UI rendering (FCP/TTI).
**Action:** Always cache the results of non-critical third-party API calls in `sessionStorage` (or `localStorage`) to prevent redundant requests across page loads, and wrap the execution in `requestIdleCallback` (with a `setTimeout` fallback) to keep it off the main thread during initial load.
## 2026-09-04 - Caching Live Data Safely
**Learning:** Caching data from a "live" endpoint without invalidation completely breaks its purpose. Also, accessing `sessionStorage` can throw `SecurityError`s synchronously in restricted contexts.
**Action:** Always wrap `sessionStorage` and `localStorage` API calls in `try...catch` blocks to gracefully handle `SecurityError` crashes that occur in restricted environments (like embedded iframes). If the data represents live statistics, always implement a short Time-To-Live (TTL) (e.g., 5 minutes) cache invalidation check.
## 2026-09-05 - GPU-Accelerated Skeleton Animations
**Learning:** Animating `background-position` for shimmer effects on skeleton loaders forces the browser to recalculate layouts and repaint pixels continuously on the main thread, wasting CPU and battery power.
**Action:** Always implement shimmer animations using `transform: translateX` on a pseudo-element (e.g., `::after`), which allows the browser to offload the animation entirely to the GPU compositor thread without triggering main thread layouts or paints.
