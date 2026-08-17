## 2026-08-11 - [Reverse Tabnabbing]
**Vulnerability:** External links opened in a new tab without rel="noopener noreferrer" could potentially hijack the original page via the window.opener object.
**Learning:** Found in standard anchor tags with target="_blank" that redirect to external documentation or GitHub links.
**Prevention:** Always add rel="noopener noreferrer" to a tags when target="_blank" is used to open external resources.
## 2026-08-15 - [Missing Content Security Policy]
**Vulnerability:** The application was lacking a Content Security Policy (CSP), which is a critical defense-in-depth mechanism to mitigate Cross-Site Scripting (XSS) and other data injection attacks.
**Learning:** The project relies on multiple external CDNs (jsdelivr, unpkg, google fonts) and a telemetry worker, which increases the attack surface if any third-party is compromised or if XSS is introduced.
**Prevention:** Always implement a strict Content-Security-Policy meta tag or HTTP header to restrict resource loading to trusted domains and prevent unauthorized framing or object loading.
## 2026-08-17 - [XSS via DOM-based InnerHTML]
**Vulnerability:** DOM-based Cross-Site Scripting (XSS) via `innerHTML` and dynamically executing scripts. The `index.html` loads component HTML directly and assigns it to `container.innerHTML`, and explicitly executes loaded `<script>` tags without sanitization. In `src/telemetry.html`, fetched JSON data is injected using `innerHTML`.
**Learning:** Using `innerHTML` with dynamically fetched content, especially when it re-evaluates `<script>` tags, bypasses normal security protections and creates a direct vector for XSS if the source (even if local or from a trusted API) is compromised.
**Prevention:** Avoid `innerHTML` for dynamic content rendering. If dynamic HTML insertion is required, use a sanitizer like DOMPurify before insertion, and never blindly execute dynamically loaded `<script>` tags. Use `textContent` where plain text is expected.
