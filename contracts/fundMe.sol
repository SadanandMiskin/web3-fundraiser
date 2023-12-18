//get funds from users
// withdraw funds 
// set a minimun funding value 

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "contracts/priceConverter.sol";
contract fundMe {
    using priceConverter for uint256 ;
    // uint256 public minimumUsd = 50;

    address[] public funders ;
    mapping(address => uint256) public  adrresVsAmount; 
    function fund() public payable {
        // want able to set a minimun fund in usd , 'payable' for using as wallets
        // 1. how to send eth to contract
        // money math is done is 'Wei' so , need to convert to 'wei' hence it will b3 1e18 value
        //1e18 === 1 * 10 ** 18 === 1000000000000000000

        
        require(msg.value.getConversionRate() >= 1e10 , "Require atleast 1 ether"); // if the value sent is less than the require value then the message will be popped
        funders.push(msg.sender);
        adrresVsAmount[msg.sender] = msg.value; 
    
    }

    
     
    // function withdraw() {

    // }
}