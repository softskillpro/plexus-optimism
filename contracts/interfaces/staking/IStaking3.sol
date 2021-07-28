// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface IStaking3 {
    function exit() external;
    function stake(uint256 amount) external;
    function balanceOf(address who) external view returns (uint256);
}