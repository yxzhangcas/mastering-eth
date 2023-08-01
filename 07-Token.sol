// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "06-Faucet.sol";

contract Token is Mortal {
    Faucet _faucet;

    constructor(address payable _f) payable {
        _faucet = Faucet(_f);
        _f.transfer(msg.value);
    }
}