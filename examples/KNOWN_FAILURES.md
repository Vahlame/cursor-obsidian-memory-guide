---
type: failure
tags: [anti-patterns, example]
status: active
created: 2026-05-13
updated: 2026-05-13
---

# KNOWN FAILURES (example)

One entry per discarded idea: date, context, and the path that actually won.

## 2026-01-01 — Example: dynamic backend port

**Idea:** pick a random free TCP port for the local API every boot.

**Why discarded:** breaks stable `mcp.json` and browser allowlists; adds discovery complexity.

**What we did instead:** fixed port + documented override in `.env.local`.
