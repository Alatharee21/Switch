// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Switch {
    address public receiver;
    address owner;
    uint256 theTime;

    constructor(address _receiver) payable {
        receiver = _receiver;
        owner = msg.sender;
        theTime = block.timestamp;
    }

    function withdraw() external {
        require((block.timestamp - theTime) > 52 weeks);
        uint256 contBalance = address(this).balance;
        (bool s, ) = receiver.call{value: contBalance}("");
        require(s);
    }

    function ping() external {
        require(owner == msg.sender);
        theTime = block.timestamp;
    }
}
