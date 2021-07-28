// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface IUniswapFactory {
    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);
}
