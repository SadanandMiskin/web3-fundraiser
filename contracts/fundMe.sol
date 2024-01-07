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

    address public owner; //owner of the contract

    constructor() {
        owner = msg.sender ; 
    }

    function fund() public payable {
        // want able to set a minimun fund in usd , 'payable' for using as wallets
        // 1. how to send eth to contract
        // money math is done is 'Wei' so , need to convert to 'wei' hence it will b3 1e18 value
        //1e18 === 1 * 10 ** 18 === 1000000000000000000

        
        require(msg.value.getConversionRate() >= 1e10 , "Require atleast 1 ether"); // if the value sent is less than the require value then the message will be popped
        funders.push(msg.sender);
        adrresVsAmount[msg.sender] += msg.value; 

        
        if(address(this).balance >= 1e15) {
            transfer();
        }
        
       
    
    }

    function withdraw() external onlyOwner  {

        require(msg.sender == owner ,"Not Allowed") ;
        // only is the msg.sender is owner then only the below lines can be accessed

        for(uint256 i =0 ; i<funders.length ; i++) {
           address fundersWithdraw =  funders[i] ; 
           adrresVsAmount[fundersWithdraw] = 0;
        }
         funders = new address [](0) ;  // funders addresses to'0' 

     //sending ETH back to the funders 
    // transfer , call , send

        //transfer -> throws error if there is error for transferring
        // payable(msg.sender).transfer(address(this).balance) ; 

        //send -> returns bool , if there exists any error then we can use require() to resend the value
    //    bool sentStatus =  payable(msg.sender).send(address(this).balance) ; // resending back, if failed that string is printed and again the require() will run 
    //     require(sentStatus , "Failed") ; 

        //call ->more powerfull,  forwards all gas , 
      (bool status , ) = payable(msg.sender).call{value: address(this).balance}("") ; // {bool status ,byte dataReturned} -> whatever the function is called (""), if the data is returned then it is stored in 'dataReturned'
        require(status , "Failed") ;
    }
    
    function balance() public view returns(uint256) {
        return address(this).balance ;
    }

    
    function transfer() public  {
        address payable  reciever = `Reciever-address` ;
        bool success = reciever.send(address(this).balance) ;
        require(success , "Failed") ;
    }
    
   //modifiers --> just like 'Middlewares' in expressJS
   modifier onlyOwner {
    require(msg.sender == owner , "Not Allowed");
    _; // represents the rest of the code of the function withdraw() , if it was reverse then the lines of withdraw() is exected and then require() is executed
   }


    
}
