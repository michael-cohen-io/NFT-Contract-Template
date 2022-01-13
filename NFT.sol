// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


import "ERC721Common.sol";
import "MinterMixin.sol";
import "OpenSeaMixin.sol";
import "PaymentMixin.sol";

// To read more about NFTs, checkout the ERC721 standard:
// https://eips.ethereum.org/EIPS/eip-721 


/**
 * @title SimpleNFT
 * SimpleNFT - A concrete NFT contract implementation that can optionally inherit from several Mixins for added functionality or directly from ERC721Common for a barebones implementation. 
 */
contract NFT is MinterMixin, OpenSeaMixin, PaymentMixin {    
    
    // Price to mint a new token
    uint256 public constant MINT_PRICE = 0.08 ether;
    uint256 public constant TOTAL_SUPPLY = 10_000;
    address[] PAYEES = [0xb9720BE63Ea8896956A06d2dEd491De125fD705E];
    uint256[] SHARES = [100];

    /**
     * @dev Replace with your own unique name and symbol
     */
    constructor() 
        ERC721Common("SimpleNFT", "SYMBOL") 
        PaymentMixin(PAYEES, SHARES) 
        MinterMixin(TOTAL_SUPPLY, MINT_PRICE) {
    }

    function baseTokenURI() public override pure returns (string memory) {
      return "https://creatures-api.opensea.io/api/creature/";
    }

    /**
     * @dev checks if a 3p (the operator) can transact on the owners behalf. 
     * Deferrs to the OperatorMixin implementation
     * @param owner address of the owner of the token
     * @param operator address of the third-party operator
     */
    function isApprovedForAll(address owner, address operator)
        override(ERC721, OpenSeaMixin)
        public
        view
        returns (bool)
    {
      return super.isApprovedForAll(owner, operator);
    }

    /**
     * @dev verifies if the interfaceId passed in is supported 
     * Must be implemented here due to Solidity limitations
     * @param interfaceId interface being supported
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(MinterMixin, OpenSeaMixin)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}