// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Faucet {

    address public owner;

    modifier onlyOwner {
        require(msg.sender == owner, "not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function withdraw(uint amount) public {
        require(amount <= 1000000000000000000);
        payable(msg.sender).transfer(amount);
    }

    function destroy() public onlyOwner {
        selfdestruct(payable(owner));
    }

    fallback() external payable {}
    receive() external payable {}
}