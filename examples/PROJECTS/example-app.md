# example-app

## Contexto

- Objetivo: app desktop con Tauri 2 + Svelte 5 para gestionar inventario offline-first, con sync opcional a Supabase.
- Stack: Tauri 2, Svelte 5 (runes), Vite, TypeScript estricto, Supabase JS, SQLite local via plugin Tauri.
- Repo / ruta: `~/code/example-app` (privado, GitHub).
- Estado actual: v0.4 estable en Windows. Linux funciona en dev pero el plugin de auto-update no firma binarios todavia.

## Decisiones tecnicas

- 2026-04-12: pnpm + workspaces -> velocidad, store compartido entre repos, evita reinstalar Tauri CLI por proyecto.
- 2026-04-12: descartamos Drizzle -> SDK de Supabase ya cubre v1; reducir dependencias hasta tener un caso real que lo justifique.
- 2026-04-15: Stronghold se inicializa async y nunca bloquea bootstrap -> evita la pantalla de carga congelada en Windows.
- 2026-04-22: sin Realtime para v1 -> primera carga es suficiente; reevaluar para v2 si los usuarios pelean por refresh.
- 2026-05-01: barra de progreso del importador reporta bytes, no chunks -> precision real en archivos grandes.

## Comandos utiles

- `pnpm dev` desde la raiz para arrancar Tauri en modo dev.
- `pnpm tauri build --target x86_64-pc-windows-msvc` para release Windows.
- `pnpm supabase db diff -f migrations/<n>_descripcion.sql` para nuevas migraciones.
- `pnpm test -- --filter importer` para suite de importacion sin tocar la app entera.

## Pendientes

- TODO firmar binarios Linux en el pipeline (`tauri.conf.json -> bundle.linux`).
- TODO migrar policies RLS de `items` para soportar invitaciones multi-usuario.
- TODO documentar el flujo offline-first en `docs/architecture.md` del propio repo.

## Hipotesis abiertas

- hipotesis: el cache de imagenes del catalogo se llena rapido en clientes con muchos SKUs. Medir con dataset de 10k items y decidir si rotamos por LRU.
- hipotesis: cambiar el adaptador de SQLite a libsql nos permitiria sync incremental sin reescribir la capa de queries. Pendiente prototipo.
