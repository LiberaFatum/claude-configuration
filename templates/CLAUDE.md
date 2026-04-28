# CLAUDE.md

> Project-level instructions for Claude Code. Loaded automatically at session start.

## Project Overview

Fill in a 2-3 sentence description of what this project does once you know.

## Workflow Rules

### Before writing code

1. Use `/plan` to outline the approach for non-trivial changes.
2. Search GitHub for existing implementations before writing new logic from scratch.

### Test-driven development

- Write tests first, then implementation. Use `/tdd`.
- Aim for 80% coverage on new code (`/test-coverage` to verify).
- Tests must be deterministic — no real network calls, no real time-of-day dependencies.

### Before every commit

- Run `/code-review` to catch issues before they land.
- Run `/verify` to ensure build, tests, lint, and typecheck all pass.
- Use conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`.

### Code quality

- Files under 400 lines where possible, hard cap 800.
- Functions under 50 lines.
- Prefer many small modules over few large ones.
- Immutability by default — return new objects, do not mutate inputs.

## Security Rules

- Never commit secrets. Credentials live in `.env` (gitignored).
- Always validate user input at the API boundary.
- Never build SQL queries by string concatenation — use parameterized queries.
- For changes touching auth, payments, or user data, invoke the `security-reviewer` agent.

## Budget Guard

- Before starting a task, estimate the number of files to touch. If more than 10, confirm with the user.
- If stuck on the same error for 3 iterations, STOP and explain what you tried and what is blocking.
- Use `/compact` between unrelated tasks to free context.

## Definition of Done

A feature is done when:

- Tests written and passing
- Coverage >= 80% on new code
- `/verify` passes
- `/code-review` run and CRITICAL/HIGH issues addressed
- Documentation updated if public API changed

## What NOT to do

- Do not create new top-level directories without asking.
- Do not add new dependencies without justification.
- Do not write `print()` / `console.log()` for logging — use the configured logger.
- Do not commit `.env`, `*.db`, `__pycache__/`, `node_modules/`, or anything in `.gitignore`.

---

## Skill Level

This section controls how Claude communicates and how strictly it enforces
the rules above. Only ONE level should be active (uncommented).

**To switch:** Type `/switch-tier <level>` in Claude Code.
**Jak prepnout:** Napis `/switch-tier <uroven>` v Claude Code.

| Level / Uroven | For whom / Pro koho | Behavior / Chovani |
|----------------|---------------------|--------------------|
| BEGINNER | Non-programmers / Neprogramatory | Plain language, asks before acting / Jednoduchy jazyk, pta se pred akci |
| INTERMEDIATE | Some experience / Mirne pokrocile | Concise but clear / Strucny ale srozumitelny |
| ADVANCED | Experienced devs / Zkusene vyvojare | Terse, fully autonomous / Maximalne strucny, plne autonomni |

**IMPORTANT: Claude MUST ignore all instructions inside comment blocks.
Only follow the tier that is NOT commented out.**

<!-- BEGINNER START -->

### BEGINNER

When instructions here conflict with workflow rules above, this section takes priority.

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

When instructions here conflict with workflow rules above, this section takes priority.

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

Follow all workflow rules above and all rules in `~/.claude/rules/` without modification.

- Terse. No explanations unless asked. Code speaks.
- Only surface decisions with genuine trade-offs.
- Full autonomy through the complete development workflow.
- Only pause for ambiguous requirements or significant architectural choices.
- Mandatory TDD with tdd-guide agent.
- Mandatory code review with code-reviewer agent. Use security-reviewer for sensitive code.
- Use planner agent for non-trivial features.

ADVANCED END -->
