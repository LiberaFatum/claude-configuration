---
paths:
  - "**/*.sol"
---
# Solidity Security Rules

> Security checklist for smart contract development. Vulnerabilities here can lose real money.

## Reentrancy Protection

- Follow Checks-Effects-Interactions pattern in ALL external-facing functions
- Use OpenZeppelin `ReentrancyGuard` for functions that transfer ETH or tokens
- Never update state after an external call

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Vault is ReentrancyGuard {
    function withdraw(uint256 amount) external nonReentrant {
        // Checks, Effects, then Interactions
    }
}
```

## Access Control

- Use OpenZeppelin `Ownable` or `AccessControl` — never roll your own
- Use `msg.sender` for authorization, NEVER `tx.origin`
- Implement two-step ownership transfer for critical contracts

## Integer Safety

- Solidity 0.8+ has built-in overflow/underflow protection
- Use `unchecked` blocks ONLY when you have mathematically proven no overflow is possible
- Be careful with downcasting (uint256 to uint128) — check bounds first

## Front-Running Awareness

- Assume all pending transactions are visible to attackers
- Use commit-reveal schemes for sensitive operations (auctions, randomness)
- Consider using private mempools or flashbot-protected submission for critical transactions
- Add slippage protection and deadline parameters to swap functions

## Oracle Security

- Never rely on a single price oracle
- Use time-weighted average prices (TWAP) where possible
- Add sanity checks on oracle return values (staleness, zero price, negative price)
- Protect against flash loan price manipulation

## Token Approvals

- Use `safeTransferFrom` from OpenZeppelin's SafeERC20
- Be aware of the approve/transferFrom race condition
- Consider using permit (EIP-2612) for gasless approvals
- Check return values of token transfers (or use SafeERC20)

## Contract Deployment

- Verify all constructor parameters are validated
- Set reasonable initial state and limits
- Consider using proxies (UUPS or Transparent) for upgradeability only when needed
- Verify contracts on block explorers after deployment

## Mandatory Checks Before Deployment

- [ ] All external/public functions have access control where needed
- [ ] Reentrancy guards on functions that transfer value
- [ ] No `tx.origin` for authentication
- [ ] Events emitted for all state changes
- [ ] No hardcoded addresses that should be configurable
- [ ] Slippage and deadline protection on swaps
- [ ] Emergency pause mechanism for high-value contracts
- [ ] All token interactions use SafeERC20
