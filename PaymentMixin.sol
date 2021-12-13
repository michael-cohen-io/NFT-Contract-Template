// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "ERC721Common.sol";

/**
 * @title ERC721Common
 * ERC721Common - ERC721 contract that allowlists a trading address, and has minting functionality.
 */
abstract contract PaymentMixin is PaymentSplitter {

     constructor(address[] memory _payees, uint256[] memory _shares) PaymentSplitter(_payees, _shares) payable {}
}
