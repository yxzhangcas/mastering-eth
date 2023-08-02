// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract METoken is ERC20 {

    string public constant NAME = "Mastering Ethereum Token";
    string public constant SYMBOL = "MET";

    uint8 public  constant DECIMALS = 2;
    uint constant INITIAL_SUPPLY = 2100000000;

    constructor() ERC20(NAME, SYMBOL) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function decimals() public view virtual override returns (uint8) {
        return DECIMALS;
    }
}

// npm init
// npm install @openzeppelin/contracts

// truffle compile
// truffle migrate --network ganache

// truffle console --network ganache
// truffle(ganache)> METoken
// truffle(ganache)> METoken.address
// '0xA52151C48e5256533b4253520Dd67fA9E6fDEb32'
// truffle(ganache)> METoken.deployed().then(i => i.totalSupply())