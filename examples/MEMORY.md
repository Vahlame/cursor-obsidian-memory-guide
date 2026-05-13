# MEMORY

## Perfil de trabajo

- Idioma preferido: espanol.
- Estilo preferido: directo, practico, accionable. Sin emojis.
- Zona horaria: America/Mexico_City (UTC-6).
- Stack diario: TypeScript, Svelte 5, Tauri 2, Postgres / Supabase.

## Preferencias de respuesta del agente

- Antes de proponer un cambio mayor, pedir contexto si no esta en `PROJECTS/<proyecto>.md`.
- Citar archivos como `path/to/file.ts:linea` cuando se hable de codigo existente.
- Si una solucion tiene un trade-off no obvio, declararlo explicitamente.
- Cuando una decision tenga dos caminos validos, enumerar ambos antes de elegir.

## Reglas de memoria

- Registrar solo lo que tendra valor en >1 semana.
- Separar `hechos` de `hipotesis` con la palabra explicita.
- No guardar secretos, tokens, ni rutas absolutas con datos personales.

## Lecciones tecnicas que aplico siempre

- Vite/SvelteKit: las env vars `VITE_*` solo se inline si el acceso es estatico (`import.meta.env.VITE_FOO`). Acceso indirecto via parametro queda `undefined`.
- Tauri 2 en Windows: el bootstrap del shell no debe bloquearse esperando SQLite o Stronghold. Usar timeouts y desacoplar.
- Postgres con RLS: probar siempre como `anon` y como usuario autenticado antes de declarar una policy "lista".
- Git: nunca `push --force` a `main`. Siempre `--force-with-lease` y solo a ramas propias.

## Decisiones de proceso

- PR pequeno (<300 lineas de diff) salvo refactor explicitamente etiquetado.
- Conventional commits opcional; lo importante es imperativo + objeto + por que.
