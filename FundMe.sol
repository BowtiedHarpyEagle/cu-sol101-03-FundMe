// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUsd = 5;
    
    function fund() public payable {
        require(msg.value > minimumUsd, "didn't send enough");
    }

    function withdraw() public {}

    function getPrice() public view returns(uint256){
        // Address 0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);

    }

    function getConversionRate() public {}

    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22).version();
    }
}