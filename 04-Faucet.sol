// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Owned {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner, "not owner");
        _;
    }
}

contract Mortal is Owned {
    function destroy() public onlyOwner {
        selfdestruct(payable(owner));
    }
}


contract Faucet is Mortal {

    function withdraw(uint amount) public {
        require(amount <= 1 ether);
        payable(msg.sender).transfer(amount);
    }

    fallback() external payable {}
    receive() external payable {}
}