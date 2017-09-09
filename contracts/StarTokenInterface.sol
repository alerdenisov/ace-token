pragma solidity ^0.4.11;


contract StarTokenInterface {
    function transferOwnership(address newOwner);

    function allowance(address owner, address spender) constant returns (uint256);
    function transfer(address _to, uint256 _value) returns (bool);
    function transferFrom(address from, address to, uint256 value) returns (bool);
    function approve(address spender, uint256 value) returns (bool);
    function increaseApproval (address _spender, uint _addedValue) returns (bool success);
    function decreaseApproval (address _spender, uint _subtractedValue) returns (bool success);

    function toggleTransfer() returns (bool);
    function toggleTransferFor(address _for) returns (bool);
    
    function mintFor(address _to, uint256 _amount) returns (bool);
    function finishMinting() returns (bool);

    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 amount);
    event MintFinished();
    event ToggleTransferAllowance(bool state);
    event ToggleTransferAllowanceFor(address indexed who, bool state);


}
