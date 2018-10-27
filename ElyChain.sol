pragma solidity ^0.4.25;

import "./MintableToken.sol";

contract ElyChain is MintableToken {
    
    constructor() public {
        name = "ElyChain";
        symbol = "ELYC";
        decimals = 18;
        totalSupply = 500000000e18;
        balances[owner] = totalSupply;
        emit Transfer(address(this), owner, totalSupply);
    }
}
