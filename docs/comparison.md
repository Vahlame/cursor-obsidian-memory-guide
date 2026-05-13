# Comparison

How this pattern stacks up against the obvious alternatives. Last updated with this repo's `v1.1.0`. Each row is a one-line opinion; read the corresponding section for the nuance.

| Feature | This pattern | Cursor built-in memory | mem0 | Letta / MemGPT | Custom RAG (e.g. pgvector) |
|---|---|---|---|---|---|
| Where does the memory live? | Markdown files in your private GitHub repo | Cursor's account / cloud | mem0 service or self-hosted | Letta server, with a DB | Database you run |
| You own the storage? | Yes | No | Self-host yes, hosted no | Yes (self-host) | Yes |
| Portable between IDEs? | Yes (any MCP client) | No | Yes | Yes | Yes |
| Editable without the tool? | Yes (any editor, `grep`, `git`) | No | Limited | Limited | SQL only |
| Multi-device sync | Git | Cursor account | mem0 | Letta server | Your DB infrastructure |
| Conflict resolution | Git merge | N/A | Service-managed | Service-managed | DB transactions |
| Versioned history | Git log | None visible to user | Limited | Limited | DB audit table if you add one |
| Works offline? | Local reads/writes yes, sync delayed | Depends on Cursor | No | If self-hosted | If local DB |
| Vendor lock-in risk | Very low | High | Medium | Medium | Low |
| Setup time | ~30 minutes (this prompt) | Zero | Account + SDK | Server install | Schema + indexer |
| Ongoing maintenance | Two scheduled tasks | Zero | Service or self-host | Server upkeep | DB + indexer upkeep |
| Cost | Free | Included with Cursor | Free tier + paid | Free / self-host | Hosting |
| Best at | Long-lived, human-curated context | Short ephemeral "I told you once" notes | Programmatic per-user memory in apps | Agent-grade structured memory with planning | Domain-specific search over big corpora |
| Worst at | Subsecond retrieval over millions of items | Auditing and portability | Free-form Markdown editing | Casual setup | Free-form notes |

## When to use this pattern

You want a single source of truth for "what the agent should know about me, my projects, and my decisions" that:

- you can read on a plane,
- you can `git log` to see when an idea changed,
- you can hand to a new IDE or a new tool in a year without rewriting,
- and you can audit because it is plain Markdown.

## When NOT to use this pattern

- You need sub-100ms retrieval over hundreds of thousands of items. Use a real vector DB.
- You need server-side memory shared by an SaaS product's many users. Use mem0 or build it.
- You distrust Git as a sync layer (e.g., your team makes hundreds of vault edits per minute). Use a database.
- You are on the Cursor web app and cannot run a local process.

## On mem0 specifically

mem0 (<https://mem0.ai/>) is a great library if you are building an application that needs per-user memory at API call time. Different problem domain than this pattern. The two can coexist: mem0 manages app-side memory, this pattern manages your personal IDE memory.

## On Letta / MemGPT specifically

Letta is the new name for MemGPT. It's a structured-memory agent server: lossless context with a hierarchical memory model. Good when you want the *agent runtime itself* to manage memory tiers. This repo is doing something simpler: the memory is just files, and we let Git and the IDE do everything else.

## On Cursor's own memory feature

Cursor's built-in memory works fine for short, ephemeral "remember that I prefer X" notes. It is invisible storage on Cursor's side, no audit trail, no portability, no read-without-Cursor. This pattern is its complement: durable, portable, auditable memory that lives on your hardware.

## Why pick Markdown over JSON / YAML / SQLite

- Markdown is editable in any tool a developer already has open.
- Markdown is diff-friendly. SQLite blobs are not.
- Markdown carries human-readable structure (headings, lists) that the model already reads well.
- Markdown survives the death of any single tool. SQLite survives only if the consumer adapts.

The cost is the lack of typed fields and constraints. We accept that cost because the consumer is a language model, not a CRUD application.
