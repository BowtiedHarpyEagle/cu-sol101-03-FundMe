// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUsd = 5;
    
    function fund() public payable {
        require(msg.value > minimumUsd, "didn't send enough");
    }

    function withdraw() public {}

    function getPrice() public {
        // Address 0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22
        // ABI 

    }

    function getConversionRate() public {}

    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22).version();
    }
}