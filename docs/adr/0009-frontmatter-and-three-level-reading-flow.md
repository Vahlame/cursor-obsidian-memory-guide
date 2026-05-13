# ADR-0009: Default vault layout with YAML frontmatter and a three-level reading flow

## Status

Accepted

## Context

Early installs created only `MEMORY.md`, `SESSION_LOG.md`, `PROJECTS/`, and `SNIPPETS/`. Agents had no single entry note, no index of tags, no place for "do not repeat" anti-patterns, and no dedicated folder for per-project hard rules. User Rules in Cursor pointed agents straight at `MEMORY.md` and `PROJECTS/<proyecto>.md`, which encouraged over-reading small vaults and under-reading structured sub-notes (`SPRINTS`, `RUNBOOK`).

## Decision

1. **New default files at vault root** (created on setup if missing):
   - `START_HERE.md` — navigation map and reading order for agents.
   - `TAGS.md` — minimal reference for `type:` and common `tags:` in frontmatter.
   - `KNOWN_FAILURES.md` — append-only log of discarded approaches (optional but scaffolded).
   - `.gitignore` — ignore secrets, backups, ephemeral `REVIEW_*.md`, noisy Obsidian workspace JSON, logs.
2. **New folder** `RULES/` with `.gitkeep` so Git tracks it; per-project rules live at `RULES/<proyecto>.md`.
3. **Remove `SNIPPETS/`** from the default scaffold (it often stayed empty; users can recreate if needed).
4. **YAML frontmatter** on scaffolded markdown (`---` / `type`, `tags`, `status`, `created`, `updated`) so `Vault-Doctor` can measure coverage and humans get consistent metadata in Obsidian.
5. **User Rules (section 9 of the prompt)** describe a **three-level flow**:
   - Level 0: always read `START_HERE.md` and detect project.
   - Level 1: always read `MEMORY.md` and `PROJECTS/<proyecto>.md` before proposing changes.
   - Level 2: read `RULES`, `SPRINTS`, `RUNBOOK`, `KNOWN_FAILURES`, `TAGS` only when the task requires them.
6. **Legacy vaults** (clone from an older machine): setup remains idempotent — missing files are added without deleting user content.

## Consequences

- Slightly larger initial vault; better agent ergonomics and measurable hygiene.
- Agents following User Rules do a tiny bit more I/O at task start (`START_HERE.md`), offset by less accidental full-vault reads.

## Alternatives considered

- **Require frontmatter for every note from day one** — rejected as too strict for migrated vaults; `Vault-Doctor` warns instead of failing on coverage.
- **Keep `SNIPPETS/`** — rejected for the default scaffold to avoid empty tracked directories; users may add the folder manually.
