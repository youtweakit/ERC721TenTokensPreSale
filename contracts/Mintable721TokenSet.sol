pragma solidity ^0.4.19;
pragma experimental ABIEncoderV2;

import "./Pausable.sol";
import "./QuickSort.sol";
import "./MintingUtility.sol";
import "./ERC721Token.sol";
import "./SafeMath.sol";

contract Mintable721TokenSet is ERC721Token, MintingUtility {

    using SafeMath for uint256;

    event NewPreSaleAdded (address indexed ownerAddress, string nftSetName);
    event NewNftTokenAdded (string nftSetName, uint rna);


    struct NftPresale {

        string startupName;
        uint[10] tokenRna;
    } 

    NftPresale[] public preSaleSets;

    mapping (uint => address) public nftSetOwner;
    mapping (address => uint) public nftSetCounter;
    mapping (address => string) public nftSetNameOwner;
    mapping (string => uint[10]) public nftSetPerName;
    
    function createTokenSet(address Owner, string startupName, string[10] holdersName) public {
        for (uint i = 1; i < 10; i++) {
        uint rna = _generateRandomTokenId(holdersName[i]);
        preSaleSets.push(NftPresale(startupName, rna[i]);
        _createTokenSet(Owner, rna);
        emit NewNftTokenAdded(startupName, rna);
        }
        nftSetCounter[Owner]++;
        
        emit  NewPreSaleAdded(Owner, startupName);
    }
    function mint (

    address _beneficiary,
    uint64 _tokenIds

    )

    onlyMinter
    whenNotPaused
    public
{
        require(nftSetCounter[msg.sender] == 0);
        // This will assign ownership, and also emit the Transfer event
        _mint(_beneficiary, _tokenIds); 
    }

  /*
    @dev returns a unique id representing all the tokens
    @param _tokenIds the list of tokenIds in group
  */ 

/***** TRANSFERS *****/

  /*
    @dev Transfer multiple tokens at once
    @param _from - Who we are transferring tile from.
    @param _to - beneficiary of tile.
    @param _tokenIds - tokens to transfer.
    @param sender - approved for transfer of tiles
  */

    function transferFromMany(

    address _from,
    address _to, 
    uint64[] _tokenIds
) 
    whenNotPaused 
    public 
{
        for (uint i = 0; i < 10; i++) {
            require(isApprovedOrOwner(msg.sender, _tokenIds[i]));
            clearApproval(_from, _tokenIds[i]);
            transferFrom(_from, _to, _tokenIds[i]);
        }
    }

  /***** APPROVALS *****/

  /*
    @dev Approves a list of parcels for transfer
    @param sender - must be owner of tiles
    @param _tokenIds - tokens to approve.
  */
    function approveMany(

    address _to,
    uint64[] _tokenIds
) 
    whenNotPaused 
    public 
{
        for (uint i = 0; i <= _tokenIds.length; i++) {
            approve(_to, _tokenIds[i]);
        }
    }
  /*
    @dev Check if an owner owns all tokens
    @param _owner - possible owner of tiles
    @param _tokenIds - tokens to check ownership.
  */

    function ownsTokens(

    address _owner, 
    uint64[10] _tokenIds
) 
    public 
    constant 
    returns (bool) 
{
        for (uint i = 0; i <= _tokenIds.length; i++) {
            if (ownerOf(_tokenIds[i]) != _owner) {
                return false;
            }
        }
        return true;
    }

    /* 
    @dev creates a set of 10 unique NFT tokens, mapps them by startup name and rnas
    @dev awakes NewPreSaleNft event for frontend 
    */
    function _createTokenSet(address _startupOwner, uint rna) internal {

        onlyOwner;
        
            _mint(_startupOwner, rna);
            
    }

    /* 
    @dev generates a unique identifier for each token in a set from provided NFT token holder's names
    */
    function _generateRandomTokenId (string _holderName) private pure returns(uint) { 

        return uint256(keccak256(_holderName));
    }
}
