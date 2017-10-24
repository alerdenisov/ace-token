pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './StarTokenInterface.sol';

contract AceTokenDistribution is Ownable {
  using SafeMath for uint256;
  StarTokenInterface public token;
  address public futureOwner;

  function AceTokenDistribution (address _tokenAddress, address _futureOwner) {
    require(_tokenAddress != 0);
    token = StarTokenInterface(_tokenAddress);

    if(_futureOwner != 0) {
      futureOwner = _futureOwner;
    } else {
      futureOwner = token.currentOwner();
    }
  }

  function bulkMint(address[] _investors, uint256[] _amounts) onlyOwner public returns (bool) {
    require(_investors.length < 50);
    require(_investors.length == _amounts.length);

    for (uint index = 0; index < _investors.length; index++) {
      assert(token.mint(_investors[index], _amounts[index]));
    }
  }

  function extraMint() onlyOwner public returns (bool) {
    assert(token.extraMint());
  }

  function returnOwnership() onlyOwner public returns (bool) {
    token.transferOwnership(owner);
  }
}