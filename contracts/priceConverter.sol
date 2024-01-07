
// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
import "@chainlink/contracts/src/v0.7/interfaces/AggregatorV3Interface.sol";

library priceConverter {
    function getPrice() internal view returns (uint256){
            // ABI 
            // Address of contract  usd - 0x694AA1769357215DE4FAC081bf1f309aDC325306
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
            (,
      int256 price,
      ,
      ,
      )=priceFeed.latestRoundData();
            //Price of eth 

            return uint256(price * 1e10); 
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
            uint256 ethPrice = getPrice();
            uint256 ethToUsd = (ethPrice * ethAmount) / 1e18 ;
            return ethToUsd; 
    }
     
}
