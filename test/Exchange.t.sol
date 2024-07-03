// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {Exchange} from "../src/Exchange.sol";

contract ExchangeTest is Test {
    Token token;
    Exchange exchange;

    function setUp() public {
        
        // new test token, testcontract now has 1000 tokens
        token = new Token("TestToken", "TST", 1000 ether);

        //new exchange between token and eth
        exchange = new Exchange(address(token));

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

    function test_GetTokenAmount() public {
        token.approve(address(exchange), 200 ether);

        exchange.addLiquidity{value: 100 ether}(200 ether);

        //token amount for 1 eth
        uint256 tokensOut = exchange.getTokenAmount(1 ether);

        assertEq(tokensOut, 1960590157441330824);
    }

    function test_GetEthAmount() public {
        token.approve(address(exchange), 200 ether);

        exchange.addLiquidity{value: 100 ether}(200 ether);

        //eth amount for 2 tokens
        uint256 ethOut = exchange.getEthAmount(2 ether);

        assertEq(ethOut, 980295078720665412);
    }
}

