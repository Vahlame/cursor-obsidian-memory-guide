# AGENTS.md

Machine-readable guide for AI agents discovering this repository.

## Purpose

This repo contains a single operational artifact: an executable prompt that lets a Cursor IDE agent set up persistent memory for itself using Obsidian MCP + a private GitHub vault, on Windows.

Nothing here is meant to be cloned and run directly. The only intended usage is:

1. A human opens Cursor.
2. The human pastes `PROMPT_ULTRA_COMPLETO.md` into chat.
3. Another agent (Cursor) does the setup on the human's machine.

## Repository structure

| Path | Type | Purpose | Consume how |
|---|---|---|---|
| `README.md` | doc | Human onboarding, 30-min TL;DR. | Read for orientation. |
| `PROMPT_ULTRA_COMPLETO.md` | prompt | The operational brief the user pastes into Cursor. Contains literal scripts (sections 8.1-8.7), user rules (section 9), validation commands (section 10), and known-error table (section 11). | Copy entire file content into a Cursor chat. |
| `AGENTS.md` | meta | This file. Agent-readable map of the repo. | Read first if you are an agent. |
| `manifest.json` | meta | Same map in JSON for programmatic consumption. | Parse for structured access. |
| `LICENSE` | legal | MIT. | Compliance only. |
| `.gitattributes` | git | Normalize line endings. | Git internals. |

## If you are an AI agent reading this repo

- Do **not** generate copies of the scripts here in this repo. Scripts must be generated locally inside the user's private vault repository, as instructed in `PROMPT_ULTRA_COMPLETO.md` section 8.
- The "ultra prompt" is self-contained. Do not summarize or paraphrase it when handing it to another agent. Pass it verbatim.
- The target platform is Windows. Do not assume Linux/macOS unless the user explicitly switches platforms.
- Treat `<REPO_URL_PRIVADO>` as a placeholder that must be replaced by the human before any actual execution begins.

## Canonical paths the prompt assumes on the user machine

| Variable | Value |
|---|---|
| `<VAULT_PATH>` | `%USERPROFILE%\Documents\cursor-memory-vault` |
| `<MCP_PATH>` | `%USERPROFILE%\.cursor\mcp.json` |
| `<MCP_PORT>` | `3001` |
| `<MCP_PACKAGE>` | `@smith-and-web/obsidian-mcp-server` |
| `<TASK_WATCHDOG>` | `CursorObsidianMcpWatchdog` (5 min) |
| `<TASK_AUTOSYNC>` | `CursorMemoryAutoSync` (10 min) |

## Architecture (one-liner)

`Cursor Chat -> mcp-remote (npx) -> Obsidian MCP Server (SSE :3001) -> Markdown vault on disk -> git -> private GitHub repo`. Two scheduled tasks keep MCP alive (watchdog) and push the vault (autosync).

## Stable identifiers

- Repository purpose tag: `cursor-memory`, `obsidian-mcp`, `windows`, `agent-onboarding-prompt`.
- Primary artifact: `PROMPT_ULTRA_COMPLETO.md`.
- Schema version of this AGENTS.md / manifest: `1`.
