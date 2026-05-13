# ADR-0001: Use `mcp-remote` instead of pointing Cursor at the SSE server directly

- **Status:** Accepted
- **Date:** 2026-05-13

## Context

Cursor's MCP client speaks the STDIO transport. The Obsidian MCP server (`@smith-and-web/obsidian-mcp-server`) speaks SSE on `http://127.0.0.1:3001/sse`. If `mcp.json` points Cursor at the SSE endpoint with `"command": "curl"` or similar, Cursor opens a STDIO pipe and waits for an MCP handshake that never arrives. Result: the server is marked as "no disponible" / "unavailable" in the MCP panel.

## Decision

Use the `mcp-remote` npm package as a bridge. `mcp-remote` exposes a STDIO interface to Cursor and translates to/from SSE talking to the local server.

```json
{
  "mcpServers": {
    "obsidian-memory": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "http://127.0.0.1:3001/sse"]
    }
  }
}
```

## Alternatives considered

- **Native SSE client in Cursor.** Not currently supported as the default transport for user-configured MCP servers. Rejected as out of our control.
- **Wrap the server in a STDIO-speaking shell.** Doable but requires writing and maintaining a custom bridge per-OS. `mcp-remote` already exists and is maintained.
- **Run the server in STDIO mode.** The Obsidian MCP server is SSE-only. Forking it would be a much larger project.

## Consequences

- **Positive:** Cursor sees a healthy MCP server. The user does not have to install anything beyond Node/npm. The first invocation has a cold `npx -y` cost (~30s) and subsequent ones are instantaneous.
- **Negative:** Adds a process and a network hop in the loop. If `mcp-remote` ever has a bug, both Cursor's MCP panel and the chat will show degraded behavior with no useful error.
- **Neutral:** The Obsidian MCP server can be reused by other tools because it stays on SSE.

## References

- `PROMPT_ULTRA_COMPLETO.md` section 4, item 1; section 6.4.
- npm: `mcp-remote`.
