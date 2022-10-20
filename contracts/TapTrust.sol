/**
 * SPDX-License-Identifier: MIT
 *
 * Copyright (c) 2022 TAPTRUST
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
pragma solidity ^0.8.0;

import "./ITapTrust.sol";
import "./ICredentialRequirementRegistry.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title A persistent ITapTrust implementation.
 */
contract TapTrust is ITapTrust, Ownable {

    address TapTrustAddress;

    function setTapTrustAddress(address tapTrustAddress) external override onlyOwner {
        TapTrustAddress = tapTrustAddress;
    }

    function requireCredential(string memory requirementId, address subjectAddress) public override view returns (bool) {
       bool isVerified = ICredentialRequirementRegistry(TapTrustAddress).isVerified(requirementId, subjectAddress);
       require(isVerified, "No verified credential found");
       return isVerified;
    }
    

}