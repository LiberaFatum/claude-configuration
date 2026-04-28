---
description: Test-driven development workflow. Write tests first, then implement.
---

# TDD Workflow

Implement a feature or fix using strict test-driven development.

## Arguments

`$ARGUMENTS` — describe what to implement (e.g., "user registration endpoint", "liquidity score calculator").

## Workflow

Follow these steps in exact order. Never skip the RED phase.

### Step 1: Understand the requirement

- Read the relevant code to understand the context.
- Identify the function, endpoint, or component to implement.
- Decide on the test file location and naming.

### Step 2: Write tests FIRST (RED)

Write tests that describe the expected behavior. Include:

- **Happy path** — the normal successful case
- **Edge cases** — empty input, zero values, max values, null
- **Error cases** — invalid input, missing dependencies, network failures

Use the AAA pattern (Arrange-Act-Assert):

```
test('descriptive name explaining the behavior', () => {
  // Arrange - set up inputs and expected outputs
  // Act - call the function under test
  // Assert - verify the result
})
```

### Step 3: Run tests — verify FAIL

Run the tests. They MUST fail. If they pass, the tests are not testing new behavior.

```bash
# Python
pytest tests/path/to/test_file.py -v

# TypeScript/JavaScript
npm test -- path/to/test.ts

# Solidity
forge test --match-contract TestContractName -vv
```

### Step 4: Implement minimal code (GREEN)

Write the simplest code that makes all tests pass. Do not add anything beyond what the tests require.

### Step 5: Run tests — verify PASS

Run the same tests. They must all pass. If any fail, fix the implementation (not the tests, unless the tests are wrong).

### Step 6: Refactor (IMPROVE)

Now that tests are green, improve the code:

- Extract constants for magic numbers
- Improve naming
- Reduce duplication
- Split large functions

### Step 7: Verify tests still pass

Run tests one more time after refactoring to ensure nothing broke.

### Step 8: Check coverage

```bash
# Python
pytest --cov=src --cov-report=term-missing tests/

# TypeScript
npm test -- --coverage

# Solidity
forge coverage
```

Target: 80% minimum. 100% for financial calculations, auth logic, and security-critical code.

## Best Practices

**DO:**
- Write the test FIRST, before any implementation
- Run tests and verify they FAIL before implementing
- Write minimal code to make tests pass
- Refactor only after tests are green
- Test behavior, not implementation details

**DON'T:**
- Write implementation before tests
- Skip running tests after each change
- Write too much code at once
- Mock everything — prefer integration tests where practical
- Ignore failing tests

## Test Types

| Type | Scope | Speed | When |
|------|-------|-------|------|
| Unit | Single function | Fast | Always |
| Integration | API endpoint, DB operation | Medium | When touching boundaries |
| E2E | Full user flow | Slow | Critical paths only |

## Coverage Requirements

- **80% minimum** for all new code
- **100% required** for: financial calculations, auth logic, security-critical code, core business logic

## After TDD

- Use `/code-review` to review the implementation
- Use `/test-coverage` to verify coverage numbers
- Use `/verify` to run all quality checks
