## 2024-05-24 - Improve Keyboard Accessibility & Focus
**Learning:** Adding keyboard support (tabindex + Enter/Space keys) and focus outlines to custom div-based interactive elements dramatically improves accessibility. When transforming non-semantic elements into interactive widgets, `role="button"` should also be added so screen readers announce it properly.
**Action:** Always verify `role="button"` on pseudo-interactive `div`s with `onclick` handlers when adding keyboard handlers and tabindex.
## 2026-08-13 - Missing Pointer Interaction on Keyboard-Accessible Elements
**Learning:** This app's components sometimes implement `role="button"` and `onkeydown` for screen readers/keyboards but completely miss the standard `onclick` attribute, making them inaccessible to mouse users who click on the container rather than specific child elements.
**Action:** Always check that custom interactive elements with `role="button"` have both `onclick` AND `onkeydown` bound to the same action to ensure unified interaction for all users.
