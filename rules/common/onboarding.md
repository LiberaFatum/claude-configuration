# Project Onboarding

When starting a new conversation in a project directory, check whether a `CLAUDE.md`
file exists in the project root.

## If CLAUDE.md is missing

Before doing anything else, greet the user and offer to set up the project:

1. Briefly explain that `CLAUDE.md` controls how Claude behaves in this project
   (skill level, workflow rules, project context).
2. Offer to create one now. The base template is at `~/.claude/templates/CLAUDE.md`.
   If the user agrees, read that template and write it to `./CLAUDE.md`.
   If the template file does not exist, tell the user to run the setup script first:
   `bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)`
3. After creating it, ask the user to pick their skill level:
   - **BEGINNER** — plain language, asks before every action, no TDD
   - **INTERMEDIATE** — concise but clear, moderate autonomy, tests alongside code
   - **ADVANCED** — terse, fully autonomous, mandatory TDD + code review
4. Run `/switch-tier` with the chosen level.

Keep the onboarding message short — no more than a few sentences plus the three options.

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
