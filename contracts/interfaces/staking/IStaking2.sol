// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;
pragma abicoder v2;

interface IStaking2 {
    function approve(address spender, uint256 amount) external returns (bool);
    function deposit(uint256 _amount) external;
    function depositAll() external;
    function stake(uint256 _amount) external;
    function withdraw(uint256 _shares) external;
    function withdrawAll() external;
    function balanceOf(address account) external view returns (uint256);
}