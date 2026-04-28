# CLAUDE.md

> Project-level instructions for Claude Code. Loaded automatically at session start.

## Project Overview

E-commerce platform with product catalog, shopping cart, checkout with Stripe payments, user accounts, and order management. Full-stack application with emphasis on security and reliability.

## Tech Stack

- **Backend:** Python 3.12+ / FastAPI (or Next.js API routes)
- **Frontend:** React + TypeScript + Vite (or Next.js)
- **Database:** PostgreSQL (with SQLAlchemy 2.x or Prisma)
- **Payments:** Stripe (Checkout + Webhooks)
- **Auth:** Session-based or JWT
- **Cache:** Redis (sessions, cart)
- **Testing:** pytest / vitest, Playwright for E2E
- **Linting:** ruff + mypy / eslint + tsc

## Project Structure

```
src/
  api/          # Routes and endpoints
  models/       # Database models and schemas
  services/     # Business logic (cart, orders, payments)
  auth/         # Authentication and authorization
  db/           # Migrations, session management
frontend/
  src/
    components/ # React components
    hooks/      # Custom hooks
    lib/        # API client, utilities
    pages/      # Page components
tests/
  unit/
  integration/
  e2e/
```

## Workflow Rules

### Before writing any code

1. Use `/plan` to outline the approach.
2. Search for existing implementations before writing from scratch.

### Test-driven development

- Write tests **first**. Use `/tdd`.
- 100% coverage required for: payment logic, cart calculations, auth flows.
- 80% minimum for everything else.
- E2E tests for: registration, login, add-to-cart, checkout, order confirmation.

### Before every commit

- Run `/code-review` to catch issues.
- Run `/verify` to ensure everything passes.
- Use conventional commits.

## Security Rules (CRITICAL for e-shop)

- **Never** commit secrets. All credentials in `.env`.
- **Never** trust client-side price calculations — validate on server.
- **Always** verify Stripe webhook signatures.
- **Always** use parameterized queries — no string concatenation.
- **Always** validate and sanitize user input (Pydantic/Zod).
- Rate limit authentication endpoints.
- Implement CSRF protection on all state-changing forms.
- Hash passwords with bcrypt or argon2 — never store plaintext.
- Use HTTPS in production with proper security headers.
- PCI compliance: never store full card numbers — let Stripe handle it.
- For ANY change touching payments, auth, or user data, run `security-reviewer` agent.

## Budget Guard

- Before starting any task, estimate files to touch. If more than 10, confirm with user.
- If stuck on the same error for 3 iterations, STOP and explain.
- Use `/compact` between unrelated tasks.

## Definition of Done

- [ ] Tests written and passing
- [ ] Coverage >= 80% (100% for payments/auth)
- [ ] `/verify` passes
- [ ] `/code-review` run and CRITICAL/HIGH addressed
- [ ] Security review for payment/auth changes

## What NOT to do

- Do not implement custom payment processing — use Stripe.
- Do not store sensitive data (cards, passwords) in plaintext.
- Do not trust client-side calculations for pricing.
- Do not add dependencies without justification.
- Do not write `print()` / `console.log()` — use the configured logger.
- Do not commit `.env`, `*.db`, `__pycache__/`, `node_modules/`.

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
