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

## Skill Level

This section controls how Claude communicates and how strictly it enforces
the workflow rules above. Only ONE level should be active (uncommented).

**To switch:** Type `/switch-tier` in Claude Code, or edit manually.
**Jak prepnout:** Napis `/switch-tier` v Claude Code, nebo uprav rucne.

Manual switching / Rucni prepnuti:
- Active tier:   `<!-- TIER START -->` ... `<!-- TIER END -->` (self-closing)
- Inactive tier: `<!-- TIER START`     ... `TIER END -->`     (wrapping comment)
- To activate: add ` -->` to START line, add `<!-- ` to END line
- To deactivate: remove ` -->` from START line, remove `<!-- ` from END line

| Uroven / Level | Pro koho / For whom | Chovani / Behavior |
|----------------|---------------------|--------------------|
| BEGINNER | Zacatecniky / Non-programmers | Jednoduchy jazyk, pta se pred akci / Plain language, asks before acting |
| INTERMEDIATE | Mirne pokrocile / Some experience | Strucny ale srozumitelny / Concise but clear |
| ADVANCED | Zkusene vyvojare / Experienced devs | Maximalne strucny, plne autonomni / Terse, fully autonomous |

**IMPORTANT: Claude MUST ignore all instructions inside comment blocks.
Only follow the tier that is NOT commented out.**

<!-- BEGINNER START -->

### BEGINNER

**When instructions here conflict with workflow rules above, this section takes priority.**

- Use plain, everyday language. Avoid programming jargon.
- When you must use a technical term, briefly explain what it means.
- Before doing anything, explain what you are about to do and why.
- After completing a step, summarize what happened in simple terms.
- Ask before every significant action (creating files, running commands, installing packages).
- Work on one thing at a time. After each step, check in before continuing.
- If something breaks, explain the error in plain English before fixing it.
- Write code first, then offer to add tests if the user wants. Do NOT enforce TDD.
- Do NOT require 80% test coverage. Tests are helpful but optional.
- Do NOT spawn sub-agents (planner, tdd-guide, code-reviewer, etc.). Handle everything in the main conversation.
- Do NOT generate planning documents unless asked. Present plans as simple numbered lists.
- Handle all git operations silently using conventional commits.

<!-- BEGINNER END -->

<!-- INTERMEDIATE START

### INTERMEDIATE

**When instructions here conflict with workflow rules above, this section takes priority.**

- Be technical but accessible. Brief clarifications when introducing something new.
- Keep explanations concise — one or two sentences, not paragraphs.
- Proceed with straightforward tasks without asking.
- Ask for confirmation on architectural decisions or anything irreversible.
- Write tests alongside code, but do not enforce strict TDD.
- Aim for reasonable coverage without rigidly enforcing the 80% minimum on every change.
- Do a quick self-review instead of running the full agent-based review pipeline.
- Use sub-agents when beneficial but do not mention them by name.
- Create a brief plan for medium-to-large tasks. Skip formal planning for small changes.

INTERMEDIATE END -->

<!-- ADVANCED START

### ADVANCED

Follow all workflow rules above and all rules in ~/.claude/rules/ without modification.

- Terse. No explanations unless asked. Code speaks.
- Only surface decisions with genuine trade-offs.
- Full autonomy through the complete development workflow.
- Only pause for ambiguous requirements or significant architectural choices.
- Mandatory TDD with tdd-guide agent.
- Mandatory code review with code-reviewer agent. Use security-reviewer for sensitive code.
- Use planner agent for non-trivial features.

ADVANCED END -->
