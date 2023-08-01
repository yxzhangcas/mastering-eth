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

// truffle init
// > compile
// > migrate
// > Faucet.deployed().then(i => {FaucetDeployed = i})
// > FaucetDeployed.send(web3.utils.toWei("1", "ether")).then(res => {console.log(res.logs[0].event, res.logs[0].args)})
// > FaucetDeployed.withdraw(web3.utils.toWei("0.1", "ether")).then(res => {console.log(res.logs[0].event, res.logs[0].args)})