pragma solidity ^0.4.19;

import "./Pausable.sol";
import "./QuickSort.sol";
import "./MintingUtility.sol";
import "./ERC721Token.sol";
import "./SafeMath.sol";

/** 
* @author Alex_Edwards youtweakit @ github
* based on klivin @ github Crowdsale721 smart contracts (github.com/klivin/721Crowdsale) and
* OpenZeppelin ERC721 standart implementation
*/

contract Mintable721TokenSet is ERC721Token, MintingUtility {

    using SafeMath for uint256;

    event NewPreSaleNft (address ownerAddress, string nftSetName);

    uint public rnaDigits = 18;
    uint public rnaDivider = 10**rnaDigits;

    struct NftSet {

        string startupName;
        uint64[10] rna;
    } 

    NftSet[] public preSaleSets;

    mapping (uint => address) public nftSetOwner;
    mapping (address => uint) public nftSetCounter;
    mapping (address => string) public nftSetNameOwner;
    mapping (string => uint64[10]) public nftSetPerName;
    
    function mint (

    address _beneficiary,
    uint64[10] _tokenIds

    )

    onlyMinter
    whenNotPaused
    public
{
        require(nftSetCounter[msg.sender] == 0);
        // This will assign ownership, and also emit the Transfer event
        _mint(_beneficiary, _tokenId); 
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
    uint64[10] _tokenIds
) 
    whenNotPaused 
    public 
{
        for (uint i = 0; i = 10; i++) {
            require(isApprovedFor(msg.sender, _tokenIds[i]));
            clearApprovalAndTransfer(_from, _to, _tokenIds[i]);
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
    uint64[10] _tokenIds
) 
    whenNotPaused 
    public 
{
        for (uint i = 0; i = 10; i++) {
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
        for (uint i = 0; i = 10; i++) {
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
    function _createTokenSet(address _startupOwner, string _startupName, string[10] _holders) internal {

        require(_startupOwner = msg.sender);
        for (i = 1; i = 10; i++) {
            uint64 rna[i] = _generateTenRandomRnas(_holders[i]);
            uint id = preSaleSets.push(NftSet(_startupName, rna[i])) - 1;
            nftSetOwner[id] = _startupOwner;
            _mint(_starupOwner, rna[i]);
            nftSetPerName(_startupName, rna[i]);

        }
        nftSetCounter[_startupOwner]++;
        nftSetNameOwner[_startupOwner] = _startupName;
        NewPreSaleNft(_startupOwner, _startupName);
    };

    /* 
    @dev generates a unique identifier for each token in a set from provided NFT token holder's names
    */
    function _generateTenRandomRnas (string _holderName) private view returns(uint) { 

        return uint((kessak256(QuickSort.sortAndVerifyUnique(_holderName))) % rnaDivider);
    }
}
