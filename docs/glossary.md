# Glossary

Short, opinionated definitions of every term that appears in the prompt or this repository.

## Terms

### Agent

An AI model with tools. In this repo, "agent" specifically means the assistant running inside Cursor that reads `PROMPT_ULTRA_COMPLETO.md` and executes the steps.

### Autosync

The scheduled task `CursorMemoryAutoSync` that runs `Sync-Memory.ps1` every 10 minutes to commit and push the vault to GitHub.

### Cursor

The IDE this pattern is built for. Specifically Cursor Desktop on Windows. The web version is out of scope (see FAQ).

### Doctor

`Doctor.ps1`. The end-to-end validation script that the prompt generates. Reports `[OK]`, `[WARN]`, `[FAIL]` per check and exits non-zero on any failure.

### Health endpoint

`http://127.0.0.1:3001/health`. The MCP server exposes this; a `200` response is the signal that it is up and able to accept SSE connections.

### MCP

Model Context Protocol. The protocol Cursor uses to talk to external tools. See <https://modelcontextprotocol.io/>.

### `mcp-remote`

An npm package that bridges Cursor's STDIO MCP client to a remote SSE MCP server. The reason we use it is in ADR-0001.

### `mcp.json`

`%USERPROFILE%\.cursor\mcp.json`. The configuration file where Cursor learns which MCP servers exist and how to launch them.

### MEMORY.md

A file at the root of the vault holding global, durable preferences and rules. Things the agent should remember across all projects.

### Obsidian MCP server

`@smith-and-web/obsidian-mcp-server`. An npm package that exposes a Markdown vault directory through MCP. Despite the name, you do not need the Obsidian app installed; the package just speaks Obsidian's vault conventions.

### PROJECTS/

A directory inside the vault containing one Markdown file per project. The agent picks the right file based on the current workspace folder name.

### SESSION_LOG.md

A file at the root of the vault. Append-only log of decisions, organized chronologically.

### SSE

Server-Sent Events. The HTTP-based transport the MCP server speaks. One-way push of newline-delimited JSON from server to client. Combined with regular HTTP POST for client-to-server messages.

### STDIO

The transport Cursor's MCP client uses to talk to MCP servers it spawns: standard input and output of a child process. The reason `mcp-remote` exists is to translate between STDIO and SSE.

### Task Scheduler

Windows' built-in cron equivalent (`schtasks.exe`). Used to schedule the watchdog and the autosync.

### User Rules

Free-text instructions you paste into `Cursor Settings -> Rules -> User Rules`. Cursor injects them into every conversation. Section 9 of the prompt generates the canonical block for this pattern.

### Vault

`%USERPROFILE%\Documents\cursor-memory-vault`. The directory the Obsidian MCP server reads and writes. It is also a Git working tree synced to a private GitHub repo.

### Watchdog

The scheduled task `CursorObsidianMcpWatchdog` that runs `Ensure-ObsidianMCP.ps1` every 5 minutes to make sure the MCP server is alive and re-launch it otherwise.

### `wscript.exe`

The Windows Script Host. We use it with `//B //nologo` and a `.vbs` shim to run scheduled tasks without flashing a console window. See ADR-0003.
