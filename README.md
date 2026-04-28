# claude-configuration

Portable Claude Code configuration for development teams. Curated from [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) — focused on what actually matters, with no bloat.

**Goal:** Make less experienced developers productive with Claude Code immediately, reduce token waste, and prevent the most common mistakes.

## What's Inside

| Component | Count | Description |
|-----------|-------|-------------|
| **Rules** | 18 (+3 optional Solidity) | Auto-loaded coding standards (Python, TypeScript, Web) |
| **Agents** | 9 | Specialist reviewers Claude invokes automatically |
| **Commands** | 9 | Slash commands you type in chat |
| **Skills** | 2 | On-demand knowledge (PostgreSQL, frontend patterns) |
| **Templates** | 5 | Project-level CLAUDE.md for 4 project types + base |
| **Hooks** | 3 | Bash scripts that catch common mistakes (opt-in) |
| **MCP** | 3 | External tool configs — Context7, GitHub, Playwright (opt-in) |

## Quick Install

**Step 1 — Install global config** (once per machine):

```bash
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

This installs rules, agents, and commands into `~/.claude/`. Restart Claude Code after.

**Step 2 — Open any project and start Claude Code:**

```bash
cd my-project
claude
```

Claude will automatically detect that the project has no `CLAUDE.md` and ask you to
pick a skill level (beginner / intermediate / advanced). When you answer,
`/switch-tier <level>` creates the CLAUDE.md from the template and activates your tier.
That's the full onboarding — one command, no extra steps.

> **For richer setup** (`.gitignore`, `.env.example`, project-type templates),
> run `/init-project [real-estate|song-gift|eshop|defi]` instead.
> The command is named `/init-project` (not `/init`) to avoid collision with
> Claude Code's built-in `/init` that scans the codebase.

### Install Options

```bash
bash setup.sh                              # Standard: rules + agents + commands + permissions
bash setup.sh --full                        # Everything: + skills, hooks, MCP
bash setup.sh --with-hooks                  # Standard + hooks
bash setup.sh --solidity                    # Standard + Solidity rules
bash setup.sh --project defi                # Standard + CLAUDE.md template for current project
```

Project types: `real-estate`, `song-gift`, `eshop`, `defi`

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
| `/switch-tier` | Switch skill level in CLAUDE.md (creates CLAUDE.md from template if missing) |
| `/init-project` | Full project setup: CLAUDE.md + .gitignore + .env.example (use instead of built-in `/init`) |

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
- **No 80+ commands** — 9 that matter
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

## Documentation

| Document | Audience | Description |
|----------|----------|-------------|
| [Advanced Cheatsheet](docs/cheatsheet-advanced.md) | Experienced developers | Full reference for every command, rule, agent, skill. Optimal workflow. Token savings analysis. |
| [Beginner's Guide](docs/cheatsheet-beginner.md) | New programmers | How to write good prompts, save tokens, avoid common mistakes. Step-by-step with examples. |

**For beginners:** All CLAUDE.md templates default to BEGINNER mode. To switch, type `/switch-tier` in Claude Code. Each tier controls how Claude communicates and how strictly it enforces workflow rules.

| Level | For whom | Behavior |
|-------|----------|----------|
| **BEGINNER** | Non-programmers | Plain language, asks before every action, no TDD, no agents |
| **INTERMEDIATE** | Some experience | Concise but clear, moderate autonomy, tests alongside code |
| **ADVANCED** | Experienced devs | Terse, fully autonomous, mandatory TDD + code review + agents |

## Safety: Existing ~/.claude Folder

The installer is **additive** — it only copies files into `rules/`, `agents/`, and `commands/`. It does NOT touch:

- `sessions/` (your conversation history)
- `projects/` (project-specific data)
- `memory/` (persistent memory)
- `plans/` (saved plans)
- `mcp-configs/` (your MCP server configs)
- `.agents/` (marketplace plugins)

It WILL overwrite rules, agents, and commands **with the same filenames**. If you have custom files with different names, they're safe. `settings.json` is backed up before any changes.

## Token Efficiency

Rules load on **every prompt** — that's why we keep them lean (~1350 lines total). Agents, commands, and skills load on-demand and don't add to base cost.

| Scenario | Without config | With config + good workflow | Savings |
|----------|---------------|---------------------------|---------|
| Simple bug fix | ~15K tokens | ~10K tokens | ~33% |
| Medium feature | ~80K tokens | ~45K tokens | ~44% |
| Feature with bug loops | ~150K tokens | ~60K tokens | ~60% |
| Wrong-direction work | ~50K tokens wasted | ~2K (plan catches it) | ~96% |

The biggest savings come from `/plan` (prevents wrong-direction waste) and Budget Guard (stops bug loops after 3 attempts).

See [Advanced Cheatsheet](docs/cheatsheet-advanced.md) for detailed token optimization strategies.

## Credits

All base files from [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) by [@affaan-m](https://github.com/affaan-m), MIT license. This repo is a curated, beginner-optimized subset.

## License

MIT

---

# claude-configuration (CZ)

Prenositelna konfigurace Claude Code pro vyvojove tymy. Vybrane z [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) — zamerene na to, co skutecne pomaha.

## Rychla instalace

**Krok 1 — Nainstaluj globalni konfiguraci** (jednou na pocitaci):

```bash
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

Nainstaluje pravidla, agenty a prikazy do `~/.claude/`. Po instalaci restartuj Claude Code.

**Krok 2 — Otevri libovolny projekt a spust Claude Code:**

```bash
cd muj-projekt
claude
```

Claude zjisti, ze projekt nema `CLAUDE.md`, a zepta se na uroven dovednosti
(beginner / intermediate / advanced). Po odpovedi `/switch-tier <uroven>` vytvori
`CLAUDE.md` ze sablony a zapne zvolenou uroven. Tim je onboarding hotovy.

> **Pro plne nastaveni** (`.gitignore`, `.env.example`, sablony pro typy projektu)
> spust `/init-project [real-estate|song-gift|eshop|defi]`.
> Prikaz se jmenuje `/init-project` (ne `/init`), aby nekolidoval s vestavenym
> `/init` v Claude Code, ktery skenuje kod.

## Tri prikazy, ktere meni vysledek

```
/plan "co chces udelat"     # Naplanuj pred kodovanim
/code-review                # Zkontroluj po dokonceni
/verify                     # Spust vsechny kontroly pred commitem
```

Mezi nesouvisejicimi ukoly: `/compact` (uvolni kontext, setri tokeny).

## Moznosti instalace

```bash
bash setup.sh                              # Zaklad: pravidla + agenti + prikazy
bash setup.sh --full                       # Vse: + skills, hooks, MCP
bash setup.sh --with-hooks                 # Zaklad + hooks
bash setup.sh --project eshop              # Zaklad + CLAUDE.md sablona
```

Typy projektu: `real-estate`, `song-gift`, `eshop`, `defi`

## Urovne dovednosti

Vsechny CLAUDE.md sablony jsou ve vychozim nastaveni v BEGINNER modu. Pro prepnuti napis `/switch-tier` v Claude Code.

| Uroven | Pro koho | Chovani |
|--------|----------|---------|
| **BEGINNER** | Neprogramatory | Jednoduchy jazyk, pta se pred akci, zadne TDD, zadni agenti |
| **INTERMEDIATE** | Mirne pokrocile | Strucny ale srozumitelny, testy spolu s kodem |
| **ADVANCED** | Zkusene vyvojare | Maximalne strucny, plne autonomni, povinne TDD + code review |

## Dokumentace

- [Cheatsheet pro pokrocile](docs/cheatsheet-advanced.md) — kompletni reference (EN + CZ)
- [Pruvodce pro zacatecniky](docs/cheatsheet-beginner.md) — jak psat prompty, setrit tokeny (EN + CZ)

## Bezpecnost: existujici slozka ~/.claude

Instalator **pouze pridava** soubory do `rules/`, `agents/` a `commands/`. Nesmaze vase sessions, projekty, pamet ani MCP konfigurace. `settings.json` se pred zmenou zalohuje.
