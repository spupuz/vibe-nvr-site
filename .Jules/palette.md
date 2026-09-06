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
## 2026-08-27 - Consistent Visual Feedback for Keyboard Navigation
**Learning:** While CSS `:hover` states provide good visual feedback for mouse users, keyboard users often lack this feedback if focus indicators aren't explicitly styled. Interactive elements should provide consistent feedback regardless of the input method.
**Action:** Always ensure that CSS interactive pseudo-classes (e.g., `:hover`) are paired with their keyboard equivalents (e.g., `:focus-visible`) to provide consistent visual feedback across all input methods.
## 2026-03-05 - Mobile Menu Accessibility
**Learning:** Custom mobile menus (like modal dialogs) require careful focus management. When a menu opens, focus should move into the menu so keyboard users don't tab through hidden page content. Crucially, when the menu closes via Escape, overlay click, or link click, focus must be restored to the triggering element (the menu button) to prevent the browser from resetting focus to the top of the document.
**Action:** Always implement `Escape` key dismissal and explicitly track and restore `lastFocusedElement` for any custom full-screen overlay menus or modals.
## 2024-05-25 - Skip to Content Implementation for Screen Readers & Keyboard
**Learning:** Adding a visually hidden "Skip to content" link that becomes visible on focus ensures keyboard users and screen readers can bypass repetitive navigation blocks (like headers). Providing the target `<main>` element with `tabindex="-1"` and removing its outline on focus ensures focus shifts properly without an undesirable visual focus ring around the whole page. The targeted `<main>` element strictly wraps only the unique page content, explicitly excluding repetitive navigation components like headers and footers.
**Action:** Always include a skip-to-content link targeting the `<main>` area for accessibility, pairing `.sr-only` and `.sr-only-focusable` classes to handle focus visibility properly.

## 2024-05-26 - Missing Tactile Active States on Interactive Elements
**Learning:** While CSS `:hover` states provide feedback for mouse users and `:focus-visible` for keyboard users, touch screen users or mouse users actively clicking lack immediate tactile visual feedback without a corresponding `:active` state.
**Action:** Always pair CSS `:hover` and `:focus-visible` pseudo-classes with an `:active` state (e.g., via `transform: translateY(0)` or `scale(0.95)`) to provide immediate tactile visual feedback during the mousedown or touch interaction phase.
## 2024-05-27 - Preventing Keyboard Traps in Overlay Menus and Modals
**Learning:** Even if a modal (like a lightbox or mobile menu) is visually overlaid on top of the entire screen and sets `aria-modal="true"`, keyboard users can still press `Tab` and navigate to focusable background elements underneath the modal if focus is not explicitly trapped. This causes confusion because they end up interacting with hidden elements.
**Action:** Always implement a JavaScript focus trap for modals and fullscreen overlays. Listen for the `Tab` key during the active state, determine the first and last focusable elements within the container, and use `event.preventDefault()` combined with explicit `.focus()` calls to loop the focus back inside the modal (handling `Shift+Tab` as well). If there is only one focusable element (e.g., a single close button), simply prevent default `Tab` behavior and keep focus on that element.
