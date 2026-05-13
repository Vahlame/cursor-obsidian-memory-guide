# ADR-0007: Windows-first; other platforms via separate prompt variants

- **Status:** Accepted
- **Date:** 2026-05-13

## Context

The author's day-to-day machine is Windows. The first end-to-end successful install of this pattern was on Windows. Many of the design decisions (Task Scheduler, VBS shim, PowerShell 5.1-compatible JSON merge, `%USERPROFILE%`) are Windows-specific.

We could try to write one prompt that handles all three platforms, but doing so would either:

- multiply the size and conditional branching of the prompt (and prompt size already matters for the agent's attention budget), or
- ship a lowest-common-denominator design that does not feel native on any platform.

## Decision

The canonical prompt is Windows-only. Cross-platform support is provided, when added, by a dedicated file:

- `PROMPT_ULTRA_COMPLETO.macos.md` (uses `launchd`, `nohup`, `~/Library/Application Support`).
- `PROMPT_ULTRA_COMPLETO.linux.md` (uses `systemd --user`, `~/.config`).

Each variant is independently testable and independently versioned. The README explicitly states "Windows-first" and links to whichever variants exist.

## Alternatives considered

- **One monolithic prompt with `if Windows / if macOS / if Linux` branches.** Doubles the size, increases the chance the agent picks the wrong branch.
- **Drop the promise of cross-platform.** Considered, but Linux/macOS users are a significant fraction of Cursor's audience and the pattern is fundamentally portable.

## Consequences

- **Positive:** Each variant feels native and can be reviewed by maintainers familiar with that platform.
- **Negative:** Three documents to keep in sync if a structural change happens. Mitigation: tag releases together and use a shared `docs/adr/` so design decisions only need one source of truth.
- **Neutral:** Until macOS / Linux variants exist, those users either translate the Windows variant themselves or wait. README is honest about this.

## References

- `PROMPT_ULTRA_COMPLETO.md` section 1; section 13 ("este flujo es Windows-first").
- `README.md` section "Sistemas operativos".
