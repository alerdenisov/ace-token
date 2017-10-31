// ACE Token is a first token of Token Stars platform
// Copyright (c) 2017 TokenStars
// Made by Aler Denisov
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './StarTokenInterface.sol';

contract AceTokenDistribution is Ownable {
  using SafeMath for uint256;
  StarTokenInterface public token;

  event DistributionMint(address indexed to, uint256 amount);
  event ExtraMint();

  function AceTokenDistribution (address _tokenAddress) {
    require(_tokenAddress != 0);
    token = StarTokenInterface(_tokenAddress);
  }

  /**
  * @dev Minting required amount of tokens in a loop
  * @param _investors The array of addresses of investors
  * @param _amounts The array of token amounts corresponding to investors
  */
  function bulkMint(address[] _investors, uint256[] _amounts) onlyOwner public returns (bool) {
    // require(_investors.length < 50);
    require(_investors.length == _amounts.length);

    for (uint index = 0; index < _investors.length; index++) {
      assert(token.mint(_investors[index], _amounts[index]));
      DistributionMint(_investors[index], _amounts[index]);
    }
  }

  /**
  * @dev Minting extra (team and community) tokens
  */
  function extraMint() onlyOwner public returns (bool) {
    assert(token.extraMint());
    ExtraMint();
  }

  /**
  * @dev Return ownership to previous owner
  */
  function returnOwnership() onlyOwner public returns (bool) {
    token.transferOwnership(owner);
  }
}