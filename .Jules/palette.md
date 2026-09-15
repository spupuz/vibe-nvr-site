## 2024-05-14 - Redundant Screen Reader Announcements for Icons
**Learning:** Decorative icons (like `<ion-icon>`) nested inside interactive buttons can be redundantly announced by screen readers if the parent button already provides an accessible `aria-label`.
**Action:** Always add `aria-hidden="true"` to decorative icon elements nested inside interactive buttons to prevent redundant screen reader announcements when the parent button already provides an accessible `aria-label`.
