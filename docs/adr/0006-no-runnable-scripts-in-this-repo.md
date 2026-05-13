# ADR-0006: Scripts live in the user's vault, not in this repo

- **Status:** Accepted
- **Date:** 2026-05-13

## Context

A naive design would publish `Setup-Cursor-Memory.ps1` etc. in this repository and tell the user to `git clone && powershell -File Setup.ps1`. We deliberately do not do that.

Each install has different paths, users, and Cursor configurations. A script designed to be cloned and run is a maintenance burden: it has to detect environment, branch on Cursor versions, and accept user overrides. A script generated locally for that machine, with the agent observing the actual environment, sidesteps all of this.

## Decision

This repo publishes only:

- the operational prompt (`PROMPT_ULTRA_COMPLETO.md`),
- the human onboarding (`README.md`, `README.en.md`),
- machine-readable metadata (`AGENTS.md`, `manifest.json`, `schema.json`),
- community files (`CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`, `CHANGELOG.md`, `LICENSE`),
- supporting docs (`docs/`),
- anonymized examples (`examples/`),
- and CI configuration (`.github/`).

The prompt contains the literal text of every script inside fenced code blocks (section 8). The agent inside Cursor materializes those files inside `<VAULT_PATH>\scripts\windows\` on the user's machine.

The repo deliberately does **not** contain:

- a `scripts/` directory at the repo root,
- a `package.json` or any install step,
- any "clone and run" instructions.

## Alternatives considered

- **Ship scripts at the repo root.** Encourages users to `git clone` and run code straight from a public repo, which is the worst pattern for a system that creates scheduled tasks and modifies `mcp.json`.
- **Ship a binary installer.** Out of scope; would require signing and distribution infrastructure.
- **Ship scripts inside `examples/`.** Tempting, but users will copy them blindly and we will own the bugs.

## Consequences

- **Positive:** No fork or stale clone can drift from the intended behavior. The agent always materializes the current canonical version of each script from the prompt it just read.
- **Positive:** CI cannot run the scripts in isolation, but it can extract them from the prompt and lint them (`.github/scripts/extract-and-lint.ps1`), which is enough to catch syntax issues.
- **Negative:** Higher friction for power users who want to read raw `.ps1` files in a directory listing. Mitigation: the prompt section 8 displays them all verbatim.

## References

- `AGENTS.md` (root).
- `PROMPT_ULTRA_COMPLETO.md` section 8.
