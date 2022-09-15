// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./TapTrust.sol";

/**
 * @dev Extension of {ERC20} that allows requiring a credential before a transfer
 */
contract ERC20RequireCredential is TapTrust, ERC20 {

    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the caller must have the credential required by the token.
     */
    function transfer(address recipient, uint256 amount) public virtual returns (bool) {
        TapTrust.requireCredential('kyc');
        return super.transfer(recipient, amount);
    }
}