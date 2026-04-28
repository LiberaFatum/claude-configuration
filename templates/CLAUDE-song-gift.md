# CLAUDE.md

> Project-level instructions for Claude Code. Loaded automatically at session start.

## Project Overview

AI-powered personalized song gift website. Users describe a person and occasion, the app generates a unique song using an AI music API (e.g., Suno), and delivers it as a shareable gift page. Frontend-heavy with emphasis on visual polish and user experience.

## Tech Stack

- **Framework:** Next.js 14+ (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS + custom CSS for animations
- **State:** React hooks + URL state for shareable pages
- **AI Music API:** Suno API (or equivalent)
- **Payments:** Stripe Checkout
- **Hosting:** Vercel
- **Testing:** Vitest + Playwright

## Project Structure

```
app/
  page.tsx              # Landing page
  create/               # Song creation flow
  gift/[id]/            # Shareable gift page
  api/                  # API routes (Suno proxy, Stripe webhooks)
components/
  ui/                   # Reusable UI primitives
  create-flow/          # Multi-step creation wizard
  gift/                 # Gift page components
  landing/              # Landing page sections
hooks/
  useCreateFlow.ts      # Creation wizard state
lib/
  suno.ts               # Suno API client
  stripe.ts             # Stripe integration
  validation.ts         # Input validation schemas
```

## Workflow Rules

### Before writing any code

1. Use `/plan` to outline the approach before implementation.
2. Check existing component patterns before creating new ones.

### Design quality

This is a consumer-facing gift product. The UI must look **premium, not template-y**.

- Follow the design-quality rules strictly — no default card grids, no generic hero sections.
- Every page should demonstrate intentional hierarchy, typography, and motion.
- The gift page is the most important surface — it must feel special and shareable.
- Test both light and dark themes if implemented.

### Test-driven development

- Write tests **first** for business logic (pricing, validation, API clients).
- Use Playwright for E2E tests of the creation flow and gift page.
- Visual regression tests for the gift page at key breakpoints.
- Minimum 80% coverage on logic, visual regression for UI.

### Before every commit

- Run `/code-review` to catch issues.
- Run `/verify` to ensure build, tests, lint, and typecheck pass.
- Use conventional commits.

## Security Rules

- **Never** commit API keys. All credentials in `.env.local`.
- Validate all user input with Zod schemas before sending to APIs.
- Stripe webhooks must verify signatures.
- Rate limit the song generation endpoint.
- Sanitize any user-provided text before rendering.

## Budget Guard

- Before starting any task, estimate files to touch. If more than 10, confirm with the user.
- If stuck on the same error for 3 iterations, STOP and explain the blocker.
- Use `/compact` between unrelated tasks.

## Definition of Done

- [ ] Tests written and passing
- [ ] Coverage >= 80% on logic code
- [ ] `/verify` passes
- [ ] `/code-review` run and CRITICAL/HIGH addressed
- [ ] Gift page looks polished at 320, 768, 1024, 1440 breakpoints

## What NOT to do

- Do not use default component library styling without customization.
- Do not add dependencies without justification.
- Do not use `console.log` — use a proper logger or remove debug statements.
- Do not commit `.env.local`, `node_modules/`, or `.next/`.
