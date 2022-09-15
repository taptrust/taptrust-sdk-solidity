// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./TapTrust.sol";

/**
 * @dev Extension of {ERC721} that allows requiring a credential before a mint or transfer
 */
contract ERC721RequireCredential is TapTrust, ERC721 {

    function _transfer(address from, address to, uint256 tokenId) internal virtual override {
        TapTrust.requireCredential('kyc');
        return super._transfer(from, to, tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        TapTrust.requireCredential('kyc');
        return super._mint(to, tokenId);
    }
}