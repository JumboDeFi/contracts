// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.7.5;

interface IStakedJumboERC20 {
  function rebase( uint256 profit_, uint epoch_) external returns (uint256);

  function circulatingSupply() external view returns (uint256);

  function balanceOf(address who) external view returns (uint256);

  function gonsForBalance( uint amount ) external view returns ( uint );

  function balanceForGons( uint gons ) external view returns ( uint );

  function index() external view returns ( uint );
}