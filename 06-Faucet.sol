// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Owned {
    address public owner;
    constructor() payable {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner, "not owner");
        _;
    }
}

contract Mortal is Owned {
    function destroy() public virtual onlyOwner {
        selfdestruct(payable(owner));
    }
}

contract Faucet is Mortal {

    constructor() payable {}

    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    function withdraw(uint amount) public {
        require(amount <= 1 ether);
        require(address(this).balance >= amount, "insufficient balance");
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    fallback() external payable {
        emit Deposit(msg.sender, msg.value);
    }
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}