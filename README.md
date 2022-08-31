# taptrust-sdk-solidity

This package contains an interface to require credentials from a Solidity contract.

Refer to the [taptrust-contracts](https://github.com/taptrust/taptrust-contracts) repository for the implementation of the TapTrust registries used for credential verification.

## Installation

```bash
npm install @taptrust/taptrust-sdk-solidity
```

## Example Usage

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@taptrust/taptrust-sdk-solidity/ITapTrust.sol";

contract ExampleContract is ERC20 {
    ITapTrust TapTrust;


    constructor(address TapTrustContract) {
        TapTrust = ITapTrust(TapTrustContract);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        TapTrust.requireCredential('kyc');
        return super.transfer(recipient, amount);
    }
}
```
