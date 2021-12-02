// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract SimpleStorage {
  uint256 storedData;
	
  function get() public view returns (uint) {
    return storedData;
  }

  function set(uint x) public {
    storedData = x;
  }

  function double() public {
    storedData *= 2;
  }
}

contract MathTest {
	function multiply(uint a, uint b) public pure returns (uint) {
    return a*b;
  }
}
