// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.7.5;

interface IBondDepository {

    function deposit(uint256 _amount, uint256 _maxPrice, address _depositor) external returns (uint256);

    function isLiquidityBond() external view returns (bool);
    function principle() external view returns (address);
}