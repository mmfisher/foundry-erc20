//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ManualToken} from "../src/ManualToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployManualToken is Script {

    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run()  external returns (ManualToken) {
        vm.startBroadcast();
        ManualToken manualToken = new ManualToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return  manualToken;
    }


}