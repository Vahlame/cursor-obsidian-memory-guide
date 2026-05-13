<!--
Thanks for the PR. Please fill in the blanks below.
Keep PRs focused: one change per PR.
-->

## Summary

<!-- What does this PR change and why? 1-3 sentences. -->

## Type of change

- [ ] Typo / wording / clarification
- [ ] Script fix inside the prompt (section 8)
- [ ] New known-error entry (section 11 + `docs/troubleshooting.md`)
- [ ] New design decision (includes ADR in `docs/adr/`)
- [ ] New platform variant (`PROMPT_ULTRA_COMPLETO.<os>.md`)
- [ ] Docs only
- [ ] CI / tooling

## Validation

- [ ] `npx markdownlint-cli "**/*.md" --ignore node_modules` passes
- [ ] `npx prettier --check "**/*.json"` passes
- [ ] `npx lychee --no-progress --exclude-mail .` passes
- [ ] `pwsh -File .github/scripts/extract-and-lint.ps1` passes
- [ ] I updated `CHANGELOG.md` under `[Unreleased]`
- [ ] If this is a breaking change, I bumped MAJOR in `manifest.json`

## Tested on

<!-- If you touched the prompt or any generated script, paste the OS / PS / Node versions you tested with. -->

- OS:
- PowerShell:
- Node:
- Cursor:

## Checklist

- [ ] No secrets, tokens, or absolute personal paths in this diff
- [ ] No `package.json`, build system, or "clone and run" instructions added
- [ ] If I touched section 4 or design decisions, I added or updated an ADR
