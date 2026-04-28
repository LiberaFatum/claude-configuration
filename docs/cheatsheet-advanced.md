# Advanced Cheatsheet

Reference for what this configuration provides. Assumes you know Claude Code basics.

---

## Recommended workflow

```
/plan "feature description"     # plan → approve
/tdd                            # tests first, then code
/code-review                    # review uncommitted changes
/verify                         # build + lint + typecheck + tests
git commit                      # conventional commit
```

`/compact` between unrelated tasks. `Esc` to interrupt mid-response.

---

## Commands

| Command | Use when |
|---------|----------|
| `/plan "..."` | Before any non-trivial change. Pauses for approval before code. |
| `/tdd "..."` | Implementing new logic. Forces RED-GREEN-REFACTOR. |
| `/code-review` | Before commit. Local diff or `/code-review <PR#>` for GitHub PRs. |
| `/verify` | Before commit. Auto-detects stack, runs build + lint + typecheck + tests. |
| `/build-fix` | Build is red, you want minimal fix. Won't refactor. |
| `/test-coverage` | After tests, verifies 80% target. |
| `/refactor-clean` | After feature is complete. Removes dead code. |
| `/init-project [type]` | New project. Creates CLAUDE.md + .gitignore + .env.example. |
| `/switch-tier <level>` | Toggle BEGINNER / INTERMEDIATE / ADVANCED. Creates CLAUDE.md if missing. |

`/init-project` types: `real-estate`, `song-gift`, `eshop`, `defi`, or empty (base).

---

## Rules (auto-loaded)

Loaded on every prompt. Shape Claude's behavior — you don't invoke them.

**Common (all projects):** `coding-style`, `security`, `testing`, `git-workflow`,
`development-workflow`, `code-review`, `onboarding`.

**Stack-specific:** `python/`, `typescript/`, `web/`, `solidity/` (opt-in).

Key behaviors enforced:
- Immutability — return new objects, don't mutate
- File limits — 400 lines target, 800 hard cap
- Function limits — 50 lines
- No `console.log` / `print()` for logging
- Conventional commits
- Input validation at API boundaries (Zod / Pydantic)
- 80% test coverage target on new code
- Anti-template frontend design (no default Tailwind/shadcn looks)

---

## Agents (auto-invoked)

You don't call them by name. Claude routes work to them based on context.

| Agent | Triggered by |
|-------|--------------|
| `planner` | `/plan` or complex feature requests |
| `code-reviewer` | `/code-review` or post-edit review |
| `tdd-guide` | `/tdd` or test writing |
| `build-error-resolver` | `/build-fix` or build failures |
| `security-reviewer` | Auth, payments, user data, crypto changes |
| `python-reviewer` | Python file review |
| `typescript-reviewer` | TS/JS file review |
| `database-reviewer` | SQL, migrations, schema changes |
| `refactor-cleaner` | `/refactor-clean` |

Agents load on demand — no cost when not invoked.

---

## Skills (`--full` install only)

| Skill | Activates on |
|-------|--------------|
| `postgres-patterns` | SQL, migrations, schema work |
| `frontend-patterns` | React components, state, data fetching |

---

## Hooks (`--with-hooks` install only)

| Hook | Trigger | Effect |
|------|---------|--------|
| `post-edit-file-size-warn.sh` | After file edit | Warn >400 lines, error >800 |
| `pre-commit-secrets-check.sh` | Before commit | Block commits containing API keys / private keys |
| `post-edit-console-warn.sh` | After file edit | Warn about `console.log` / `print()` |

---

## MCP servers (`--full` install only)

| Server | Provides | Auth |
|--------|----------|------|
| Context7 | Live library docs | None |
| GitHub | PR / code search | PAT |
| Playwright | Browser automation | None |

---

## Token discipline

What costs tokens on every prompt:

| Component | Approx tokens |
|-----------|---------------|
| All loaded rules | ~1400 |
| CLAUDE.md | ~300–500 |
| Your message + cited context | varies |

What doesn't cost tokens until used: agents, skills, hooks, MCP servers.

The biggest leaks (in rough order):

1. **Wrong-direction implementations** — fix with `/plan` before coding.
2. **Bug loops** — Budget Guard halts after 3 attempts. Read the error yourself.
3. **Stale context across topics** — `/compact` between unrelated tasks.
4. **Vague prompts** — cite files with `@path`, name behaviors, name acceptance criteria.
5. **Mixed tasks in one session** — keep one feature per session.

---

## Per-project customization

Add project-local rules in `.claude/rules/` inside the project:

```bash
mkdir -p .claude/rules
echo "Always use snake_case for database column names." > .claude/rules/db.md
```

These layer on top of the global rules and only load for that project.

---

## Tier behavior summary

| Tier | Communication | Autonomy | TDD | Agents |
|------|---------------|----------|-----|--------|
| BEGINNER | Plain language, explains everything | Asks before each action | Optional | Off |
| INTERMEDIATE | Concise, terms with brief clarifications | Acts on routine tasks, asks on architecture | Tests alongside code | On (silent) |
| ADVANCED | Terse, no narration | Full autonomy through Plan→TDD→Review→Commit | Mandatory | On (named) |

Switch with `/switch-tier <level>`. Tier lives in your project's `CLAUDE.md`, so each project can run a different tier.

---

# Cheatsheet pro pokrocile (CZ)

Reference k tomu, co tato konfigurace nabizi. Predpoklada znalost zakladu Claude Code.

---

## Doporuceny workflow

```
/plan "popis funkce"            # plan → schvaleni
/tdd                            # nejdriv testy, pak kod
/code-review                    # kontrola necommitnutych zmen
/verify                         # build + lint + typecheck + testy
git commit                      # conventional commit
```

`/compact` mezi nesouvisejicimi ukoly. `Esc` pro preruseni odpovedi.

---

## Prikazy

| Prikaz | Pouzit kdy |
|--------|------------|
| `/plan "..."` | Pred kazdou netrivialni zmenou. Ceka na schvaleni. |
| `/tdd "..."` | Implementace nove logiky. Vynuti RED-GREEN-REFACTOR. |
| `/code-review` | Pred commitem. Lokalni diff nebo `/code-review <PR#>`. |
| `/verify` | Pred commitem. Detekuje stack, spusti build + lint + typecheck + testy. |
| `/build-fix` | Build je cerveny, chces minimalni opravu. |
| `/test-coverage` | Po testech, overi 80% cil. |
| `/refactor-clean` | Po dokoncene funkci. Smaze mrtvy kod. |
| `/init-project [typ]` | Novy projekt. Vytvori CLAUDE.md + .gitignore + .env.example. |
| `/switch-tier <uroven>` | Prepnuti BEGINNER / INTERMEDIATE / ADVANCED. Vytvori CLAUDE.md pokud chybi. |

Typy `/init-project`: `real-estate`, `song-gift`, `eshop`, `defi`, nebo prazdne (zaklad).

---

## Pravidla (auto-load)

Nacitaji se pri kazdem promptu. Formuji chovani Clauda — nevyvolavate je.

**Spolecna:** `coding-style`, `security`, `testing`, `git-workflow`,
`development-workflow`, `code-review`, `onboarding`.

**Podle stacku:** `python/`, `typescript/`, `web/`, `solidity/` (opt-in).

Klicove vynucene chovani:
- Immutabilita — vracet nove objekty, nemenit
- Limity souboru — cil 400 radku, hard cap 800
- Limity funkci — 50 radku
- Zadne `console.log` / `print()` pro logovani
- Conventional commits
- Validace vstupu na API hranicich (Zod / Pydantic)
- Cil 80% pokryti testy
- Anti-template frontend design

---

## Agenti (auto-vyvolani)

Nevolas je jmenem. Claude smeruje praci podle kontextu.

| Agent | Spousti se kdyz |
|-------|-----------------|
| `planner` | `/plan` nebo komplexni pozadavek |
| `code-reviewer` | `/code-review` nebo review po editaci |
| `tdd-guide` | `/tdd` nebo psani testu |
| `build-error-resolver` | `/build-fix` nebo selhani buildu |
| `security-reviewer` | Auth, platby, uzivatelska data, krypto |
| `python-reviewer` | Review Python souboru |
| `typescript-reviewer` | Review TS/JS souboru |
| `database-reviewer` | SQL, migrace, zmeny schematu |
| `refactor-cleaner` | `/refactor-clean` |

Agenti se nacitaji on-demand — nestoji nic pokud nejsou vyvolani.

---

## Disciplina pri tokenech

Co stoji tokeny pri kazdem promptu:

| Komponenta | Pribl. tokeny |
|------------|---------------|
| Vsechna nactena pravidla | ~1400 |
| CLAUDE.md | ~300–500 |
| Vase zprava + odkazy | promenne |

Co nestoji tokeny do pouziti: agenti, skills, hooks, MCP servery.

Nejvetsi unik (v hrubem poradi):

1. **Spatny smer implementace** — resis pomoci `/plan` pred kodovanim.
2. **Smycky pri opravach** — Budget Guard zastavi po 3 pokusech. Prectete chybu sami.
3. **Stary kontext mezi tematy** — `/compact` mezi nesouvisejicimi ukoly.
4. **Vague prompty** — cituj soubory pres `@cesta`, jmenuj chovani, jmenuj kriteria.
5. **Smichane ukoly v jedne session** — jedna funkce na session.

---

## Customizace per projekt

Pridejte projektove pravidla do `.claude/rules/` v projektu:

```bash
mkdir -p .claude/rules
echo "Vzdy pouzivej snake_case pro nazvy databazovych sloupcu." > .claude/rules/db.md
```

Vrstvi se nad globalni pravidla a nacitaji se jen pro dany projekt.

---

## Shrnuti chovani po urovnich

| Uroven | Komunikace | Autonomie | TDD | Agenti |
|--------|------------|-----------|-----|--------|
| BEGINNER | Jednoduchy jazyk, vysvetluje vse | Pta se pred kazdou akci | Volitelne | Vypnuti |
| INTERMEDIATE | Strucne, terminy s vysvetlenim | Rutina samostatne, architektura s dotazem | Testy spolu s kodem | Zapnuti (tise) |
| ADVANCED | Maximalne strucne, bez narace | Plna autonomie pres Plan→TDD→Review→Commit | Povinne | Zapnuti (jmenovani) |

Prepnuti: `/switch-tier <uroven>`. Uroven je v `CLAUDE.md` projektu, takze kazdy projekt muze bezet na jine urovni.
