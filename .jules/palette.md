## 2024-05-14 - Redundant Screen Reader Announcements for Icons
**Learning:** Decorative icons (like `<ion-icon>`) nested inside interactive buttons can be redundantly announced by screen readers if the parent button already provides an accessible `aria-label`.
**Action:** Always add `aria-hidden="true"` to decorative icon elements nested inside interactive buttons to prevent redundant screen reader announcements when the parent button already provides an accessible `aria-label`.

## 2024-05-15 - Missing Active States for Interactive Elements
**Learning:** For mobile and pointer interactions, relying solely on CSS `:hover` and `:focus-visible` is insufficient. Adding an `:active` pseudo-class ensures immediate tactile visual feedback during tap or click events.
**Action:** Always pair CSS `:hover` and `:focus-visible` pseudo-classes with an `:active` state (e.g., via `transform` or `box-shadow` changes) to provide immediate tactile visual feedback for pointer and touch interactions.

## 2024-05-16 - Accessible Keyboard Shortcuts
**Learning:** For elements acting as custom buttons, such as interactive gallery items, missing `aria-label` and `title` attributes makes it harder for screen reader users and those navigating via keyboard to understand the action and available shortcuts.
**Action:** Append known keyboard shortcuts to the `title` attribute of custom interactive elements (e.g., 'View image (Enter)') to make hidden keyboard accessibility features discoverable to general users via native browser tooltips, and ensure proper `aria-label`s are added.
