# CLAUDE.md

> Project-level instructions for Claude Code. Loaded automatically at session start.

## Project Overview

Real estate market aggregator. Scrapes listings from Czech real estate portals (sreality.cz, bazos.cz, bezrealitky.cz), normalizes them into a unified schema, and serves them via a REST API with a React frontend.

## Tech Stack

- **Language:** Python 3.12+
- **Framework:** FastAPI
- **Database:** PostgreSQL (with SQLAlchemy 2.x async)
- **Scraping:** httpx + BeautifulSoup4 (or Playwright for JS-rendered pages)
- **Frontend:** React + TypeScript + Vite
- **Testing:** pytest, pytest-asyncio, pytest-cov
- **Linting:** ruff, mypy
- **Package manager:** uv

## Project Structure

```
src/
  api/          # FastAPI routes and dependencies
  models/       # SQLAlchemy models and Pydantic schemas
  services/     # Business logic, no framework dependencies
  scrapers/     # Per-portal scraper implementations
  db/           # Migrations, session management
frontend/
  src/
    components/ # React components
    hooks/      # Custom hooks
    lib/        # Utilities and API client
tests/
  unit/         # Fast, isolated tests
  integration/  # Tests that touch the database
```

## Workflow Rules

### Before writing any code

1. Use `/plan` to outline the approach before implementation.
2. Search GitHub for existing implementations before writing new logic from scratch.

### Test-driven development

- Write tests **first**, then implementation. Use `/tdd`.
- Minimum 80% coverage on new code (`/test-coverage` to verify).
- Tests must be deterministic — no real network calls, no real time-of-day dependencies.
- Mock HTTP responses for scraper tests using `respx` or `pytest-httpx`.

### Before every commit

- Run `/code-review` to catch issues before they land.
- Run `/verify` to ensure build, tests, lint, and typecheck all pass.
- Use conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.

### Code quality

- Files should stay under 400 lines where possible, hard cap at 800.
- Functions should stay under 50 lines.
- Immutability by default — return new objects, do not mutate inputs.
- Each scraper is a separate module implementing a common interface.

## Scraper-Specific Rules

- Each portal scraper must implement the same `ScraperProtocol` interface.
- Store raw HTML/JSON responses for debugging (but gitignore them).
- Implement rate limiting and respectful crawling (min 1s between requests).
- Handle pagination, retries, and anti-bot measures gracefully.
- Normalize all prices to CZK, all areas to m2.

## Security Rules

- **Never** commit secrets. All credentials live in `.env`.
- **Always** validate user input at the API boundary using Pydantic schemas.
- **Never** build SQL queries by string concatenation — use SQLAlchemy.
- For any change touching authentication or user data, invoke the `security-reviewer` agent.

## Budget Guard

- Before starting any task, estimate the number of files to touch. If more than 10, confirm with the user.
- If stuck on the same error for 3 iterations, STOP and explain the blocker.
- Use `/compact` between unrelated tasks.

## Definition of Done

- [ ] Tests written and passing
- [ ] Coverage >= 80% on new code
- [ ] `/verify` passes
- [ ] `/code-review` run and CRITICAL/HIGH addressed

## What NOT to do

- Do not create new top-level directories without asking.
- Do not add new dependencies without justification.
- Do not write `print()` for logging — use the configured logger.
- Do not commit `.env`, `*.db`, `__pycache__/`, or anything in `.gitignore`.
- Do not scrape without rate limiting.

## User Context

<!-- Uncomment ONE block based on your experience level: -->

<!-- BEGINNER:
I am learning to program. When working on this project:
- Explain what you changed and why in simple terms.
- If you encounter an error, explain what went wrong before trying to fix it.
- If something is too complex, suggest a simpler approach first.
- Do not add features I did not ask for.
-->

<!-- ADVANCED:
I am an experienced developer. Be concise:
- Summarize what changed in 2-3 sentences.
- If a request is ambiguous, ask one clarifying question rather than guessing.
- If you cannot solve a problem in 3 attempts, stop and explain what you tried.
-->
