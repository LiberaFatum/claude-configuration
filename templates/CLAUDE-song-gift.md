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
