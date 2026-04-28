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
