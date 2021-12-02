// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "ERC721Tradable.sol";

// To read more about NFTs, checkout the ERC721 standard:
// https://eips.ethereum.org/EIPS/eip-721 

/**
Gas efficient implementation, which overrides approval using a registry of approved addreses
**/

contract SimpleNFT is ERC721Tradable {    
    
		// You can pass in your own NFT name and symbol (like a stock ticker) here!
    constructor() ERC721Tradable("NFT Name", "SYMBOL") {
    }

    function baseTokenURI() override public pure returns (string memory) {
      return "";
    }

    /**
     * @dev Mints a token to an address without a tokenUri
     * @param _to address of the future owner of the token
     */
    function mintTo(address _to) override public onlyOwner returns (uint256) {
        return super.mintTo(_to);
    }

}