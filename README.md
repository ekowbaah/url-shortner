# URL Shortener

A production-oriented URL shortener written in Rust with Axum and PostgreSQL. It supports authenticated link management, fast redirects, click statistics, Prometheus metrics, request tracing, bounded database timeouts, and cache-aware redirect responses.

## Architecture

```mermaid
flowchart LR
  Client --> Axum
  Axum --> Auth
  Axum --> Postgres[(PostgreSQL)]
  Axum --> Metrics[Prometheus metrics]
```

## Run locally

```bash
docker compose up -d
export DATABASE_URL=postgres://postgres:postgres@localhost:4321/postgres
sqlx migrate run
cargo run
```

The service listens on `:3000`. `GET /health` and `GET /metrics` are unauthenticated. Link creation, updates, and statistics require `x-api-key`; redirects are public.

| Method | Route | Purpose |
|---|---|---|
| `POST` | `/create` | Create a short link |
| `PATCH` | `/:id` | Update a target |
| `GET` | `/:id` | Redirect and record statistics |
| `GET` | `/:id/statistics` | Aggregate click statistics |

## Operational characteristics

- 300 ms bounds around database operations
- Three attempts to resolve generated-ID collisions
- SHA3-256 API-key verification
- Structured tracing and Prometheus request metrics
- Cache-Control optimized temporary redirects

## Non-goals

This repository is a focused service, not a marketing-link platform. Custom domains, billing, and browser analytics are intentionally outside the current scope.

