// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ITapTrust.sol";

/**
 * @dev Extension of {ERC20} that allows requiring a credential before a transfer
 */
contract ERC20RequireCredential is ERC20 {
    ITapTrust TapTrust;

    constructor(address TapTrustContract) {
        TapTrust = ITapTrust(TapTrustContract);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        TapTrust.requireCredential('kyc');
        return super.transfer(recipient, amount);
    }
}