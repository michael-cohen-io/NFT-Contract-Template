// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "ERC721Tradable.sol";

/**
 * @title ERC721Tradable
 * ERC721Tradable - ERC721 contract that allowlists a trading address, and has minting functionality.
 */
abstract contract WithdrawMixin is ERC721Tradable {

    // Used for access management
    bytes32 public constant WITHDRAW_ROLE = keccak256("WITHDRAW_ROLE");
    constructor() {
        _grantRole(WITHDRAW_ROLE, msg.sender);
    }

    /**
     * @dev Withdraws the smart contract's funds to the caller's wallet. Must have Withdraw role
     */
    function withdraw() onlyRole(WITHDRAW_ROLE) external {
        require(hasRole(WITHDRAW_ROLE, _msgSender()), "ERC721: must have withdrawer role to withdraw");
        payable(_msgSender()).transfer(address(this).balance);
    }

    /**
     * @dev verifies if the interfaceId passed in is supported 
     * Must be implemented here due to Solidity limitations
     * @param interfaceId interface being supported
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Tradable)
        virtual
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}