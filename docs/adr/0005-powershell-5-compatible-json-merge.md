# ADR-0005: Use PowerShell 5.1-compatible JSON merging

- **Status:** Accepted
- **Date:** 2026-05-13

## Context

The setup script must merge a new `obsidian-memory` entry into an existing `%USERPROFILE%\.cursor\mcp.json` that may already declare Linear, Supabase, or other MCP servers. We must NOT clobber the user's other servers.

PowerShell 7 has `ConvertFrom-Json -AsHashtable`, which makes the merge trivial. PowerShell 5.1 (the default on Windows 10 and many Windows 11 installs) does not. Iterating properties of an empty `[pscustomobject]` under `Set-StrictMode -Version Latest` throws.

## Decision

- Parse with plain `ConvertFrom-Json` (works on 5.1).
- Build merged data in `[ordered]@{}` hashtables, which iterate safely.
- Convert to `[pscustomobject]` only at serialization time, immediately before `ConvertTo-Json -Depth 20`.
- Always create a `.bak` of the existing `mcp.json` before writing.
- Iterate properties via `$obj.PSObject.Properties` rather than direct member access, to survive `StrictMode`.

## Alternatives considered

- **Require PowerShell 7.** Pushes a winget install onto every user before they can start. Bad UX.
- **Use jq.** Adds another dependency, and not present by default on Windows.
- **Naive replace of the `obsidian-memory` block via regex.** Brittle, breaks on whitespace differences.

## Consequences

- **Positive:** Works on every Windows build the project targets. Robust to malformed or empty input.
- **Negative:** The merge code is verbose (about 30 lines in `Setup-Cursor-Memory.ps1`).
- **Neutral:** Output is pretty-printed by `ConvertTo-Json` which slightly reformats user-edited files. Acceptable; `.bak` keeps the original.

## References

- `PROMPT_ULTRA_COMPLETO.md` section 4, item 5; section 6.4; section 8.1.
