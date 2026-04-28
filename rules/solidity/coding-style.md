---
paths:
  - "**/*.sol"
---
# Solidity Coding Style

> Conventions for Solidity smart contract development.

## Version and License

Every file starts with SPDX license identifier and pragma:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
```

Pin the pragma to a specific minor version range for production contracts.

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Contract, Interface, Library | PascalCase | `TokenFactory`, `IVault` |
| Interface | `I` prefix | `ITokenFactory` |
| Function | camelCase | `calculateFee()` |
| Constant | UPPER_SNAKE_CASE | `MAX_SUPPLY` |
| Immutable variable | `i_` prefix | `i_owner` |
| Storage variable | `s_` prefix | `s_balances` |
| Function parameter | camelCase | `tokenAmount` |
| Event | PascalCase | `TokensMinted` |
| Error | PascalCase | `InsufficientBalance` |

## NatSpec Documentation

Document all public and external functions:

```solidity
/// @notice Transfers tokens from sender to recipient
/// @param to The recipient address
/// @param amount The number of tokens to transfer
/// @return success Whether the transfer succeeded
function transfer(address to, uint256 amount) external returns (bool success) {
```

## Function Ordering

1. constructor
2. receive / fallback
3. external functions
4. public functions
5. internal functions
6. private functions

Within each group: state-changing first, then view, then pure.

## Checks-Effects-Interactions Pattern

Always follow this order in state-changing functions:

1. **Checks** — validate inputs and conditions (require/revert)
2. **Effects** — update contract state
3. **Interactions** — external calls last

```solidity
function withdraw(uint256 amount) external {
    // Checks
    if (s_balances[msg.sender] < amount) revert InsufficientBalance();

    // Effects
    s_balances[msg.sender] -= amount;

    // Interactions
    (bool success, ) = msg.sender.call{value: amount}("");
    if (!success) revert TransferFailed();
}
```

## Gas Optimization Basics

- Use `error` over `require` with string messages (cheaper)
- Cache storage reads in memory when accessed multiple times
- Use `unchecked` blocks for arithmetic that cannot overflow
- Prefer `uint256` over smaller uint types (EVM operates on 256-bit words)
- Use `calldata` instead of `memory` for read-only function parameters
