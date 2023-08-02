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