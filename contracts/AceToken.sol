pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './StarTokenInterface.sol';


contract AceToken is StarTokenInterface {
    using SafeMath for uint;
    using SafeMath for uint256;
    
    // ERC20 constants
    string public constant name = "ACE Token";
    string public constant symbol = "ACE";
    uint public constant decimals = 0;

    // Minting constants
    uint256 public constant MAXSOLD_SUPPLY = 99000000;
    uint256 public constant HARDCAPPED_SUPPLY = 165000000;
    
    bool public transferAllowed = false;
    mapping (address=>bool) public specialAllowed;

    event ToggleTransferAllowance(bool state);
    event ToggleTransferAllowanceFor(address indexed who, bool state);

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
        return specialAllowed[_for];
    }

    /**
    * @dev Function to mint tokens for investor
    * @param _to The address that will receive the minted tokens.
    * @param _amount The amount of tokens to emit.
    * @return A boolean that indicates if the operation was successful.
    */
    function mint(address _to, uint256 _amount) onlyOwner canMint returns (bool) {
        require(_amount > 0);
        
        // create 2 extra token for each 3 sold
        uint256 extra = _amount.div(3).mul(2);
        uint256 total = _amount.add(extra);

        totalSupply = totalSupply.add(total);

        // Prevent to emit more than handcap!
        assert(totalSupply <= HARDCAPPED_SUPPLY);
    
        balances[_to] = balances[_to].add(_amount);
        balances[owner] = balances[owner].add(extra);

        Mint(_to, _amount);
        Mint(owner, extra);

        Transfer(0x0, _to, _amount);
        Transfer(0x0, owner, extra);

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
