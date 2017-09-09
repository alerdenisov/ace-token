pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './StarTokenInterface.sol';


contract SimpleAceVoting {
    using SafeMath for uint256;

    address public tokenAddress;
    mapping(address => uint256) voted;

    function SimpleAceVoting(address token) {
        tokenAddress = token;
    }

    function voteFor(address _pretendent, uint256 _amount) returns (bool) {
        StarTokenInterface aceToken = StarTokenInterface(tokenAddress);
        uint256 allowed = aceToken.allowance(msg.sender, address(this));
        // require(allowed >= _amount);

        // aceToken.transferFrom(msg.sender, _pretendent, _amount);
        // voted[_pretendent] = voted[_pretendent].add(_amount);
    }
}
