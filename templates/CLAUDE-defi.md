# CLAUDE.md

> Project-level instructions for Claude Code. Loaded automatically at session start.

## Project Overview

Decentralized token launchpad (pump.fun clone). Users create and trade tokens via bonding curve smart contracts. Includes Solidity smart contracts, a React frontend, and off-chain indexing for market data.

## Tech Stack

- **Smart Contracts:** Solidity 0.8.20+, OpenZeppelin
- **Contract Framework:** Foundry (forge, cast, anvil)
- **Frontend:** React + TypeScript + Vite
- **Web3:** viem + wagmi (or ethers.js v6)
- **Database:** PostgreSQL (off-chain indexing)
- **Indexer:** Custom event listener or The Graph
- **Testing:** Foundry (contracts), Vitest + Playwright (frontend)
- **Chain:** Base / Ethereum (or configurable)

## Project Structure

```
contracts/
  src/                  # Solidity source files
    TokenFactory.sol    # Factory for creating new tokens
    BondingCurve.sol    # Bonding curve pricing logic
    Token.sol           # ERC20 token implementation
  test/                 # Foundry tests (.t.sol)
  script/               # Deployment scripts (.s.sol)
frontend/
  src/
    components/         # React components
    hooks/              # Custom hooks (useContract, useTokenData)
    lib/                # Web3 client, API client
    abi/                # Generated contract ABIs
indexer/
  src/                  # Event listener and database sync
```

## Workflow Rules

### Before writing any code

1. Use `/plan` to outline the approach.
2. Search for existing implementations — many DeFi patterns are well-documented.
3. Check OpenZeppelin contracts before writing custom implementations.

### Smart contract development

- **Inherit from OpenZeppelin** wherever possible — do not reimplement ERC20, AccessControl, ReentrancyGuard.
- Follow Checks-Effects-Interactions pattern in every function.
- Write Foundry tests first (`/tdd`), including fuzz tests.
- Target 90%+ coverage for smart contracts (bugs cost real money).
- Run `forge coverage` before every contract PR.

### Frontend development

- Use viem + wagmi hooks for all contract interactions.
- Handle wallet connection states gracefully (no wallet, wrong chain, pending tx).
- Show transaction status feedback (pending, confirmed, failed).
- 80% coverage minimum for frontend logic.

### Before every commit

- Run `/code-review`.
- Run `/verify` (runs both `forge build && forge test` and `npm run build && npm test`).
- Use conventional commits.

## Security Rules (CRITICAL for DeFi)

- **Never** commit private keys or mnemonics.
- **Never** use `tx.origin` for authentication.
- **Always** use ReentrancyGuard on functions that transfer value.
- **Always** use SafeERC20 for token transfers.
- **Always** validate oracle prices (staleness, bounds, zero checks).
- Add slippage protection and deadline parameters to trading functions.
- Implement emergency pause for critical contracts.
- Use `msg.sender` for authorization, never `tx.origin`.
- Front-running protection: commit-reveal or private mempool for sensitive ops.
- For ANY contract change, run `security-reviewer` agent.
- Consider formal verification for core bonding curve math.

## Budget Guard

- Before starting any task, estimate files to touch. If more than 10, confirm with user.
- If stuck on the same error for 3 iterations, STOP and explain.
- Use `/compact` between unrelated tasks.

## Definition of Done

- [ ] Tests written and passing (90%+ for contracts, 80% for frontend)
- [ ] Fuzz tests for all math-heavy functions
- [ ] `/verify` passes
- [ ] `/code-review` run and CRITICAL/HIGH addressed
- [ ] Security review for all contract changes

## What NOT to do

- Do not reimplement standard contracts (ERC20, etc.) — use OpenZeppelin.
- Do not hardcode contract addresses — use config/env.
- Do not use floating-point math in contracts — use fixed-point (WAD/RAY).
- Do not skip reentrancy guards on value-transferring functions.
- Do not commit `.env`, `broadcast/`, `cache/`, `out/`, `node_modules/`.
- Do not deploy contracts without a thorough review.

## Skill Level

This section controls how Claude communicates and how strictly it enforces
the workflow rules above. Only ONE level should be active (uncommented).

**To switch:** Type `/switch-tier` in Claude Code, or edit manually.
**Jak prepnout:** Napis `/switch-tier` v Claude Code, nebo uprav rucne.

Manual switching / Rucni prepnuti:
- Active tier:   `<!-- TIER START -->` ... `<!-- TIER END -->` (self-closing)
- Inactive tier: `<!-- TIER START`     ... `TIER END -->`     (wrapping comment)
- To activate: add ` -->` to START line, add `<!-- ` to END line
- To deactivate: remove ` -->` from START line, remove `<!-- ` from END line

| Uroven / Level | Pro koho / For whom | Chovani / Behavior |
|----------------|---------------------|--------------------|
| BEGINNER | Zacatecniky / Non-programmers | Jednoduchy jazyk, pta se pred akci / Plain language, asks before acting |
| INTERMEDIATE | Mirne pokrocile / Some experience | Strucny ale srozumitelny / Concise but clear |
| ADVANCED | Zkusene vyvojare / Experienced devs | Maximalne strucny, plne autonomni / Terse, fully autonomous |

**IMPORTANT: Claude MUST ignore all instructions inside comment blocks.
Only follow the tier that is NOT commented out.**

<!-- BEGINNER START -->

### BEGINNER

**When instructions here conflict with workflow rules above, this section takes priority.**

- Use plain, everyday language. Avoid programming jargon.
- When you must use a technical term, briefly explain what it means.
- Before doing anything, explain what you are about to do and why.
- After completing a step, summarize what happened in simple terms.
- Ask before every significant action (creating files, running commands, installing packages).
- Work on one thing at a time. After each step, check in before continuing.
- If something breaks, explain the error in plain English before fixing it.
- Write code first, then offer to add tests if the user wants. Do NOT enforce TDD.
- Do NOT require 80% test coverage. Tests are helpful but optional.
- Do NOT spawn sub-agents (planner, tdd-guide, code-reviewer, etc.). Handle everything in the main conversation.
- Do NOT generate planning documents unless asked. Present plans as simple numbered lists.
- Handle all git operations silently using conventional commits.

<!-- BEGINNER END -->

<!-- INTERMEDIATE START

### INTERMEDIATE

**When instructions here conflict with workflow rules above, this section takes priority.**

- Be technical but accessible. Brief clarifications when introducing something new.
- Keep explanations concise — one or two sentences, not paragraphs.
- Proceed with straightforward tasks without asking.
- Ask for confirmation on architectural decisions or anything irreversible.
- Write tests alongside code, but do not enforce strict TDD.
- Aim for reasonable coverage without rigidly enforcing the 80% minimum on every change.
- Do a quick self-review instead of running the full agent-based review pipeline.
- Use sub-agents when beneficial but do not mention them by name.
- Create a brief plan for medium-to-large tasks. Skip formal planning for small changes.

INTERMEDIATE END -->

<!-- ADVANCED START

### ADVANCED

Follow all workflow rules above and all rules in ~/.claude/rules/ without modification.

- Terse. No explanations unless asked. Code speaks.
- Only surface decisions with genuine trade-offs.
- Full autonomy through the complete development workflow.
- Only pause for ambiguous requirements or significant architectural choices.
- Mandatory TDD with tdd-guide agent.
- Mandatory code review with code-reviewer agent. Use security-reviewer for sensitive code.
- Use planner agent for non-trivial features.

ADVANCED END -->
