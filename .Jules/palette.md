## 2024-05-14 - Redundant Screen Reader Announcements for Icons
**Learning:** Decorative icons (like `<ion-icon>`) nested inside interactive buttons can be redundantly announced by screen readers if the parent button already provides an accessible `aria-label`.
**Action:** Always add `aria-hidden="true"` to decorative icon elements nested inside interactive buttons to prevent redundant screen reader announcements when the parent button already provides an accessible `aria-label`.

## 2024-05-15 - Missing Active States for Interactive Elements
**Learning:** For mobile and pointer interactions, relying solely on CSS `:hover` and `:focus-visible` is insufficient. Adding an `:active` pseudo-class ensures immediate tactile visual feedback during tap or click events.
**Action:** Always pair CSS `:hover` and `:focus-visible` pseudo-classes with an `:active` state (e.g., via `transform` or `box-shadow` changes) to provide immediate tactile visual feedback for pointer and touch interactions.
## 2024-05-24 - Accessibility for Image-Only Links
**Learning:** Anchor tags (`<a>`) that exclusively contain images or decorative icons (such as GitHub stat badges or 'Buy Me A Coffee' buttons) can lack context for screen readers and missing tooltips for mouse users, making them less accessible and discoverable.
**Action:** Always add explicit `aria-label` and `title` attributes to such anchor tags to ensure they are fully accessible to screen readers and offer descriptive tooltips for all users.

## 2026-09-21 - Accessibility for Dynamically Generated Icons
**Learning:** Decorative icons (like `<ion-icon>`) that are dynamically generated via JavaScript and injected into the DOM may lack the `aria-hidden="true"` attribute if not explicitly set during creation, causing screen readers to announce them redundantly.
**Action:** Always ensure that dynamically created decorative elements have `aria-hidden="true"` explicitly set via `setAttribute` before appending them to the DOM.
