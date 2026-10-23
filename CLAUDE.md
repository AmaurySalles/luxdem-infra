# LuxDem infra

Backing services for `luxdem-app`: Postgres, pgAdmin, Ollama, Chroma, Traefik. Remote VM in prod, local in dev.

## Commands

- Dev: `make db-dev-launch` (base + override compose)
- Prod: `make db-launch`, then `make traefik-launch` separately
- New VM: `make setup-vm <host>`

## Gotchas

- `docker-compose.override.yml` is dev-only: exposes pgAdmin and makes `traefik-network` non-external.
- Secrets live in `.env` (gitignored). A hook blocks Claude from reading or editing it; ask the user for values.
- `db_data/`, `ollama_data/`, `chroma_data/` hold live container data. Never delete them.
