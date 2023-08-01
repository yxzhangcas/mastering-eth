// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "06-Faucet.sol";

contract Token is Mortal {
    constructor(address _faucet) {
        (bool success,) = _faucet.call(abi.encodeWithSignature("withdraw(uint256)", 0.1 ether));
    }
}