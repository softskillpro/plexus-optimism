// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface IUniswapV2RouterLite {
    function getAmountsOut(
        uint256 amountIn, 
        address[] memory path
    )
        external
        view
        returns (uint256[] memory amounts);
}