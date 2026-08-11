## 2024-05-24 - Improve Keyboard Accessibility & Focus
**Learning:** Adding keyboard support (tabindex + Enter/Space keys) and focus outlines to custom div-based interactive elements dramatically improves accessibility. When transforming non-semantic elements into interactive widgets, `role="button"` should also be added so screen readers announce it properly.
**Action:** Always verify `role="button"` on pseudo-interactive `div`s with `onclick` handlers when adding keyboard handlers and tabindex.
