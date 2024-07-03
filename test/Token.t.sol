// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token token;

    function setUp() public {
        token = new Token("TestToken", "TST", 100 ether);
    }

    function test_OwnerIsTestContract() public view {
        assertEq(token.balanceOf(address(this)), 100 ether);
    }

    function test_TokenMetaData() public view {
        assertEq(token.name(), "TestToken");
        assertEq(token.symbol(), "TST");
        assertEq(token.totalSupply(), 100 ether);
    }
}