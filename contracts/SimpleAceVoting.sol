pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './StarTokenInterface.sol';


contract SimpleAceVoting {
    using SafeMath for uint256;
    StarTokenInterface public baseToken;

    mapping(address => uint256) allowed;
    mapping(address => uint256) voted;

    modifier haveAllowed() {
      require(allowed[msg.sender] > 0);
      _;
    }

    function SimpleAceVoting(address token) {
        baseToken = StarTokenInterface(token);
    }

    function refreshAllowed() returns (bool) {
        uint allow = baseToken.allowance(msg.sender, this);
        require(baseToken.transferFrom(msg.sender, this, allow));
        allowed[msg.sender] = allow;
        return true;
    }

    function voteFor(address _pretedent, uint256 _amount) haveAllowed returns (bool) {
      require(allowed[msg.sender] >= _amount);

      voted[_pretedent] = voted[_pretedent].add(_amount);
      allowed[msg.sender] = allowed[msg.sender].sub(_amount);
      
      return true;
    }
}
