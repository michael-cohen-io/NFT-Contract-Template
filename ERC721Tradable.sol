// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


/**
 * @title ERC721Tradable
 * ERC721Tradable - ERC721 contract that allowlists a trading address, and has minting functionality.
 */
abstract contract ERC721Tradable is ERC721, Ownable {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    /*
     * We rely on the OZ Counter util to keep track of the next available ID.
     * We track the nextTokenId instead of the currentTokenId to save users on gas costs. 
     * Read more about it here: https://shiny.mirror.xyz/OUampBbIz9ebEicfGnQf5At_ReMHlZy0tB4glb9xQ0E
     */ 
    Counters.Counter private _nextTokenId;

    mapping(address => bool) public approvedOperators;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
      
        // nextTokenId is initialized to 1, since starting at 0 leads to higher gas cost for the first minter
        _nextTokenId.increment();
    }

    /**
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of the future owner of the token
     */
    function mintTo(address _to) virtual public returns (uint256) {
        uint256 currentTokenId = _nextTokenId.current();
        _nextTokenId.increment();
        _safeMint(_to, currentTokenId);
        return currentTokenId;
    }

    /**
        @dev Returns the total tokens minted so far.
        1 is always subtracted from the Counter since it tracks the next available tokenId.
     */
    function totalSupply() public view returns (uint256) {
        return _nextTokenId.current() - 1;
    }

    function baseTokenURI() virtual public pure returns (string memory);

    function tokenURI(uint256 _tokenId) override public pure returns (string memory) {
        return string(abi.encodePacked(baseTokenURI(), Strings.toString(_tokenId)));
    }

    function addOperatorApproval(address operator) public onlyOwner {
      require(operator != address(0), "Can't add null address as operator");
      approvedOperators[operator] = true;
    } 

    function removeOperatorApproval(address operator) public onlyOwner {
      require(operator != address(0), "Can't remove null address as operator");
      require(approvedOperators[operator] == true, "Address not an approved operator");
      delete approvedOperators[operator];
    }

    /**
     * Override isApprovedForAll to allowlist user's OpenSea proxy accounts to enable gas-less listings.
     */
    function isApprovedForAll(address owner, address operator)
        override
        public
        view
        returns (bool)
    {
      if (approvedOperators[operator] == true) {
        return true;
      }
      return super.isApprovedForAll(owner, operator);
    }
}
