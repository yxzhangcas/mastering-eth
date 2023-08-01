// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "06-Faucet.sol";

contract Token is Mortal {
    Faucet public _faucet;

    constructor() payable {
        _faucet = new Faucet{value: msg.value}();
    }

    function destroy() public override onlyOwner {
        _faucet.destroy();
        selfdestruct(payable(msg.sender));
    }
}