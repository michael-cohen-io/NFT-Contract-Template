// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "./FixedPriceSeller.sol";

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
contract SimpleNFT is MinterMixin, OpenSeaMixin, PaymentSplitter, FixedPriceSeller {    
// contract SimpleNFT is ERC721Common {    
    
    // Price to mint a new token
    uint256 public constant MINT_PRICE = 0.08 ether;
    uint256 public constant TOTAL_SUPPLY = 10_000;

    /**
     * @dev Replace with your own unique name and symbol
     */
    constructor(uint256 mintPrice, address[] memory _payees, uint256[] memory _shares) 
        ERC721Common("SimpleNFT", "SYMBOL") PaymentMixin(_payees, _shares) 
        FixedPriceSeller(mintPrice,
            SellerConfig(TOTAL_SUPPLY, 1, 1, 0, false, false, false),
            payable(0)) {
    }

    function baseTokenURI() public override pure returns (string memory) {
      return "https://creatures-api.opensea.io/api/creature/";
    }

    /**
     * @dev Mints a new token to the address specifed at the MINT_PRICE price
     * @param _to address of the future owner of the token
     */
    function mint(address _to) public override(MinterMixin) payable returns (uint256) {
        require(msg.value == MINT_PRICE, "Transaction value did not equal MINT_PRICE");
        return super.mint(_to);
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
        override(MinterMixin, OpenSeaMixin, WithdrawMixin)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}