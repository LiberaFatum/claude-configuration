# Project Onboarding

When starting a new conversation in a project directory, check whether a `CLAUDE.md`
file exists in the project root.

## If CLAUDE.md is missing

Before doing anything else, greet the user briefly and explain:

`CLAUDE.md` controls how Claude behaves in this project (skill level, workflow rules).
The fastest way to set it up is to pick a skill level — Claude will create the file
from the template automatically.

Then ask the user to pick one:

- **BEGINNER** — plain language, asks before every action, no TDD
- **INTERMEDIATE** — concise but clear, moderate autonomy, tests alongside code
- **ADVANCED** — terse, fully autonomous, mandatory TDD + code review

When they answer, run `/switch-tier <level>` (it creates CLAUDE.md from
`~/.claude/templates/CLAUDE.md` if missing, then activates the chosen tier).

For richer per-project setup (gitignore, env example, project-type templates), the user
can instead run `/init-project [type]`. Mention this only if they ask for more setup.

Keep the onboarding message short — a few sentences plus the three options.

## If CLAUDE.md exists but has no tier markers

If CLAUDE.md exists but does not contain `<!-- BEGINNER START`, `<!-- INTERMEDIATE START`,
or `<!-- ADVANCED START`, it does not use the skill level system. In that case:

- Do NOT prompt for tier selection.
- Proceed normally using whatever instructions are in the existing CLAUDE.md.

## If CLAUDE.md exists with tier markers

Proceed normally. The active tier controls behavior. Do not re-prompt.

## Jazyk / Language

If the user writes in Czech, respond in Czech. If in English, respond in English.
Match the user's language in the onboarding prompt as well.
