// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {Factory} from "../src/Factory.sol";
import {Exchange} from "../src/Exchange.sol";

contract FactoryTest is Test {
    Token token;
    Factory factory;
    address owner;

    function setUp() public {
        owner = address(this);
        token = new Token("Token", "TKN", 1000000 * 10**18);
        factory = new Factory();
    }

    function test_IsDeployed() public {
        assertEq(address(factory) != address(0), true);
    }
}