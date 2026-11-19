# AI Agent Rules for VibeNVR Site

> **CRITICAL RULE**: AI Agents MUST NEVER autonomously commit or push changes to this repository. 
> You MUST exclusively use the `/site-telemetry-commit-push` workflow and wait for explicit permission from the USER before performing any `git commit` or `git push` operations.

## HTML & Image Guidelines

- **Image Aspect Ratio**: Whenever adding explicit `width` and `height` HTML attributes to `<img>` tags (e.g., for CLS prevention), if CSS or inline `style` overrides one dimension (e.g., `height: 200px;`), you **MUST** explicitly set the other dimension to `auto` (e.g., `width: auto;`) so the browser does not stretch or squash the image.
