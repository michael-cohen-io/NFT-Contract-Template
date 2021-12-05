// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ERC721Tradable.sol";

/**
 * @title OperatorMixin
 * OperatorMixin - Mixin that allows third party operator addresses the ability to transact on a token owner's behalf. This solution saves in some extraneous gas costs to `setApprovalForAll()` for new traders for this contract. 
 */
abstract contract OperatorMixin is ERC721Tradable {
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    constructor() {
        _grantRole(OPERATOR_ROLE, msg.sender);
        addOpenSeaApproval(); // automatically grants OS the OPERATOR role
    }
    /**
     * @dev checks if a 3p (the operator) can transact on the owners behalf. 
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
      // If the operator (e.g. OpenSea) is granted this role, we terminate early.
      if (hasRole(OPERATOR_ROLE, operator)) {
        return true;
      }
      return super.isApprovedForAll(owner, operator);
    }

    /**
     * @dev Grants OpenSea's Asset proxy contract the OPERATOR role for tokens in this contract
     */
    function addOpenSeaApproval() private onlyRole(DEFAULT_ADMIN_ROLE) {
      addOperatorRole(0x7383b2ce381D10Ce4688c300861221f6f51af9C4);
    }

    /**
     * @dev Grants the address provided the OPERATOR role
     * @param operator address of the third-party operator
     */
    function addOperatorRole(address operator) public onlyRole(DEFAULT_ADMIN_ROLE) {
      require(!hasRole(OPERATOR_ROLE, operator), "Provided address already is an operator");
      _grantRole(OPERATOR_ROLE, operator);
    }

    /**
     * @dev Revokes the OPERATOR role from the address
     * @param operator address of the third-party operator
     */
    function removeOperatorRole(address operator) public onlyRole(DEFAULT_ADMIN_ROLE) {
      require(hasRole(OPERATOR_ROLE, operator), "Provided address not an operator");
      _revokeRole(OPERATOR_ROLE, operator);
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