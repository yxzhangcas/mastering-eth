// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract CalledContract {
    event CallEvent(address sender, address origin, address from);

    function calledFunction() public {
        emit CallEvent(msg.sender, tx.origin, address(this));
    }
}

library CalledLibrary {
    event CallEvent(address sender, address origin, address from);

    function calledFunction() public {
        emit CallEvent(msg.sender, tx.origin, address(this));
    }
}

contract Caller {

    function makeCalls(address _calledContract) public {
        CalledContract(_calledContract).calledFunction();
        CalledLibrary.calledFunction();

        (bool success1,) = address(_calledContract).call(abi.encodeWithSelector(bytes4(keccak256("calledFunction()"))));
        require(success1);
        
        (bool success2,) = address(_calledContract).delegatecall(abi.encodeWithSelector(bytes4(keccak256("calledFunction()"))));
        require(success2);


    }
}