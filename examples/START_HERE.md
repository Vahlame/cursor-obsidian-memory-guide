---
type: index
tags: [start, navigation, example]
status: active
created: 2026-05-13
updated: 2026-05-13
---

# START HERE (example)

This is a **fictional** vault index. Copy the idea, not the prose.

## Reading order for the agent

1. This file.
2. `MEMORY.md`.
3. `PROJECTS/<project>.md` for the active workspace.
4. On demand: `RULES/<project>.md`, sprint logs, runbooks, `KNOWN_FAILURES.md`, `TAGS.md`.

## Vault doctor

Run the script the real prompt generates:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\Documents\cursor-memory-vault\scripts\windows\Vault-Doctor.ps1" -WriteReview
```
