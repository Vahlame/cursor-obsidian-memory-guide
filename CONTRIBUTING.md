# Contributing

Thanks for considering a contribution. This repository contains a single operational artifact (`PROMPT_ULTRA_COMPLETO.md`) plus supporting docs. Changes are welcome, but the bar is high because this prompt runs on other people's machines.

## What this repo is and is not

- **Is:** an executable prompt that another agent (Cursor) reads and acts on, plus the docs to understand it.
- **Is not:** a runnable project. There is no install step. Do not add a `package.json`, build system, or scripts you expect users to clone and run. Scripts must continue to live inside the prompt as literal text blocks that the agent will materialize on the user's machine.

## Before you open a PR

1. Read `AGENTS.md` and `PROMPT_ULTRA_COMPLETO.md` end to end. The design decisions in section 4 of the prompt are deliberate; do not undo them without an ADR (`docs/adr/`).
2. Test your change on a real Windows machine. The prompt is Windows-first; cross-platform suggestions go in a separate file, not in the main prompt.
3. Run the local checks below.

## Local checks

```bash
# Markdown lint
npx markdownlint-cli "**/*.md" --ignore node_modules

# JSON formatting
npx prettier --check "**/*.json"

# Link check
npx lychee --no-progress --exclude-mail .

# Extract embedded PowerShell from the prompt and lint with PSScriptAnalyzer
pwsh -File .github/scripts/extract-and-lint.ps1
```

All four must pass. CI runs the same checks on every PR.

## Types of changes

| Change | Where it goes | Needs an ADR? |
|---|---|---|
| Typo, wording, clarification | the file in question | no |
| Script fix inside the prompt | `PROMPT_ULTRA_COMPLETO.md` section 8 | no (mention in CHANGELOG) |
| Known-error addition | `PROMPT_ULTRA_COMPLETO.md` section 11 + `docs/troubleshooting.md` | no |
| New design decision | new file in `docs/adr/` + update section 4 | **yes** |
| New platform support (macOS, Linux) | new file `PROMPT_ULTRA_COMPLETO.<os>.md` | yes |
| Breaking change to prompt structure | discuss in an issue first | yes |

## Commit messages

Use imperative mood, lowercase, no trailing period, under 72 chars. Look at recent commits for style:

```text
harden ultra prompt: 7 fixes for real-world gaps
trim repo to prompt + readme; agent generates scripts locally
```

## Releasing

The maintainer cuts releases. The release process is:

1. Update `CHANGELOG.md` (Keep a Changelog format).
2. Bump version in `manifest.json` -> `version`.
3. Tag `vX.Y.Z` and push.
4. GitHub Actions publishes a Release with notes copied from `CHANGELOG.md`.

SemVer interpretation for this repo:

- **MAJOR**: prompt section numbers change, or the agent contract breaks (e.g., a new mandatory parameter the user must provide).
- **MINOR**: new optional sections, new scripts, new docs, new known-error entries.
- **PATCH**: typos, wording, internal cleanups.

## Security

Do not include secrets, tokens, or real user paths in PRs. See `SECURITY.md` for how to report vulnerabilities.

## License

By contributing you agree your contribution is licensed under the MIT License.
