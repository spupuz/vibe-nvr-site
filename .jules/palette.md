## 2024-05-14 - Redundant Screen Reader Announcements for Icons
**Learning:** Decorative icons (like `<ion-icon>`) nested inside interactive buttons can be redundantly announced by screen readers if the parent button already provides an accessible `aria-label`.
**Action:** Always add `aria-hidden="true"` to decorative icon elements nested inside interactive buttons to prevent redundant screen reader announcements when the parent button already provides an accessible `aria-label`.

## 2024-05-15 - Missing Active States for Interactive Elements
**Learning:** For mobile and pointer interactions, relying solely on CSS `:hover` and `:focus-visible` is insufficient. Adding an `:active` pseudo-class ensures immediate tactile visual feedback during tap or click events.
**Action:** Always pair CSS `:hover` and `:focus-visible` pseudo-classes with an `:active` state (e.g., via `transform` or `box-shadow` changes) to provide immediate tactile visual feedback for pointer and touch interactions.

## 2024-05-16 - Accessible Keyboard Shortcuts
**Learning:** For elements acting as custom buttons, such as interactive gallery items, missing `aria-label` and `title` attributes makes it harder for screen reader users and those navigating via keyboard to understand the action and available shortcuts.
**Action:** Append known keyboard shortcuts to the `title` attribute of custom interactive elements (e.g., 'View image (Enter)') to make hidden keyboard accessibility features discoverable to general users via native browser tooltips, and ensure proper `aria-label`s are added.

## 2024-05-18 - Mobile Menu In-Page Navigation Focus Restoration
**Learning:** Restoring focus to the triggering element (like a menu toggle button) when closing a modal or menu is standard practice for cancellations. However, it is an anti-pattern when the closure is triggered by a successful in-page navigation action (e.g. anchor link to a section), as it forcefully hijacks the user's focus flow back to the top of the page, interrupting their journey to the new section.
**Action:** When handling click events on navigation links that close a menu, conditionally skip restoring focus to the toggle button if the destination is an in-page anchor (`href.startsWith("#")`), allowing the browser's default anchor navigation focus handling to take over.
