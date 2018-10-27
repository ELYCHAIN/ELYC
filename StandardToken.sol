pragma solidity ^0.4.25;

import "./ERC20.sol";
import "./BasicToken.sol";
import "./Ownable.sol";

contract StandardToken is BasicToken, ERC20, Ownable {
    
    address public MembershipContractAddr = 0x0;
    
    mapping (address => mapping (address => uint256)) internal allowances;
    
    function changeMembershipContractAddr(address _newAddr) public onlyOwner returns(bool) {
        require(_newAddr != address(0));
        MembershipContractAddr = _newAddr;
    }
    
    /**
    * Returns the amount of tokens one has allowed another to spend on his or her behalf.
    *
    * @param _owner The address which is the owner of the tokens
    * @param _spender The address which has been allowed to spend tokens on the owner's
    * behalf
    **/
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowances[_owner][_spender];
    }
    
    event TransferFrom(address msgSender);
    /**
    * Allows for the transfer of tokens on the behalf of the owner given that the owner has
    * allowed it previously. 
    *
    * @param _from The address of the owner
    * @param _to The address of the recipient 
    * @param _value The amount of tokens to be sent
    **/
    function transferFrom(address _from, address _to, uint256 _value) public  returns (bool) {
        require(allowances[_from][msg.sender] >= _value || msg.sender == MembershipContractAddr);
        require(balances[_from] >= _value && _value > 0 && _to != address(0));
        emit TransferFrom(msg.sender);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        if(msg.sender != MembershipContractAddr) {
            allowances[_from][msg.sender] = allowances[_from][msg.sender].sub(_value);
        }
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    /**
    * Allows the owner of tokens to approve another to spend tokens on his or her behalf
    *
    * @param _spender The address which is being allowed to spend tokens on the owner' behalf
    * @param _value The amount of tokens to be sent
    **/
    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != 0x0 && _value > 0);
        if(allowances[msg.sender][_spender] > 0 ) {
            allowances[msg.sender][_spender] = 0;
        }
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
