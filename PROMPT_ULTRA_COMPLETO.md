Usa este prompt en Cursor (nuevo chat) para que el agente haga TODO el trabajo pesado y deje memoria persistente con Obsidian MCP en Windows.

---

Actua como ingeniero senior de automatizacion y SRE local. Haz tu todo el trabajo pesado para dejar memoria persistente cross-device en Cursor con Obsidian MCP y GitHub.

Objetivo (el usuario solo te da `<REPO_URL_PRIVADO>` y permisos puntuales):
- memoria durable entre sesiones y entre maquinas;
- memoria global + por proyecto;
- watchdog MCP autorecuperable;
- auto-sync git en segundo plano;
- instrucciones finales claras para uso diario.

Contexto tecnico esperado:
- Windows.
- Vault local: `%USERPROFILE%\Documents\cursor-memory-vault`.
- MCP en Cursor: `%USERPROFILE%\.cursor\mcp.json`.
- transporte MCP: `mcp-remote` -> `http://127.0.0.1:3001/sse`.
- repo privado del vault: `<REPO_URL_PRIVADO>`.

Implementacion obligatoria (hazla completa):
1. Verificar prerequisitos (`git`, `node`, `npm`, acceso a repo).
2. Si falta algo, intentar resolver automaticamente; si no es posible, pedir solo el dato/permiso exacto.
3. Clonar o actualizar el vault desde `<REPO_URL_PRIVADO>`.
4. Crear/actualizar estructura minima:
   - `MEMORY.md`
   - `SESSION_LOG.md`
   - `PROJECTS/TEMPLATE.md`
5. Configurar `%USERPROFILE%\.cursor\mcp.json` con `obsidian-memory` via `mcp-remote`.
6. Asegurar MCP local (`@smith-and-web/obsidian-mcp-server`) en `3001`.
7. Crear scripts Windows si no existen (o repararlos si existen) y dejarlos funcionales:
   - `scripts/windows/Setup-Cursor-Memory.ps1`
   - `scripts/windows/Setup-Cursor-Memory.cmd`
   - `scripts/windows/Sync-Memory.ps1`
   - `scripts/windows/Ensure-ObsidianMCP.ps1`
   - `scripts/windows/Enable-MCP-Watchdog.ps1`
   - `scripts/windows/Enable-AutoSync.ps1`
   - `scripts/windows/Doctor.ps1`
8. Activar tareas programadas (modo oculto, sin ventana molesta):
   - watchdog MCP cada 5 min;
   - auto-sync git cada 10 min.
9. Generar User Rules (contenido listo para copiar/pegar) con esta logica:
   - inicio: leer `MEMORY.md` + `PROJECTS/<proyecto>.md`;
   - durante: checkpoint cada 3-5 mensajes si hubo avance real;
   - cierre: resumen en `SESSION_LOG.md`;
   - durable/global a `MEMORY.md`;
   - nunca guardar secretos.
10. Explicar exactamente como usar cada script y en que caso.
11. Verificar end-to-end:
   - health `http://127.0.0.1:3001/health` = 200;
   - tasks existen y ultimo resultado correcto;
   - lectura/escritura de memoria por MCP;
   - sync manual funcionando.

Checklist de salida obligatoria:
1. Estado actual
2. Cambios aplicados
3. Scripts creados/reparados y cuando usar cada uno
4. User Rules generadas (bloque listo para copiar)
5. Validaciones ejecutadas con resultados
6. Pasos manuales minimos restantes

Si algo falla:
- no te detengas al primer error;
- diagnostica causa;
- aplica fix;
- revalida;
- reporta evidencia concreta.

Prioridad de comportamiento:
- minimiza preguntas al usuario;
- automatiza todo lo posible;
- pide solo lo estrictamente imprescindible.
