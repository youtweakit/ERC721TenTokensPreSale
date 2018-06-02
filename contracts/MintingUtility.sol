pragma solidity ^0.4.18;
import "./Pausable.sol";

contract MintingUtility is Pausable {
    uint8 public _tokenBatchSize = 10;

    function isMinter()
        public
        pure
        returns (bool)
    {
        return false;
    }

    /* 
        Only minter contracts can access via this modifier
        Minter contracts return true for isMinter.
        Also, a minter either owns this contract or is owned by 
        the same contract as this
    */
    modifier onlyMinter()
    {
        MintingUtility minter = MintingUtility(msg.sender);
        // Either the minter contract is this owner
        // OR the minter's owner is this owner
        require(minter == owner || minter.owner() == owner);
        require(minter.isMinter() == true);
        _;
    }
}
