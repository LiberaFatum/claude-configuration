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
