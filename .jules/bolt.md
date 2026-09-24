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
## 2026-09-06 - Batching DOM Insertions with DocumentFragment
**Learning:** Appending multiple elements to the DOM synchronously within a loop (e.g., dynamically re-evaluating \`<script>\` tags) causes multiple layout recalculations and repaints, which blocks the main thread and impacts First Contentful Paint (FCP) and Time to Interactive (TTI).
**Action:** When inserting multiple dynamic elements into the DOM, use a \`DocumentFragment\` to batch the insertions instead of appending them sequentially in a loop, minimizing synchronous DOM mutations.
## 2026-09-06 - Deferred Data Fetching via IntersectionObserver vs requestIdleCallback
**Learning:** Using `requestIdleCallback` inside dynamically loaded and re-evaluated script tags forces data fetches (like telemetry or footer version tags) to run as soon as the main thread is briefly idle after the fragment is injected. This can still steal CPU and network bandwidth early in the page lifecycle if the user hasn't scrolled. While `requestIdleCallback` is good for background tasks that *must* run (like tracking pixels), it is poor for fetching data intended for UI that is far below the fold.
**Action:** When fetching data specifically meant to populate UI elements located far below the fold (like footer versions or telemetry dashboards), use `IntersectionObserver` with a `rootMargin` (e.g., `200px`) to defer the fetch until the user actually scrolls near the content. This significantly reduces initial network contention and CPU load.
## 2026-09-09 - Targeted Transitions and Will-Change Cleanup (Addendum)
**Learning:** Implicit `transition: 0.3s;` expands to `transition: all 0.3s`, forcing the browser to animate every property and causing unnecessary global paint recalculations. Furthermore, leaving `will-change: opacity, transform` statically on common elements like `.btn` without cleanup wastes compositor memory permanently.
**Action:** When creating hover transitions, explicitly specify the target properties (e.g. `transition: transform 0.2s, box-shadow 0.2s, background-color 0.2s;`). Never leave `will-change` statically applied in CSS on interactive elements unless heavily justified.
## 2026-09-10 - Preventing Layout Thrashing in Intervals
**Learning:** Querying layout properties like `clientWidth` or `scrollWidth` directly inside a `setInterval` or `requestAnimationFrame` forces the browser to synchronously recalculate layout (reflow) on every tick, drastically increasing CPU overhead and blocking the main thread even when no changes have occurred.
**Action:** When implementing frequent visual updates (like an auto-scrolling gallery), always cache layout properties outside of the update loop. Use a `resize` event listener (and `load` listeners for images) to keep the cache accurate without querying the DOM directly on every animation frame.
## 2026-09-11 - Caching DOM Queries in High-Frequency Events
**Learning:** Querying the DOM (e.g., `querySelector`) repeatedly inside event listeners that fire frequently, such as `resize` or image `load` events, incurs unnecessary overhead.
**Action:** Cache the result of DOM queries the first time they are needed and reuse the cached reference in subsequent invocations of the event listener to avoid repeated DOM traversal.
## 2026-09-14 - Early Returns in High-Frequency Listeners
**Learning:** Even when DOM queries inside high-frequency event listeners (like `keydown`) are cached, executing any logic on irrelevant events (like typing any character) wastes CPU cycles.
**Action:** Always implement an early return (e.g., `if (event.key !== 'Escape' && event.key !== 'Tab') return;`) at the very beginning of the listener to completely skip unnecessary processing and variable evaluation for irrelevant events.
## 2026-09-20 - Debouncing High-Frequency Layout Queries
**Learning:** Caching DOM layout properties like `clientWidth` outside an interval is good, but querying them synchronously on every tick of high-frequency events (like `resize` or multiple image `load`s) can still cause synchronous layout thrashing and CPU spikes.
**Action:** When updating a layout cache based on high-frequency events (`resize`, image `load`), wrap the querying function in a debounce timeout (e.g. 150ms). This prevents the browser from repeatedly recalculating the layout while the event is still actively firing, drastically improving performance.
## 2026-09-24 - Strict DOM Query Caching in High-Frequency Keydown Traps
**Learning:** Querying the DOM dynamically (like building arrays of elements via `querySelectorAll`) inside a `keydown` trap listener (e.g. for `Tab` key focus trapping) forces the browser to traverse the DOM tree on every single key press. If the user holds down the `Tab` key, this causes repeated, unnecessary, and synchronous DOM traversals.
**Action:** While keeping the logic resilient to DOM changes is important, strictly cache expensive DOM queries or NodeLists outside of high-frequency execution paths where possible. Re-evaluating `querySelectorAll` on every `Tab` keystroke is a performance anti-pattern.
## 2026-09-24 - Strict Layout Reads and Writes in RequestAnimationFrame
**Learning:** Querying layout properties like `window.scrollY` directly inside `requestAnimationFrame` can cause layout thrashing and scroll jank, as the read operation gets mixed with write operations from other frames or components.
**Action:** Always read layout properties outside of the `requestAnimationFrame` block in high-frequency event listeners (like `scroll`) and pass the cached value into the callback to ensure read/write operations are strictly separated.
## 2026-09-24 - Avoiding Stale Closures When Debouncing Layout Reads
**Learning:** When separating layout reads (like `window.scrollY`) from writes (`requestAnimationFrame`) inside a debounced or throttled event listener (using an `isTicking` flag), placing the read *outside* the flag captures a state that gets discarded. This causes the UI to update with a stale layout value on the next frame.
**Action:** When throttling high-frequency events using `isTicking` and `requestAnimationFrame`, always perform the layout read *inside* the `if (!isTicking)` block but *outside* the `requestAnimationFrame` callback to ensure the most recent non-discarded value is used without layout thrashing.
## 2026-09-24 - Strict DOM Query Caching in High-Frequency Keydown Traps
**Learning:** Querying the DOM dynamically (like building arrays of elements via `querySelectorAll`) inside a `keydown` trap listener (e.g. for `Tab` key focus trapping) forces the browser to traverse the DOM tree on every single key press. If the user holds down the `Tab` key, this causes repeated, unnecessary, and synchronous DOM traversals.
**Action:** While keeping the logic resilient to DOM changes is important, strictly cache expensive DOM queries or NodeLists outside of high-frequency execution paths where possible. Re-evaluating `querySelectorAll` on every `Tab` keystroke is a performance anti-pattern.
