## 2026-08-11 - [Reverse Tabnabbing]
**Vulnerability:** External links opened in a new tab without rel="noopener noreferrer" could potentially hijack the original page via the window.opener object.
**Learning:** Found in standard anchor tags with target="_blank" that redirect to external documentation or GitHub links.
**Prevention:** Always add rel="noopener noreferrer" to a tags when target="_blank" is used to open external resources.
