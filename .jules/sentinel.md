## 2026-08-11 - [Reverse Tabnabbing]
**Vulnerability:** External links opened in a new tab without rel="noopener noreferrer" could potentially hijack the original page via the window.opener object.
**Learning:** Found in standard anchor tags with target="_blank" that redirect to external documentation or GitHub links.
**Prevention:** Always add rel="noopener noreferrer" to a tags when target="_blank" is used to open external resources.

## 2024-05-24 - [Missing Content Security Policy]
**Vulnerability:** The application was missing a Content Security Policy (CSP), leaving it vulnerable to potential Cross-Site Scripting (XSS) and data injection attacks if malicious content were to be injected.
**Learning:** Found that the static HTML index file lacked a CSP meta tag, meaning the browser would execute any script injected into the page.
**Prevention:** Always include a strong Content Security Policy header or meta tag to restrict the sources of scripts, styles, fonts, and images to known safe origins.
