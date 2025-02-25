//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployManualToken} from "../script/DeployManualToken.s.sol";
import {ManualToken} from "src/ManualToken.sol";

contract ManualTokenTest is Test {
    DeployManualToken public deployer;
    ManualToken public manualToken;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;


    function setUp() public {
        deployer = new DeployManualToken();
        manualToken = deployer.run();
        
        vm.prank(msg.sender);
        manualToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public{
        assertEq(manualToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 1000;
        //bob approves alice to spend tokens on her behalf
        vm.prank(bob);
        manualToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;
        vm.prank(alice);
        manualToken.transferFrom(bob, alice, transferAmount);

        assertEq(manualToken.balanceOf(bob), STARTING_BALANCE - transferAmount);

        
    }

}