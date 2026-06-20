# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this project is

LuxDem infrastructure. Manages the backing services for the `luxdem-app` application: PostgreSQL database, pgAdmin, Ollama (local embedding model), Chroma (vector store), and Traefik (reverse proxy with TLS). These services run on a remote VM in production and locally in development.

## Commands

```bash
# Local development
make db-dev-launch       # Start all services locally (uses docker-compose.override.yml)

# Production
make db-launch           # Start DB + Ollama + Chroma (no Traefik)
make traefik-launch      # Start Traefik reverse proxy
make setup-vm <host>     # Bootstrap a fresh Ubuntu VM (runs setup.sh)
```

## Compose file structure

Three compose files are layered:

- **`docker-compose.yml`** — base definition: PostgreSQL, pgAdmin, Ollama, Chroma. Traefik labels on pgAdmin for production routing.
- **`docker-compose.override.yml`** — dev overrides: exposes pgAdmin on a local port (`pgadmin_port`, default 5050), marks `traefik-network` as non-external so it doesn't need to exist locally.
- **`docker-compose.traefik.yml`** — Traefik service with Let's Encrypt TLS resolver. Run separately in production.

In dev, `docker compose up -d` merges base + override automatically. In prod, `db-launch` and `traefik-launch` are run independently.

## Services

| Service | Container | Default port | Purpose |
|---|---|---|---|
| PostgreSQL 15 | `luxdem_db` | (internal) | Application database |
| pgAdmin | `luxdem_pgadmin` | 5050 (dev) | DB admin UI |
| Ollama | `luxdem_ollama` | 11434 | Local embedding model (`nomic-embed-text`) |
| Chroma | `luxdem_chroma` | 8000 | Vector store for document embeddings |
| Traefik | — | 80/443 | Reverse proxy + TLS termination (prod only) |

## Configuration

All secrets and environment-specific values live in `.env` (gitignored). Key variables: `POSTGRES_USER`, `POSTGRES_PASSWORD`, `pgadmin_url`, `pgadmin_port`, `ollama_port`.

## Data volumes

The following directories are gitignored — they hold persistent container data:
- `db_data/` — PostgreSQL data directory
- `ollama_data/` — Ollama model cache
- `chroma_data/` — Chroma vector store data
