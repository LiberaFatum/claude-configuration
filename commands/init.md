---
description: Initialize a new project with CLAUDE.md, .gitignore, and .env.example from templates.
---

# Init Project

Set up a new project directory with the right configuration files for Claude Code.

## Arguments

`$ARGUMENTS` — project type: `real-estate`, `song-gift`, `eshop`, `defi`, or empty for the base template.

## Steps

### 1. Check current directory

- Verify we are in a project directory (not home or system dir).
- Check if CLAUDE.md already exists — if so, ask before overwriting.

### 2. Select and copy template

Templates are installed at `~/.claude/templates/`. Pick the right one:

| Argument | Template file | Stack |
|----------|---------------|-------|
| `real-estate` | `~/.claude/templates/CLAUDE-real-estate.md` | Python/FastAPI + React/TS, PostgreSQL, web scraping |
| `song-gift` | `~/.claude/templates/CLAUDE-song-gift.md` | React/Next.js, TypeScript, external API integration |
| `eshop` | `~/.claude/templates/CLAUDE-eshop.md` | Full-stack (Python or Next.js), PostgreSQL, Stripe |
| `defi` | `~/.claude/templates/CLAUDE-defi.md` | Solidity, Foundry/Hardhat, React/TS, Web3 |
| _(empty)_ | `~/.claude/templates/CLAUDE.md` | Generic base template |

Read the template file and write it to `./CLAUDE.md` in the current directory.
Replace the project name placeholder with the current directory name.

If the template file does not exist, tell the user to re-run the setup script:
```
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

### 3. Create supporting files

1. **.gitignore** — comprehensive gitignore covering the relevant stack (Python + Node + Solidity as needed).
2. **.env.example** — list expected environment variables with placeholder values and comments.

### 4. Initialize git

If no `.git` directory exists, ask the user if they want to run `git init`.

### 5. Offer tier selection

After creating CLAUDE.md, ask the user to pick their skill level:
- **BEGINNER** — plain language, asks before every action, no TDD
- **INTERMEDIATE** — concise but clear, moderate autonomy, tests alongside code
- **ADVANCED** — terse, fully autonomous, mandatory TDD + code review

Then run `/switch-tier` with their choice.

### 6. Report

```
Project initialized
────────────────────
Created:  CLAUDE.md (base template)
Created:  .gitignore
Created:  .env.example
Tier:     BEGINNER (use /switch-tier to change)
────────────────────
```

## Rules

- Never overwrite existing files without asking.
- Use the directory name as the default project name.
- Do not create `src/` or other source directories — just the config files.
