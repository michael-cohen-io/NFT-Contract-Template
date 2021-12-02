// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.5;
/*

  Proxy registry interface.

*/

import "./OwnableDelegateProxy.sol";

/**
 * @title ProxyRegistryInterface
 * @author Wyvern Protocol Developers
 */
interface ProxyRegistryInterface {

    function delegateProxyImplementation() external returns (address);

    function proxies(address owner) external returns (OwnableDelegateProxy);

}