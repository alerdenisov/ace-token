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
    event ToggleTransferAllowance(bool state);
    event ToggleTransferAllowanceFor(address indexed who, bool state);


}
