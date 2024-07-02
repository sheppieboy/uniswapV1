// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract Exchange {
    address public tokenAddress;

    constructor(address _token){
        require(_token != address(0), "invalid token address");
        tokenAddress = _token;
    }

    function addLiquidity(uint256 _tokenAmount) public payable {
        IERC20 token = IERC20(tokenAddress);
        token.transferFrom(msg.sender, address(this), _tokenAmount);
    }

    function getReserve() public view returns (uint256){
        return IERC20(tokenAddress).balanceOf(address(this));
    }

    function getTokenAmount(uint256 _ethSold) public view returns(uint256){
        require(_ethSold > 0, "_ethSold is too small");
        uint256 tokenReserve = getReserve();

        return getAmount(_ethSold, address(this).balance, tokenReserve);
    }

    function getEthAmount(uint256 _tokenSold) public view returns(uint256){
        require(_tokenSold > 0, "tokenSold is too small");

        uint256 tokenReserve = getReserve();

        return getAmount(_tokenSold, tokenReserve, address(this).balance);
    }

    //change in x is input amount
    //change in y is output amount, or the return value
    //y is output reserve
    //x is input reserve
    function getAmount(uint256 inputAmount, uint256 inputReserve, uint256 outputReserve) private pure returns (uint256){
        require(inputReserve > 0 && outputReserve > 0, "invalid reserves");
        return (outputReserve * inputAmount)/(inputReserve + inputAmount);
    }
}