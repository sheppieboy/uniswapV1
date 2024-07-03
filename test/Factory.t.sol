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

    function test_IsDeployed() public view {
        assertEq(address(factory) != address(0), true);
    }

    function test_CreateExchangeDeploysAnExchange() public {        
        
        address exchangeAddress = factory.createExchange(address(token));

        Exchange exchange = Exchange(exchangeAddress);

        //check the properties of the deployed exchange
        assertEq(exchange.name(), "uniswapV1");
        assertEq(exchange.symbol(), "UNI");
        assertEq(exchange.factoryAddress(), address(factory));
    }

    function test_revertWhen_CreateExchangeCallsOnSameTokenAddressMoreThanOnce() public {
        
        factory.createExchange(address(token));

        vm.expectRevert("exchange already exists");
        factory.createExchange(address(token));
    }

    function test_expectRevert_WhenZeroAddress() public {
        vm.expectRevert("invalid token address");
        factory.createExchange(address(0));
    }

    function test_GetExchangeReturnsAddressByTokenAddress() public {

        address exchangeAddress = factory.createExchange(address(token));

        assertEq(factory.getExchange(address(token)), exchangeAddress);
    }
}