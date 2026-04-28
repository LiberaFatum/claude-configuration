---
paths:
  - "**/*.sol"
  - "**/*.t.sol"
---
# Solidity Testing Rules

> Testing patterns for smart contracts using Foundry (preferred) or Hardhat.

## Test Structure (Foundry)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {TokenFactory} from "../src/TokenFactory.sol";

contract TokenFactoryTest is Test {
    TokenFactory factory;
    address user = makeAddr("user");

    function setUp() public {
        factory = new TokenFactory();
        vm.deal(user, 10 ether);
    }

    function test_CreateToken_Success() public {
        vm.prank(user);
        address token = factory.createToken("Test", "TST", 1000e18);
        assertNotEq(token, address(0));
    }

    function test_CreateToken_RevertWhen_ZeroSupply() public {
        vm.prank(user);
        vm.expectRevert(TokenFactory.ZeroSupply.selector);
        factory.createToken("Test", "TST", 0);
    }
}
```

## Naming Convention

- Test files: `ContractName.t.sol`
- Test contracts: `ContractNameTest`
- Test functions: `test_FunctionName_Scenario()` for success, `test_FunctionName_RevertWhen_Condition()` for failures

## Fuzz Testing

Use Foundry's built-in fuzzer for property-based tests:

```solidity
function testFuzz_Deposit_UpdatesBalance(uint256 amount) public {
    amount = bound(amount, 1, 100 ether);
    vm.deal(user, amount);
    vm.prank(user);
    vault.deposit{value: amount}();
    assertEq(vault.balanceOf(user), amount);
}
```

## Fork Testing

Test against real mainnet state for DeFi integrations:

```bash
forge test --fork-url $RPC_URL --match-contract ForkTest
```

## Coverage

```bash
forge coverage
forge coverage --report lcov
```

Target: 90%+ for smart contracts (higher than standard 80% because bugs cost real money).

## What to Test

- **Happy path**: Normal operation
- **Access control**: Unauthorized callers get reverted
- **Edge cases**: Zero amounts, max uint256, empty arrays
- **Reentrancy**: Attempt reentrant calls
- **State transitions**: Verify storage changes correctly
- **Events**: Verify correct events are emitted
- **Integration**: Test with real token contracts via fork testing
