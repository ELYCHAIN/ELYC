pragma solidity ^0.4.25;

import "./SafeMath.sol";
import "./ERC20Basic.sol";

contract BasicToken is ERC20Basic {
    
    using SafeMath for uint256;
    
    mapping (address => uint256) internal balances;
    
    /**
    * Returns the balance of the qeuried address
    *
    * @param _who The address which is being qeuried
    **/
    function balanceOf(address _who) public view returns(uint256) {
        return balances[_who];
    }
    
    /**
    * Allows for the transfer of MSTCOIN tokens from peer to peer. 
    *
    * @param _to The address of the receiver
    * @param _value The amount of tokens to send
    **/
    function transfer(address _to, uint256 _value) public returns(bool) {
        require(balances[msg.sender] >= _value && _value > 0 && _to != 0x0);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
