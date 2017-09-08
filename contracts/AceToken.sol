pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import './StarTokenInterface.sol';


contract AceToken is StarTokenInterface, StandardToken, Ownable {
    string public name = "ACE Token";
    string public symbol = "ACE";
    uint public decimals = 0;

    uint256 public MAXSOLD_SUPPLY = 99000000;
    uint256 public HARDCAPPED_SUPPLY = 165000000;
    
    bool public transferAllowed = false;
    mapping (address=>bool) public specialAllowed;

    bool public emitFinished = false;

    event Emit(address indexed to, uint256 amount);
    event EmitFinished();
    event ToggleTransferAllowance(bool state);
    event ToggleTransferAllowanceFor(address indexed who, bool state);


    modifier canEmit() {
        require(!emitFinished);
        _;
    }

    modifier allowTransfer() {
        require(transferAllowed || specialAllowed[msg.sender]);
        _;
    }

    /**
    * @dev transfer token for a specified address if transfer is open
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */
    function transfer(address _to, uint256 _value) allowTransfer returns (bool) {
        return super.transfer(_to, _value);
    }

    
    /**
    * @dev Transfer tokens from one address to another if transfer is open
    * @param _from address The address which you want to send tokens from
    * @param _to address The address which you want to transfer to
    * @param _value uint256 the amount of tokens to be transferred
     */
    function transferFrom(address _from, address _to, uint256 _value) allowTransfer returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    /**
    * @dev Change current state of transfer allowence to opposite
     */
    function toggleTransfer() onlyOwner returns (bool) {
        transferAllowed = !transferAllowed;
        ToggleTransferAllowance(transferAllowed);
        return transferAllowed;
    }

    /**
    * @dev allow transfer for the given address against global rules
    * @param _for addres The address of special allowed transfer (required for smart contracts)
     */
    function toggleTransferFor(address _for) onlyOwner returns (bool) {
        specialAllowed[_for] = !specialAllowed[_for];
        ToggleTransferAllowanceFor(_for, specialAllowed[_for]);
        return true;
    }

    /**
    * @dev Function to emit tokens for investor
    * @param _to The address that will receive the emited tokens.
    * @param _amount The amount of tokens to emit.
    * @return A boolean that indicates if the operation was successful.
    */
    function emitFor(address _to, uint256 _amount) onlyOwner canEmit returns (bool) {
        // create 2 extra token for each 3 sold
        uint256 extra = _amount.div(3).mul(2);
        uint256 total = _amount.add(extra);

        // Prevent to emit more than handcap!
        assert(totalSupply.add(total) <= HARDCAPPED_SUPPLY);

        totalSupply = totalSupply.add(total);
        balances[_to] = balances[_to].add(_amount);
        balances[owner] = balances[owner].add(extra);

        Emit(_to, _amount);
        Emit(owner, extra);

        Transfer(0x0, _to, _amount);
        Transfer(0x0, owner, extra);

        return true;
    }

    /**
    * @dev Function to stop Emiting new tokens.
    * @return True if the operation was successful.
    */
    function finishEmiting() onlyOwner returns (bool) {
        emitFinished = true;
        EmitFinished();
        return true;
    }


    function increaseApproval (address _spender, uint _addedValue) returns (bool success) {
        allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    function decreaseApproval (address _spender, uint _subtractedValue) returns (bool success) {
        uint oldValue = allowed[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
            allowed[msg.sender][_spender] = 0;
        } else {
            allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }
}
