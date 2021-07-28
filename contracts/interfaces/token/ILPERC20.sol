// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface ILPERC20 {
    function token0() external view returns (address);
    function token1() external view returns (address);
}