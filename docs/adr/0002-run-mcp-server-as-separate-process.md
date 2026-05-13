# ADR-0002: Run the MCP server as a separate process

- **Status:** Accepted
- **Date:** 2026-05-13

## Context

If the MCP server runs inside Cursor's process tree, Cursor's lifecycle (restart, crash, update) decides the server's lifecycle. We want the server to survive a Cursor restart and we want an external watchdog to be able to relaunch it.

## Decision

The MCP server runs as an independent PowerShell-launched process. A scheduled task (`CursorObsidianMcpWatchdog`, every 5 minutes) calls `Ensure-ObsidianMCP.ps1` which checks `http://127.0.0.1:3001/health` and relaunches the server if it is down.

## Alternatives considered

- **Spawn from Cursor.** Tighter coupling, no recovery from Cursor crashes, no way to share the server across multiple Cursor windows on the same machine.
- **Windows Service.** Requires admin to install, and we explicitly want a no-admin path so `/RL LIMITED` works.
- **System tray app.** More UX, but also more code to maintain, and a tray icon is a UX surface we do not want to own.

## Consequences

- **Positive:** Cursor restarts do not kill the server. Multiple Cursor windows share one server. The watchdog can always recover.
- **Negative:** The user has a stray `powershell.exe -> npx -> obsidian-mcp-server` process they did not start themselves. Documentation must make this discoverable.
- **Neutral:** The server log lives wherever `npx` decides, unless we redirect (see ADR-0008 once added).

## References

- `PROMPT_ULTRA_COMPLETO.md` section 4, item 2; section 6.6; section 8.4 and 8.5.
