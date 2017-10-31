// ACE Token is a first token of TokenStars platform
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

pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';


contract StarTokenInterface is MintableToken {
    // Cheatsheet of inherit methods and events
    // function transferOwnership(address newOwner);
    // function allowance(address owner, address spender) constant returns (uint256);
    // function transfer(address _to, uint256 _value) returns (bool);
    // function transferFrom(address from, address to, uint256 value) returns (bool);
    // function approve(address spender, uint256 value) returns (bool);
    // function increaseApproval (address _spender, uint _addedValue) returns (bool success);
    // function decreaseApproval (address _spender, uint _subtractedValue) returns (bool success);
    // function finishMinting() returns (bool);
    // function mint(address _to, uint256 _amount) returns (bool);
    // event Approval(address indexed owner, address indexed spender, uint256 value);
    // event Mint(address indexed to, uint256 amount);
    // event MintFinished();

    // Custom methods and events
    function toggleTransfer() returns (bool);
    function toggleTransferFor(address _for) returns (bool);
    function extraMint() returns (bool);
    function currentOwner() constant public returns (address);

    event ToggleTransferAllowance(bool state);
    event ToggleTransferAllowanceFor(address indexed who, bool state);


}
