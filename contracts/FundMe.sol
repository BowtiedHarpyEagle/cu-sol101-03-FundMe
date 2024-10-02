// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() internal view returns(uint256){
        // Sepolia Address 0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22
        // ZKsync sepolia 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);

    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return(ethAmountInUsd);
    }

    function getVersion() internal view returns(uint256) {
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
}

error NotOwner();

contract FundMe{
    using PriceConverter for uint256;
    
    uint256 public constant MINIMUM_USD = 5e18;
    
    address[] public funders;
    mapping(address funder => uint256 amountFunded) addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }
    
    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner(){
        //require(msg.sender == i_owner, "not owner");
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable { 
        fund();
    }



   
}