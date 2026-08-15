## 2024-05-24 - Improve Keyboard Accessibility & Focus
**Learning:** Adding keyboard support (tabindex + Enter/Space keys) and focus outlines to custom div-based interactive elements dramatically improves accessibility. When transforming non-semantic elements into interactive widgets, `role="button"` should also be added so screen readers announce it properly.
**Action:** Always verify `role="button"` on pseudo-interactive `div`s with `onclick` handlers when adding keyboard handlers and tabindex.
## 2026-08-13 - Missing Pointer Interaction on Keyboard-Accessible Elements
**Learning:** This app's components sometimes implement `role="button"` and `onkeydown` for screen readers/keyboards but completely miss the standard `onclick` attribute, making them inaccessible to mouse users who click on the container rather than specific child elements.
**Action:** Always check that custom interactive elements with `role="button"` have both `onclick` AND `onkeydown` bound to the same action to ensure unified interaction for all users.
## 2024-05-18 - Component-based Static App Accessibility Patterns
**Learning:** This app uses static component files fetched dynamically, so ARIA interactions crossing component boundaries (like mobile-toggle in header.html affecting nav-links) require careful JS state management in the shared scripts.html. Modal focus management must occur asynchronously to handle UI transitions safely.
**Action:** Always link ARIA controls by explicit IDs, rely on `setTimeout` when managing modal focus during dynamic DOM updates, and use JS to synchronize boolean attributes like `aria-expanded` when CSS classes toggle visibility.

## 2026-08-15 - Auto-Scroll Pause on Focus
**Learning:** This app's auto-advancing UI elements (like the gallery) paused on mouse hover (`mouseenter`/`mouseleave`) but did not pause for keyboard users navigating with Tab, violating WCAG 2.2.2 (Pause, Stop, Hide).
**Action:** Always pair `mouseenter`/`mouseleave` with `focusin`/`focusout` on auto-scrolling containers to ensure keyboard accessibility.
