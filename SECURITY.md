# Security Policy

## Why this file matters

`PROMPT_ULTRA_COMPLETO.md` is a prompt that, when pasted into Cursor, causes an AI agent to execute commands on the user's Windows machine: install npm packages, write files in `%USERPROFILE%`, modify `mcp.json`, create scheduled tasks, and push to a private GitHub repo. A malicious change to the prompt is, effectively, a remote code execution vector against everyone who pastes it.

Treat issues with the prompt the same way you would treat issues with a system installer.

## Supported versions

| Version | Supported |
|---|---|
| 1.x | yes |
| < 1.0 | no |

Only the latest minor of the current major receives fixes. We will not backport.

## Reporting a vulnerability

**Do not open a public issue for security problems.**

Email the maintainer privately, or use GitHub's "Report a vulnerability" form under the `Security` tab. Include:

- a description of the issue,
- the section / line of `PROMPT_ULTRA_COMPLETO.md` involved (or which generated script),
- a proof of concept, or a clear description of the attack scenario,
- the impact (data exfiltration, code execution, privilege escalation, denial of memory, etc.).

You will get an acknowledgement within 72 hours. Expected timeline from report to public fix:

- triage: 3 business days,
- fix or mitigation released: 14 days for critical / high, 30 days for medium / low,
- public disclosure: coordinated, after a fix is available.

## What we consider in scope

- Any path in the prompt that downloads, executes, or persists arbitrary code from a non-pinned source.
- Any generated script (`Setup-Cursor-Memory.ps1`, `Sync-Memory.ps1`, etc.) that can be tricked into writing outside the vault, leaking secrets, or escalating privileges.
- Scheduled tasks created by the prompt that could be hijacked or run with unintended privileges.
- The User Rules block in section 9 if it can be coerced into exfiltrating data through the agent.

## Out of scope

- Bugs in `@smith-and-web/obsidian-mcp-server` itself. Report those upstream.
- Bugs in Cursor or MCP protocol. Report those to the respective vendors.
- General Windows privilege issues unrelated to the prompt.
- Reports requiring physical access to the user's machine.

## Hardening guidance for users

If you are about to paste this prompt into Cursor:

1. Verify the commit hash of the prompt against a known good release tag.
2. Check `<REPO_URL_PRIVADO>` is your own private repository.
3. Inspect generated scripts in `<VAULT_PATH>\scripts\windows\` before letting the watchdog run for the first time.
4. Keep 2FA on for GitHub.
5. Never paste secrets into the chat session that creates the vault. The vault is for memory, not for credentials.

## Past advisories

None yet.
