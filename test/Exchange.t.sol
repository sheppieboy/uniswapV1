// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {Exchange} from "../src/Exchange.sol";

contract AddLiquidityTest is Test {
    Token token;
    Exchange exchange;

    function setUp() public {
        // new test token
        token = new Token("TestToken", "TST", 1000 ether);

        //new exchange between token and eth
        exchange = new Exchange(address(token));

        //send some tokens to this test contract for testing
        token.transfer(address(this), 200 ether);
    }

    function test_AddLiquidity() public {
        //approve exchange to use the 200 tokens
        token.approve(address(exchange), 200 ether);

        //call addLiquidity with 100 ether and 200 tokens
        exchange.addLiquidity{value: 100 ether}(200 ether);

        //check exchange has 100 ether
        assertEq(address(exchange).balance, 100 ether);

        //check exchange has 200 tokens
        assertEq(exchange.getReserve(), 200 ether);
    }
}