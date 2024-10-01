// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

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