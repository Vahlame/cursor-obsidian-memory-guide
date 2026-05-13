# Cursor Memory in 30 Minutes (Windows)

Este repo queda intencionalmente minimalista: solo lo necesario para integrar memoria persistente en Cursor con Obsidian MCP + GitHub.

## Que hace

- conecta Cursor a `obsidian-memory` via `mcp-remote`;
- levanta/revive el servidor MCP local automaticamente;
- sincroniza tu vault a GitHub cada 10 minutos;
- deja memoria global y por proyecto en Markdown.

## Tiempo estimado

Si ya tienes Git + Node + Cursor, se hace en **30 minutos o menos**.

## Unico flujo recomendado

1. Crea un repo privado para tu vault (ejemplo: `cursor-memory-vault`).
2. Ejecuta `scripts/windows/Setup-Cursor-Memory.cmd`.
3. Pega la URL del repo privado cuando te la pida.
4. Reinicia Cursor.
5. Copia `PROMPT_ULTRA_COMPLETO.md` y pégalo en User Rules.

## Scripts (que usar y cuando)

- `scripts/windows/Setup-Cursor-Memory.cmd`
  - **Usa este primero**. Wizard de doble click.
- `scripts/windows/Setup-Cursor-Memory.ps1`
  - Setup completo por consola o automatización.
- `scripts/windows/Sync-Memory.ps1`
  - Forzar sync inmediato (sin esperar 10 minutos).
- `scripts/windows/Ensure-ObsidianMCP.ps1`
  - Levanta MCP si está caído.
- `scripts/windows/Enable-MCP-Watchdog.ps1`
  - Crea/repara watchdog cada 5 minutos.
- `scripts/windows/Enable-AutoSync.ps1`
  - Crea/repara auto-sync cada 10 minutos.
- `scripts/windows/Doctor.ps1`
  - Diagnóstico rápido end-to-end.

## Como funciona (simple)

1. Cursor lee `%USERPROFILE%\.cursor\mcp.json`.
2. Ahí se registra `obsidian-memory` usando `mcp-remote`.
3. `mcp-remote` apunta a `http://127.0.0.1:3001/sse`.
4. El servidor Obsidian MCP lee/escribe tu vault en disco.
5. Scheduler:
   - `CursorObsidianMcpWatchdog` mantiene MCP arriba.
   - `CursorMemoryAutoSync` sincroniza git automáticamente.

## Verificación rápida

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\windows\Doctor.ps1"
```

En Cursor, prueba:

- `Usa obsidian-memory y lee MEMORY.md`
- `Agrega una linea de prueba en SESSION_LOG.md`

Si eso funciona, ya quedó.
