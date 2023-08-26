// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

// gas saving trics
// user keywords : constant, immutable
error NotOwner();

contract FundMe {
using PriceConverter for uint256;
 
    uint256 MINIMUM_USD = 5 * 10 ** 18;

    address[] public  funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor(){
        
        i_owner = msg.sender;
    }

    function fund() public  payable {
         require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!");
        // 1 ETH == 1e18 == 1000000000000000000
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{        

        for (uint256 i = 0; i < funders.length; i++) 
        {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);// reset array

        // There are 3 ways to withdraw fund
        // 1. transfer
        
        // use of 1. transfer in ETH only payable works, incase failure its automatically revert the transaction
            //payable ( msg.sender).transfer(address(this).balance);

         // 2. send, will return true or false, incase of flase we need put required soo fund will be refunded
            //bool  snedSuccess = payable (msg.sender).send(address(this).balance);
            //require(snedSuccess, "Send failed");

        // 3. call
            (bool callSuccess,) =  payable (msg.sender).call{value:address(this).balance}("");
            require(callSuccess, "Call Failed");

    }

    // lets create modifier

    modifier onlyOwner() {
       // require(msg.sender == i_owner, "Must be owner!");
       if(msg.sender != i_owner){revert NotOwner();}
        _;
    }

// what if  someone sends eth to this contract with using our FUND method? how to track them.
    receive() external  payable {
        fund();
    }

    fallback() external payable {

        fund();
    }
}