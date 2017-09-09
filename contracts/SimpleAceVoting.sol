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
        require(_pretendent != 0x0);
        require(aceToken.allowance(msg.sender, this) >= _amount);
        require(aceToken.transferFrom(msg.sender, this, _amount));

        voted[_pretendent] = voted[_pretendent].add(_amount);
    }
}
