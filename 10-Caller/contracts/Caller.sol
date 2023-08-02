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

// truffle(develop)> Caller.address
// '0x33a8764878a68292B05C085d2306c76E9A3f51dC'
// truffle(develop)> CalledContract.address
// '0x9AF458Deb1D903612489eaf5E6A6823459cB16Bb'
// truffle(develop)> CalledLibrary.address
// '0xe8c5a5e79aAad25Fc61c8084B93608adE47D10b2'
// truffle(develop)> Caller.deployed().then(i => {callerDeployed = i})
// truffle(develop)> callerDeployed.makeCalls(CalledContract.address).then(res => {res.logs.forEach(log => {console.log(log.args)})})
// Result {
//   '0': '0x33a8764878a68292B05C085d2306c76E9A3f51dC',
//   '1': '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   '2': '0x9AF458Deb1D903612489eaf5E6A6823459cB16Bb',
//   __length__: 3,
//   sender: '0x33a8764878a68292B05C085d2306c76E9A3f51dC',
//   origin: '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   from: '0x9AF458Deb1D903612489eaf5E6A6823459cB16Bb'
// }
// Result {
//   '0': '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   '1': '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   '2': '0x33a8764878a68292B05C085d2306c76E9A3f51dC',
//   __length__: 3,
//   sender: '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   origin: '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   from: '0x33a8764878a68292B05C085d2306c76E9A3f51dC'
// }
// Result {
//   '0': '0x33a8764878a68292B05C085d2306c76E9A3f51dC',
//   '1': '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   '2': '0x9AF458Deb1D903612489eaf5E6A6823459cB16Bb',
//   __length__: 3,
//   sender: '0x33a8764878a68292B05C085d2306c76E9A3f51dC',
//   origin: '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   from: '0x9AF458Deb1D903612489eaf5E6A6823459cB16Bb'
// }
// Result {
//   '0': '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   '1': '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   '2': '0x33a8764878a68292B05C085d2306c76E9A3f51dC',
//   __length__: 3,
//   sender: '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   origin: '0xE11C32927DB132389f3eF8CfD221A976C85B9388',
//   from: '0x33a8764878a68292B05C085d2306c76E9A3f51dC'
// }