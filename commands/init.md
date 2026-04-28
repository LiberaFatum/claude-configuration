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

### 2. Select template

Based on the argument, use the matching template:

| Argument | Template | Stack |
|----------|----------|-------|
| `real-estate` | Python/FastAPI + React/TS, PostgreSQL, web scraping | Backend-heavy |
| `song-gift` | React/Next.js, TypeScript, external API integration | Frontend-heavy |
| `eshop` | Full-stack (Python or Next.js), PostgreSQL, Stripe | Full-stack |
| `defi` | Solidity, Foundry/Hardhat, React/TS, Web3 | Smart contracts + frontend |
| _(empty)_ | Base template with fill-in-the-blank sections | Generic |

### 3. Create files

Create these files in the current project directory:

1. **CLAUDE.md** — from the selected template. Fill in the project name based on the directory name.
2. **.gitignore** — comprehensive gitignore covering the relevant stack (Python + Node + Solidity as needed).
3. **.env.example** — list expected environment variables with placeholder values and comments.

### 4. Initialize git

If no `.git` directory exists, ask the user if they want to run `git init`.

### 5. Report

```
Project initialized
────────────────────
Created:  CLAUDE.md (eshop template)
Created:  .gitignore
Created:  .env.example
────────────────────
Next: Open CLAUDE.md and fill in the [TODO] sections.
```

## Rules

- Never overwrite existing files without asking.
- Use the directory name as the default project name.
- Do not create `src/` or other source directories — just the config files.
