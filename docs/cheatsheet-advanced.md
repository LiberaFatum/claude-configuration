# Advanced Cheatsheet

Complete reference for getting maximum value from this configuration.

---

## Optimal Workflow

```
1. /plan "feature description"     →  Claude creates plan, you approve
2. /tdd                            →  Tests first, then implementation
3. /code-review                    →  Catches bugs before commit
4. /verify                         →  Build + lint + typecheck + tests
5. git commit                      →  Conventional commit format
```

Between unrelated tasks: `/compact` to free context and save tokens.

---

## All Commands Reference

### /plan — Plan before coding

**When:** Before ANY non-trivial task (new feature, refactoring, complex bug fix).

```
/plan "add user authentication with JWT"
/plan "refactor the scraper module to use async"
/plan "fix the race condition in cart checkout"
```

Claude creates a step-by-step plan and waits for your approval before writing code. This alone prevents 30-50% of wasted tokens from wrong-direction implementations.

**Pro tip:** If the plan looks off, say "no, I want X instead" — redirecting a plan costs ~500 tokens. Redirecting an implementation costs 5000+.

### /tdd — Test-driven development

**When:** Implementing any new logic.

```
/tdd "liquidity score calculator"
/tdd "user registration endpoint"
/tdd "ERC20 token factory"
```

Forces RED-GREEN-REFACTOR cycle: write failing tests, implement to pass, then refactor. Produces more reliable code on the first try.

### /code-review — Review before committing

**When:** After writing or modifying code, before every commit.

```
/code-review                  # Review local uncommitted changes
/code-review 42               # Review GitHub PR #42
/code-review https://...      # Review PR by URL
```

Catches security vulnerabilities, code quality issues, and bugs. Issues are rated CRITICAL/HIGH/MEDIUM/LOW.

### /verify — Run all quality checks

**When:** Before committing, after /code-review.

```
/verify            # Stop at first failure
/verify --all      # Run everything, report all results
```

Auto-detects project type (Python/Node/Solidity/Rust/Go) and runs the appropriate build, lint, typecheck, and test commands.

### /build-fix — Fix build errors

**When:** Build fails and you don't want to debug manually.

```
/build-fix
```

Reads error output, makes minimal changes to fix. Will not refactor or add features — just gets the build green.

### /test-coverage — Check test coverage

**When:** After writing tests, to verify you hit the 80% target.

```
/test-coverage
```

### /refactor-clean — Remove dead code

**When:** After a feature is complete and you want to clean up.

```
/refactor-clean
```

Finds unused functions, variables, imports, and safely removes them.

### /init — Initialize a new project

**When:** Starting a new project directory.

```
/init                    # Base template (fill in yourself)
/init real-estate        # Pre-filled for scraper project
/init song-gift          # Pre-filled for AI music site
/init eshop              # Pre-filled for e-commerce
/init defi               # Pre-filled for smart contracts
```

Creates CLAUDE.md, .gitignore, and .env.example in the current directory.

### /switch-tier — Switch skill level

**When:** Changing how Claude communicates and enforces workflow rules.

```
/switch-tier beginner        # Plain language, asks before acting, no TDD
/switch-tier intermediate    # Concise but clear, moderate autonomy
/switch-tier advanced        # Terse, fully autonomous, full workflow
```

Edits the `CLAUDE.md` in your project root — swaps the active tier by toggling comment markers. Defaults to BEGINNER on fresh installs.

---

## Rules Reference

Rules load automatically on every prompt. You don't invoke them — they shape Claude's behavior.

### Common rules (all projects)

| Rule | What it does |
|------|-------------|
| `coding-style` | Immutability, KISS, DRY, YAGNI, file size limits (<400 lines), function limits (<50 lines) |
| `security` | Never commit secrets, validate input, parameterized queries, rate limiting |
| `testing` | 80% coverage minimum, TDD workflow, AAA pattern, web-specific testing (a11y, responsive) |
| `git-workflow` | Conventional commits format: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:` |
| `development-workflow` | Research-Plan-TDD-Review-Commit pipeline |
| `code-review` | Review checklist, severity levels, security triggers |

### Language-specific rules

| Language | Rules | Loaded when |
|----------|-------|-------------|
| Python | coding-style, security, testing, patterns | `.py` files in scope |
| TypeScript | coding-style, security, patterns | `.ts`/`.tsx`/`.js`/`.jsx` files |
| Web | coding-style, security, performance, design-quality, patterns | Frontend work |
| Solidity | coding-style, security, testing | `.sol` files (opt-in install) |

### Key behaviors these rules enforce

- **Immutability**: Claude returns new objects instead of mutating inputs
- **No console.log/print()**: Uses proper loggers
- **Input validation**: Zod schemas (TS) or Pydantic (Python) at API boundaries
- **Checks-Effects-Interactions**: For Solidity contracts
- **Anti-template design**: Frontend code must look intentional, not like a default template

---

## Agents Reference

Agents are specialist sub-models Claude invokes automatically. You rarely need to call them directly.

| Agent | Model | Auto-triggers when... |
|-------|-------|----------------------|
| `planner` | Opus | Complex feature request or `/plan` |
| `code-reviewer` | Sonnet | `/code-review` or when code quality is questionable |
| `tdd-guide` | Sonnet | `/tdd` or when writing tests |
| `build-error-resolver` | Sonnet | Build fails |
| `security-reviewer` | Sonnet | Code touches auth, payments, user data, crypto |
| `python-reviewer` | Sonnet | Python code review |
| `typescript-reviewer` | Sonnet | TypeScript/JS code review |
| `database-reviewer` | Sonnet | SQL, migrations, schema changes |
| `refactor-cleaner` | Sonnet | `/refactor-clean` |

**Token impact:** Agents load on-demand only. They cost tokens when invoked, not on every prompt.

---

## Skills Reference

Skills are large knowledge documents loaded on-demand when Claude needs detailed patterns.

| Skill | Size | Triggers when... |
|-------|------|------------------|
| `postgres-patterns` | 147 lines | Working with PostgreSQL, writing SQL, creating migrations |
| `frontend-patterns` | 642 lines | Working with React components, state management, data fetching |

**Token impact:** Skills only load when their topic is relevant. They don't add to base prompt cost.

---

## Token Savings Guide

### What costs tokens

| Component | Tokens/prompt | When |
|-----------|---------------|------|
| Rules (all loaded) | ~1400 | Every prompt |
| CLAUDE.md | ~300-500 | Every prompt |
| Agent invocation | ~300-1100 | On-demand |
| Skill activation | ~200-800 | On-demand |
| Your message + code context | Varies | Every prompt |

### How to minimize waste

1. **Always /plan first** — A bad plan costs ~500 tokens to fix. A bad implementation costs 5000-20000 tokens in fix loops. Planning ROI is 10-40x.

2. **Use /compact between unrelated tasks** — After finishing a task, `/compact` clears accumulated context. A fresh context means cheaper, faster, more accurate responses.

3. **Be specific in prompts** — "Add user auth" → Claude guesses, likely wrong. "Add JWT auth with refresh tokens using the auth/ module pattern from the existing code" → Claude gets it right first try.

4. **Don't ask Claude to fix its own bugs in a loop** — If it fails 3 times, the Budget Guard in CLAUDE.md stops it. Read the error yourself, give Claude the specific diagnosis.

5. **One task per session** — Don't mix "fix the login bug" with "also add a new feature." Each task gets its own clean context.

6. **Use the right model** — Opus for planning and architecture, Sonnet for routine coding. You can switch with `/model`.

### Estimated savings from this configuration

| Scenario | Without config | With config | Savings |
|----------|---------------|-------------|---------|
| Bug fix (simple) | ~15K tokens | ~10K tokens | ~33% |
| New feature (medium) | ~80K tokens | ~45K tokens | ~44% |
| Feature with bugs | ~150K tokens | ~60K tokens | ~60% |
| Wrong-direction implementation | ~50K tokens wasted | ~2K tokens (plan catch) | ~96% |

The biggest savings come from **preventing wrong-direction work** (/plan) and **stopping bug loops** (Budget Guard + 3-attempt limit).

---

## Hooks Reference (opt-in)

Installed with `--with-hooks` or `--full`.

| Hook | Trigger | Effect |
|------|---------|--------|
| `post-edit-file-size-warn.sh` | After Claude edits a file | Warning if >400 lines, error if >800 |
| `pre-commit-secrets-check.sh` | Before git commit | Blocks commits with API keys, private keys |
| `post-edit-console-warn.sh` | After Claude edits a file | Warning about console.log/print() |

---

## MCP Servers Reference (opt-in)

Installed with `--full`.

| Server | What it does | API key? |
|--------|-------------|----------|
| Context7 | Live library documentation lookup | No |
| GitHub | PR management, code search | Yes (PAT) |
| Playwright | Browser automation, E2E testing | No |

---

## Advanced Tips

### Custom rules for a specific project

Add project-local rules in `<project>/.claude/rules/`:

```bash
mkdir -p .claude/rules
echo "Always use snake_case for database column names." > .claude/rules/database.md
```

These load only for that project.

### Running parallel reviews

When working on a large PR, ask Claude to review security and code quality in parallel:

```
Review this PR — run security-reviewer and code-reviewer agents in parallel.
```

### Debugging token usage

After a session, check `/usage` to see how many tokens were consumed. If it's higher than expected:
- Were there fix loops? (Budget Guard should prevent this)
- Did you switch topics without `/compact`?
- Did you provide enough context in the initial prompt?

---

# Cheatsheet pro pokrocile (CZ)

Kompletni reference pro maximalni vyuziti teto konfigurace.

---

## Optimalni workflow

```
1. /plan "popis funkce"              →  Claude vytvori plan, ty schvalis
2. /tdd                              →  Nejdriv testy, pak implementace
3. /code-review                      →  Odchyti bugy pred commitem
4. /verify                           →  Build + lint + typecheck + testy
5. git commit                        →  Conventional commit format
```

Mezi nesouvisejicimi ukoly: `/compact` pro uvolneni kontextu a usetreni tokenu.

---

## Prehled vsech prikazu

| Prikaz | Kdy pouzit | Co dela |
|--------|------------|---------|
| `/plan` | Pred jakymkoliv netrivialnim ukolem | Vytvori plan krok za krokem, ceka na schvaleni |
| `/tdd` | Pri implementaci nove logiky | RED-GREEN-REFACTOR cyklus |
| `/code-review` | Po napsani/uprave kodu, pred commitem | Kontrola bezpecnosti, kvality, bugu |
| `/verify` | Pred commitem, po /code-review | Spusti build + lint + typecheck + testy |
| `/build-fix` | Kdyz build selze | Minimalni zmeny pro opravu buildu |
| `/test-coverage` | Po napsani testu | Overi 80%+ pokryti |
| `/refactor-clean` | Po dokonceni funkce | Najde a odstrani mrtvy kod |
| `/init` | Zakladani noveho projektu | Vytvori CLAUDE.md, .gitignore, .env.example |
| `/switch-tier` | Zmena urovne | Prepne beginner/intermediate/advanced v CLAUDE.md |

---

## Reference pravidel

Pravidla se nacitaji automaticky pri kazdem promptu. Nemusite je vyvolavat — formovaji chovani Clauda.

### Spolecna pravidla (vsechny projekty)

| Pravidlo | Co dela |
|----------|---------|
| `coding-style` | Immutabilita, KISS, DRY, YAGNI, limity velikosti souboru (<400 radku), limity funkci (<50 radku) |
| `security` | Nikdy necommitovat tajemstvi, validovat vstup, parametrizovane dotazy, rate limiting |
| `testing` | 80% pokryti minimum, TDD workflow, AAA vzor |
| `git-workflow` | Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:` |
| `development-workflow` | Research-Plan-TDD-Review-Commit pipeline |
| `code-review` | Review checklist, urovne zavaznosti, bezpecnostni triggery |

### Jazykove specificka pravidla

| Jazyk | Pravidla | Kdy se nacitaji |
|-------|----------|-----------------|
| Python | coding-style, security, testing, patterns | `.py` soubory |
| TypeScript | coding-style, security, patterns | `.ts`/`.tsx`/`.js`/`.jsx` soubory |
| Web | coding-style, security, performance, design-quality, patterns | Frontendova prace |
| Solidity | coding-style, security, testing | `.sol` soubory (opt-in) |

---

## Reference agentu

Agenti jsou specialistni sub-modely, ktere Claude vyvolava automaticky.

| Agent | Model | Automaticky se spusti kdyz... |
|-------|-------|-------------------------------|
| `planner` | Opus | Komplexni pozadavek nebo `/plan` |
| `code-reviewer` | Sonnet | `/code-review` nebo pochybna kvalita kodu |
| `tdd-guide` | Sonnet | `/tdd` nebo psani testu |
| `build-error-resolver` | Sonnet | Build selze |
| `security-reviewer` | Sonnet | Kod se dotyka auth, plateb, uzivatelskeych dat |
| `python-reviewer` | Sonnet | Python code review |
| `typescript-reviewer` | Sonnet | TypeScript/JS code review |
| `database-reviewer` | Sonnet | SQL, migrace, zmeny schematu |
| `refactor-cleaner` | Sonnet | `/refactor-clean` |

**Dopad na tokeny:** Agenti se nacitaji on-demand. Stoji tokeny jen kdyz jsou vyvolani, ne pri kazdem promptu.

---

## Pruvodce usporou tokenu

### Co stoji tokeny

| Komponenta | Tokeny/prompt | Kdy |
|------------|---------------|-----|
| Pravidla (vsechna nactena) | ~1400 | Kazdy prompt |
| CLAUDE.md | ~300-500 | Kazdy prompt |
| Vyvolani agenta | ~300-1100 | On-demand |
| Aktivace skillu | ~200-800 | On-demand |

### Jak minimalizovat plytvan

1. **Vzdy nejdriv /plan** — Spatny plan stoji ~500 tokenu na opravu. Spatna implementace 5000-20000.
2. **Pouzivat /compact mezi ukoly** — Cisty kontext = levnejsi, rychlejsi, presnejsi odpovedi.
3. **Byt konkretni v promptech** — "Pridej auth" → Claude hada. "Pridej JWT auth s refresh tokeny pomoci vzoru z auth/ modulu" → Claude trafi naprvic.
4. **Nenechat Clauda opravovat vlastni bugy v smycce** — Pokud selze 3x, Budget Guard ho zastavi. Prectete chybu sami.
5. **Jeden ukol na session** — Nemichejte "oprav login bug" s "taky pridej novou funkci."
6. **Spravny model** — Opus pro planovani a architekturu, Sonnet pro rutinni kodovani. Prepnuti: `/model`.

### Odhadovane uspory z teto konfigurace

| Scenar | Bez konfigurace | S konfiguraci | Uspora |
|--------|-----------------|---------------|--------|
| Jednoduchy bug fix | ~15K tokenu | ~10K tokenu | ~33% |
| Stredne velka funkce | ~80K tokenu | ~45K tokenu | ~44% |
| Funkce s bugy | ~150K tokenu | ~60K tokenu | ~60% |
| Spatny smer implementace | ~50K tokenu | ~2K (plan to chyti) | ~96% |

---

## Pokrocile tipy

### Vlastni pravidla pro konkretni projekt

Pridejte lokalni pravidla v `<projekt>/.claude/rules/`:

```bash
mkdir -p .claude/rules
echo "Vzdy pouzivej snake_case pro nazvy databazovych sloupcu." > .claude/rules/database.md
```

Tato se nacitaji jen pro dany projekt.

### Paralelni review

Pri praci na velkem PR pozadejte Clauda o paralelni kontrolu:

```
Zkontroluj tento PR — spust security-reviewer a code-reviewer agenty paralelne.
```

### Ladeni spotreby tokenu

Po session zkontrolujte `/usage`. Pokud je vyssi nez ocekavane:
- Byly tam opravne smycky? (Budget Guard by mel zabranit)
- Zmenili jste tema bez `/compact`?
- Dali jste dostatek kontextu v pocatecnim promptu?
