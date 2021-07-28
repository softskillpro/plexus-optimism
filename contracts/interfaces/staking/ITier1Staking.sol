// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface ITier1Staking {
    function deposit(
        string memory tier2ContractName,
        address tokenAddress,
        uint256 amount,
        address onBehalfOf
    ) external payable returns (bool);
    
    function withdraw(
        string memory tier2ContractName,
        address tokenAddress,
        uint256 amount,
        address onBehalfOf
    ) external payable returns (bool);
}
