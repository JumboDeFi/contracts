// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.7.5;

interface IUniswapV2Pair {
    function initialize(address, address) external;
    function totalSupply() external view returns (uint);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function token0() external view returns ( address );
    function token1() external view returns ( address );
}