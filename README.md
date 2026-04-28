# claude-configuration

Portable Claude Code configuration for development teams. Curated from [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) — focused on what actually matters, with no bloat.

**Goal:** Make less experienced developers productive with Claude Code immediately, reduce token waste, and prevent the most common mistakes.

## What's Inside

| Component | Count | Description |
|-----------|-------|-------------|
| **Rules** | 18 (+3 optional Solidity) | Auto-loaded coding standards (Python, TypeScript, Web) |
| **Agents** | 9 | Specialist reviewers Claude invokes automatically |
| **Commands** | 8 | Slash commands you type in chat |
| **Skills** | 2 | On-demand knowledge (PostgreSQL, frontend patterns) |
| **Templates** | 5 | Project-level CLAUDE.md for 4 project types + base |
| **Hooks** | 3 | Bash scripts that catch common mistakes (opt-in) |
| **MCP** | 3 | External tool configs — Context7, GitHub, Playwright (opt-in) |

## Quick Install

```bash
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

Or inspect first:

```bash
git clone https://github.com/LiberaFatum/claude-configuration.git
cd claude-configuration
less setup.sh
bash setup.sh
```

### Install Options

```bash
bash setup.sh                              # Standard: rules + agents + commands + permissions
bash setup.sh --full                        # Everything: + skills, hooks, MCP
bash setup.sh --with-hooks                  # Standard + hooks
bash setup.sh --solidity                    # Standard + Solidity rules
bash setup.sh --project defi                # Standard + CLAUDE.md template for current project
```

Project types: `real-estate`, `song-gift`, `eshop`, `defi`

Then restart Claude Code.

## Three Commands That Change Everything

```
/plan "what you want to build"     # Plan before coding
/code-review                       # Review after coding
/verify                            # Run all checks before committing
```

Between unrelated tasks: `/compact` (frees context, saves tokens).

## All Commands

| Command | What it does |
|---------|-------------|
| `/plan` | Create an implementation plan before coding |
| `/tdd` | Test-driven development: write tests first |
| `/code-review` | Review code for quality, security, bugs |
| `/build-fix` | Fix build/compile errors |
| `/verify` | Run build + lint + typecheck + tests |
| `/test-coverage` | Check test coverage |
| `/refactor-clean` | Remove dead code |
| `/init` | Set up a new project with CLAUDE.md template |

## Agents (Auto-Invoked)

Claude calls these automatically when relevant. You don't need to invoke them manually.

| Agent | Purpose |
|-------|---------|
| planner | Plans features before implementation |
| code-reviewer | Reviews code quality and patterns |
| tdd-guide | Enforces test-first development |
| build-error-resolver | Fixes build failures |
| security-reviewer | Catches security vulnerabilities |
| python-reviewer | Python-specific review |
| typescript-reviewer | TypeScript/JS-specific review |
| database-reviewer | PostgreSQL queries, migrations, schemas |
| refactor-cleaner | Identifies and removes dead code |

## Project Templates

Start a new project with a pre-filled CLAUDE.md:

```bash
cd my-new-project
bash setup.sh --project eshop
```

Available templates:
- **real-estate** — Python/FastAPI + React, PostgreSQL, web scraping
- **song-gift** — Next.js, TypeScript, AI music API, Stripe
- **eshop** — Full-stack e-commerce, PostgreSQL, Stripe, auth
- **defi** — Solidity + Foundry, React, Web3, bonding curves

Or use the base template and fill in the `[TODO]` sections.

## What's NOT Included (and Why)

- **No complex hooks system** — bash-only, opt-in
- **No Node.js dependency** — works without npm
- **No 80+ commands** — 8 that matter
- **No 48 agents** — 9 that cover real needs
- **No continuous learning / instincts** — too advanced for beginners
- **No governance / enterprise features** — unnecessary complexity

## File Structure

```
~/.claude/
  rules/          # Auto-loaded by Claude on every prompt
    common/       # Universal coding standards
    python/       # Python-specific
    typescript/   # TypeScript-specific
    web/          # Frontend-specific
    solidity/     # Smart contract-specific (optional)
  agents/         # Specialist agents (loaded on demand)
  commands/       # Slash commands
  skills/         # On-demand knowledge (--full only)
  hooks/          # Bash hooks (--with-hooks only)
  settings.json   # Permissions and config
```

## Token Efficiency

Rules load on **every prompt** — that's why we keep them lean (~1200 lines total). Agents, commands, and skills load on-demand and don't add to base cost.

Tips for saving tokens:
- Use `/compact` between unrelated tasks
- Use `/plan` before complex work (prevents wrong-direction waste)
- Use `/verify` to catch issues early (prevents fix-loop waste)
- Keep CLAUDE.md concise — it loads on every prompt too

## Credits

All base files from [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) by [@affaan-m](https://github.com/affaan-m), MIT license. This repo is a curated, beginner-optimized subset.

## License

MIT

---

# claude-configuration (CZ)

Prenositelna konfigurace Claude Code pro vyvojove tymy. Vybrane z [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) — zamerene na to, co skutecne pomaha.

## Rychla instalace

```bash
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

## Tri prikazy, ktere meni vysledek

```
/plan "co chces udelat"     # Planuj pred kodovanim
/code-review                # Zkontroluj po kodovani
/verify                     # Spust vsechny kontroly pred commitem
```

Mezi nesouvisejicimi ukoly: `/compact` (uvolni kontext, setri tokeny).

## Moznosti instalace

```bash
bash setup.sh                              # Zakladni: pravidla + agenti + prikazy
bash setup.sh --full                       # Vse: + skills, hooks, MCP
bash setup.sh --with-hooks                 # Zakladni + hooks
bash setup.sh --project eshop              # Zakladni + CLAUDE.md sablona
```

Typy projektu: `real-estate`, `song-gift`, `eshop`, `defi`

Po instalaci restartuj Claude Code.
