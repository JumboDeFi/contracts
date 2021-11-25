// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.7.5;

import "./libraries/ERC20Permit.sol";
import "./libraries/Ownable.sol";
import "./libraries/VaultOwned.sol";

import "./interfaces/IJumboERC20.sol";

contract JumboERC20Token is ERC20Permit, IJumboERC20, VaultOwned {
  using SafeMath for uint256;

  uint256 public limitTime = 1637503200; // 22:00
  uint256 public openTime = 1637505000;  // 22:30

  mapping(address => bool) private _whitelists;

  constructor() ERC20("Jumbo", "JUB", 9) {}

  function _beforeTokenTransfer(address from_, address to_, uint256 amount_) internal override {
    if (block.timestamp < limitTime) {
      require(_whitelists[to_], "receiver not in whitelist");
    } else if (block.timestamp < openTime) {
      if (!_whitelists[to_]) {
        require(_whitelists[from_], "can not transfer before open-time");
        require(balanceOf(to_) + amount_ <= 20000000000, "receiver exceeded the maximum hold");
      }
    }
    super._beforeTokenTransfer(from_, to_, amount_);
  }

  function addWhite(address address_) external onlyManager {
    _whitelists[address_] = true;
  }

  function setLimitTime(uint256 limitTime_) external onlyManager {
    require(limitTime_ < openTime && limitTime_ < 1638288000, "invaid time");
    limitTime = limitTime_;
  }

  function setOpenTime(uint256 openTime_) external onlyManager {
    require(openTime_ > limitTime && openTime_ < 1638288000, "invaid time");
    openTime = openTime_;
  }

  function mint(address account_, uint256 amount_) external override onlyVault {
    _mint(account_, amount_);
  }

  function burn(uint256 amount) external override {
    _burn(msg.sender, amount);
  }

  function burnFrom(address account_, uint256 amount_) external override {
    _burnFrom(account_, amount_);
  }

  function _burnFrom(address account_, uint256 amount_) internal virtual {
    uint256 decreasedAllowance_ = allowance(account_, msg.sender).sub(amount_,"ERC20: burn amount exceeds allowance");
    _approve(account_, msg.sender, decreasedAllowance_);
    _burn(account_, amount_);
  }
}
