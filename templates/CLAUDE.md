# CLAUDE.md

> Project-level instructions for Claude Code. Loaded automatically at session start.

## Project Overview

<!-- [TODO] Describe what this project does in 2-3 sentences. -->

## Tech Stack

<!-- [TODO] List your technologies. Example: -->
<!-- - **Language:** Python 3.12+ / TypeScript 5.x -->
<!-- - **Framework:** FastAPI / Next.js / etc. -->
<!-- - **Database:** PostgreSQL / SQLite / none -->
<!-- - **Testing:** pytest / vitest / jest -->
<!-- - **Linting:** ruff / eslint -->
<!-- - **Package manager:** uv / npm / pnpm -->

## Project Structure

<!-- [TODO] Describe your source code layout. Example: -->
<!--
```
src/
  api/          # Routes and endpoints
  models/       # Database models and schemas
  services/     # Business logic
tests/
  unit/         # Fast, isolated tests
  integration/  # Tests that touch the database
```
-->

## Workflow Rules

### Before writing any code

1. Use `/plan` to outline the approach before implementation.
2. Search GitHub for existing implementations before writing new logic from scratch.

### Test-driven development

- Write tests **first**, then implementation. Use `/tdd`.
- Minimum 80% coverage on new code (`/test-coverage` to verify).
- Tests must be deterministic — no real network calls, no real time-of-day dependencies.

### Before every commit

- Run `/code-review` to catch issues before they land.
- Run `/verify` to ensure build, tests, lint, and typecheck all pass.
- Use conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.

### Code quality

- Files should stay under 400 lines where possible, hard cap at 800.
- Functions should stay under 50 lines.
- Prefer many small modules over few large ones.
- Immutability by default — return new objects, do not mutate inputs.

## Security Rules

- **Never** commit secrets. All credentials live in `.env` (which is gitignored).
- **Always** validate user input at the API boundary.
- **Never** build SQL queries by string concatenation — use parameterized queries.
- For any change touching authentication, payments, or user data, invoke the `security-reviewer` agent before committing.

## Budget Guard

- Before starting any task, estimate the number of files to touch. If more than 10, confirm with the user.
- If stuck on the same error for 3 iterations, STOP and explain what you tried and what the blocker is.
- Use `/compact` between unrelated tasks to free context.

## Definition of Done

A feature is done when **all** of the following are true:

- [ ] Tests written and passing (unit + integration where applicable)
- [ ] Coverage >= 80% on new code
- [ ] `/verify` passes (build, tests, lint, typecheck)
- [ ] `/code-review` has been run and CRITICAL/HIGH issues addressed
- [ ] Documentation updated if public API changed

## What NOT to do

- Do not create new top-level directories without asking.
- Do not add new dependencies without justification.
- Do not write `print()` / `console.log()` for logging — use the configured logger.
- Do not commit `.env`, `*.db`, `__pycache__/`, `node_modules/`, or anything in `.gitignore`.

## Communication Preferences

- When you finish a task, summarize what changed in 2-3 sentences. Do not narrate the process.
- If a request is ambiguous, ask one clarifying question rather than guessing.
- If you encounter a problem you cannot solve in 3 attempts, stop and explain what you tried.
