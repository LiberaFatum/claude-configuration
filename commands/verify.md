---
description: Run build, lint, typecheck, and tests in sequence. Reports pass/fail for each step.
---

# Verify

Run all quality checks for the current project. Stop at the first failure and report what broke.

## Arguments

`$ARGUMENTS` — optional: `--all` to continue past failures and report everything.

## Steps

### 1. Detect project type

Check for these files in order and use the first match:

| File | Stack | Build | Lint | Typecheck | Test |
|------|-------|-------|------|-----------|------|
| `pyproject.toml` or `setup.py` | Python | `python -m compileall src/` | `ruff check .` | `mypy .` | `pytest` |
| `package.json` | Node/TS | `npm run build` | `npm run lint` | `npx tsc --noEmit` | `npm test` |
| `foundry.toml` | Solidity | `forge build` | — | — | `forge test` |
| `Cargo.toml` | Rust | `cargo build` | `cargo clippy` | — | `cargo test` |
| `go.mod` | Go | `go build ./...` | `go vet ./...` | — | `go test ./...` |

If the project has both `pyproject.toml` and `package.json` (full-stack), run both stacks.

### 2. Run checks in order

For each step that applies to the detected stack:

1. **Build** — compile or syntax-check
2. **Lint** — static analysis
3. **Typecheck** — type verification
4. **Test** — run test suite

Default: stop at first failure. With `--all`: run every step and collect results.

### 3. Report

Show a summary table:

```
Verification Results
────────────────────
Build:     PASS
Lint:      PASS
Typecheck: FAIL (3 errors in src/api/routes.py)
Tests:     SKIPPED (blocked by typecheck failure)
────────────────────
Status: FAIL
```

## Rules

- Use the project's own scripts (from package.json / pyproject.toml) when available.
- If a check tool is not installed, skip it and note "SKIPPED (tool not found)".
- Do not install missing tools — just report them.
- Show only the first 20 lines of error output per step. Full output is in the terminal.
