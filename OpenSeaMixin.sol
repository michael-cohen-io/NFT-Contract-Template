// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@divergencetech/ethier/contracts/erc721/OpenSeaGasFreeListing.sol";
import "ERC721Common.sol";

/**
 * @title OpenSeaMixin
 * OpenSeaMixin - that overrides isApprovedForAll in a manner that allows users to skip the approval step when selling their NFTs, saving them a gas-costing transaction.
 * OpenSeaGasFreeListing.sol comes from ethier, a common-contract logic library implemented by divergencetech
 */
abstract contract OpenSeaMixin is ERC721Common {

    /**
     * @dev Overrides the default implementation to also return true if the operator is OpenSea
     * @param owner address of the owner of the token
     * @param operator address of the third-party operator
     */
    function isApprovedForAll(address owner, address operator)
        override
        public
        virtual
        view
        returns (bool)
    {
      return super.isApprovedForAll(owner, operator) ||
            OpenSeaGasFreeListing.isApprovedForAll(owner, operator);
    }

    /**
     * @dev verifies if the interfaceId passed in is supported 
     * Must be implemented here due to Solidity limitations
     * @param interfaceId interface being supported
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Common)
        virtual
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}