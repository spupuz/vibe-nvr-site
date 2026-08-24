## 2024-05-24 - Improve Keyboard Accessibility & Focus
**Learning:** Adding keyboard support (tabindex + Enter/Space keys) and focus outlines to custom div-based interactive elements dramatically improves accessibility. When transforming non-semantic elements into interactive widgets, `role="button"` should also be added so screen readers announce it properly.
**Action:** Always verify `role="button"` on pseudo-interactive `div`s with `onclick` handlers when adding keyboard handlers and tabindex.
## 2026-08-13 - Missing Pointer Interaction on Keyboard-Accessible Elements
**Learning:** This app's components sometimes implement `role="button"` and `onkeydown` for screen readers/keyboards but completely miss the standard `onclick` attribute, making them inaccessible to mouse users who click on the container rather than specific child elements.
**Action:** Always check that custom interactive elements with `role="button"` have both `onclick` AND `onkeydown` bound to the same action to ensure unified interaction for all users.
## 2024-05-18 - Component-based Static App Accessibility Patterns
**Learning:** This app uses static component files fetched dynamically, so ARIA interactions crossing component boundaries (like mobile-toggle in header.html affecting nav-links) require careful JS state management in the shared scripts.html. Modal focus management must occur asynchronously to handle UI transitions safely.
**Action:** Always link ARIA controls by explicit IDs, rely on `setTimeout` when managing modal focus during dynamic DOM updates, and use JS to synchronize boolean attributes like `aria-expanded` when CSS classes toggle visibility.
## 2026-08-16 - Adding native tooltips to icon-only buttons
**Learning:** Icon-only buttons often include an `aria-label` for screen readers, but sighted mouse/pointer users can still be confused about the button's purpose without a visual tooltip.
**Action:** When adding or auditing icon-only buttons with `aria-label`, also ensure they include a native `title` attribute so that standard browser tooltips appear on hover, bridging the gap between accessibility and general UX.

## 2026-08-15 - Auto-Scroll Pause on Focus
**Learning:** This app's auto-advancing UI elements (like the gallery) paused on mouse hover (`mouseenter`/`mouseleave`) but did not pause for keyboard users navigating with Tab, violating WCAG 2.2.2 (Pause, Stop, Hide).
**Action:** Always pair `mouseenter`/`mouseleave` with `focusin`/`focusout` on auto-scrolling containers to ensure keyboard accessibility.
## 2026-08-17 - Focus Restoration on Modal Close
**Learning:** When creating custom modal dialogs (like the lightbox), focusing an element inside the dialog on open is good for screen readers, but failing to restore focus to the triggering element when the dialog closes causes the focus order to reset to the start of the document, disorienting keyboard users.
**Action:** Always save `document.activeElement` before opening a modal and call `.focus()` on it during the modal's close routine to maintain a logical and continuous focus order.
## 2026-08-24 - Escape Key Dismissal & Focus Restoration for Mobile Menus
**Learning:** Similar to lightboxes and modals, custom mobile navigation menus built as overlays often trap keyboard users if they cannot be dismissed with the Escape key. Failing to restore focus to the menu toggle button after dismissal also causes disorientation.
**Action:** Always ensure custom overlays and menus listen for the Escape key to close, and explicitly call `.focus()` on the triggering element to maintain logical tab order.
