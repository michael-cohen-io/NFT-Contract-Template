// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


/**
 * @title ERC721Tradable
 * ERC721Tradable - ERC721 contract with basic functionality and AccessControl
 */
abstract contract ERC721Tradable is ERC721, AccessControl {
    using SafeMath for uint256;
    
    // a simple counter
    uint256 private tokenId;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        tokenId = 0;
    }

    /**
     * @dev Returns the base uri used for all the tokens
     */
    function baseTokenURI() virtual public pure returns (string memory);

    /**
     * @dev Returns the tokenURI for the tokenId, which is just baseTokenURI + tokenId
    * @param _tokenId the tokenId
     */
    function tokenURI(uint256 _tokenId) override public pure returns (string memory) {
        return string(abi.encodePacked(baseTokenURI(), Strings.toString(_tokenId)));
    }

    /**
     * @dev Mints a token to an address.
     * @param _to address of the future owner of the token
     */
    function mint(address _to) public virtual payable returns (uint256) {
        _safeMint(_to, tokenId);
        tokenId += 1;
        return tokenId;
    }

    /**
     * @dev verifies if the interfaceId passed in is supported 
     * Must be implemented here due to Solidity limitations
     * @param interfaceId interface being supported
     */
    function supportsInterface(bytes4 interfaceId)
        public
        virtual
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
}