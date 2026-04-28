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

## User Context

<!-- Uncomment ONE block based on your experience level: -->

<!-- BEGINNER:
I am learning to program. When working on this project:
- Explain what you changed and why in simple terms.
- If you encounter an error, explain what went wrong before trying to fix it.
- If something is too complex, suggest a simpler approach first.
- Do not add features I did not ask for.
-->

<!-- ADVANCED:
I am an experienced developer. Be concise:
- Summarize what changed in 2-3 sentences.
- If a request is ambiguous, ask one clarifying question rather than guessing.
- If you cannot solve a problem in 3 attempts, stop and explain what you tried.
-->
