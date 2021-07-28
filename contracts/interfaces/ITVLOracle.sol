// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface ITVLOracle {
    function getTotalValueLockedInternalByToken(
        address tokenAddress,
        address tier2Address
    ) 
        external 
        view 
        returns (uint256);

    function getTotalValueLockedAggregated(uint256 optionIndex)
        external
        view
        returns (uint256);
}
