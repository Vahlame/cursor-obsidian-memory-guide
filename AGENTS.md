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
| `README.md` / `README.en.md` | doc | Human onboarding, 30-min TL;DR (ES / EN). | Read for orientation. |
| `PROMPT_ULTRA_COMPLETO.md` | prompt | The operational brief the user pastes into Cursor. Contains literal scripts (sections 8.1-8.12), user rules (section 9), validation commands (section 10), and known-error table (section 11). | Copy entire file content into a Cursor chat. |
| `AGENTS.md` | meta | This file. Agent-readable map of the repo. | Read first if you are an agent. |
| `manifest.json` | meta | Same map in JSON for programmatic consumption. | Parse for structured access. |
| `schema.json` | meta | JSON Schema for `manifest.json`. | Use for validation. |
| `CHANGELOG.md` | doc | Versioned history (Keep a Changelog). | Read for what changed and when. |
| `CONTRIBUTING.md` | doc | Contribution guidelines, local checks, release process. | Read before editing. |
| `SECURITY.md` | doc | Vulnerability reporting policy. | Read before disclosing issues. |
| `CODE_OF_CONDUCT.md` | doc | Contributor Covenant 2.1. | Community standards. |
| `docs/adr/` | doc | Architecture Decision Records mirroring section 4 of the prompt. | Read for the "why" behind a design choice. |
| `docs/troubleshooting.md` | doc | Standalone, indexable troubleshooting reference. | Search for an exact error message. |
| `docs/faq.md` | doc | Common questions about the pattern. | Skim. |
| `docs/glossary.md` | doc | Definitions of MCP, SSE, vault, watchdog, mcp-remote, etc. | Look up unknown terms. |
| `docs/comparison.md` | doc | This pattern vs. Cursor built-in memory, mem0, Letta, custom RAG. | Read when justifying the design. |
| `examples/` | example | Anonymized sample vault (MEMORY.md, SESSION_LOG.md, PROJECTS/example-app.md). | Use as a template. |
| `.github/` | ci | Issue / PR templates, CI workflows, dependabot. | Tooling. |
| `LICENSE` | legal | MIT. | Compliance only. |
| `.editorconfig`, `.markdownlint.json`, `.prettierrc`, `.gitignore`, `.lycheeignore`, `.gitattributes` | config | Local tooling configuration. | Honor when editing. |

## If you are an AI agent reading this repo

- Do **not** generate copies of the scripts here in this repo. Scripts must be generated locally inside the user's private vault repository, as instructed in `PROMPT_ULTRA_COMPLETO.md` section 8. See ADR-0006.
- The "ultra prompt" is self-contained. Do not summarize or paraphrase it when handing it to another agent. Pass it verbatim.
- The target platform is Windows. Do not assume Linux/macOS unless the user explicitly switches platforms. See ADR-0007.
- Treat `<REPO_URL_PRIVADO>` as a placeholder that must be replaced by the human before any actual execution begins.
- Before changing a design decision, write an ADR in `docs/adr/`. The prompt's section 4 is the surface; the ADRs are the source of truth.

## Canonical paths the prompt assumes on the user machine

| Variable | Value |
|---|---|
| `<VAULT_PATH>` | `%USERPROFILE%\Documents\cursor-memory-vault` |
| `<MCP_PATH>` | `%USERPROFILE%\.cursor\mcp.json` |
| `<MCP_PORT>` | `3001` |
| `<MCP_PACKAGE>` | `@smith-and-web/obsidian-mcp-server@^0.1.0` |
| `<LOG_DIR>` | `%LOCALAPPDATA%\cursor-memory\logs` |
| `<TASK_WATCHDOG>` | `CursorObsidianMcpWatchdog` (5 min) |
| `<TASK_AUTOSYNC>` | `CursorMemoryAutoSync` (10 min) |

## Architecture (one-liner)

`Cursor Chat -> mcp-remote (npx) -> Obsidian MCP Server (SSE :3001) -> Markdown vault on disk -> git -> private GitHub repo`. Two scheduled tasks keep MCP alive (watchdog) and push the vault (autosync). Logging goes to `%LOCALAPPDATA%\cursor-memory\logs\`. Uninstall and Repair scripts are reversible and idempotent.

## Stable identifiers

- Repository purpose tags: `cursor-memory`, `obsidian-mcp`, `windows`, `agent-onboarding-prompt`.
- Primary artifact: `PROMPT_ULTRA_COMPLETO.md`.
- Manifest schema: `schema.json` (`schemaVersion: 1`).
- Current prompt version: `1.1.0` (see `CHANGELOG.md`).
