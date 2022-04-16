// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Multi_Transact {

    uint256 public addressCount;
    address[] public addresses; 

    event Transaction (
        address from,
        address to,
        uint256 amount
    );

    event Multi_Transaction (
        address sender,
        address[] receivers
    );

    function singleTransfer (address _addr) public payable {
        (bool sent, bytes memory data) = payable(_addr).call{value: msg.value}("");
        emit Transaction(msg.sender, _addr, msg.value);
    }

    function addAddress(address _addr) public {
        addresses.push(_addr);
    }

    function multi_Transfer() public payable{

        for(uint256 i=0; i < addresses.length; i++) {
            address payable addr = payable(addresses[i]);
            (bool sent, bytes memory data) = addr.call{value:msg.value / addresses.length}("");
            require(sent, "Failed to send Ether");
        }
        emit Multi_Transaction(msg.sender, addresses);
    }

}
