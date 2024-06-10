//SPDX-License-Identifier

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import "forge-std/console.sol";

contract MintMood is Script {
    MoodNft moodnft;

    function run() public {
        address mostrecentdeplyed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        console.log(mostrecentdeplyed);
        //address contra = 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0;
        mintMood(mostrecentdeplyed);
    }

    function mintMood(address recentdeployed) public {
        vm.startBroadcast();
        MoodNft(recentdeployed).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMood is Script {
    MoodNft moodnft;

    function run() public {
        address mostrecentdeplyed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipMood(mostrecentdeplyed);
    }

    function flipMood(address recentaddress) public {
        uint256 tokenid = moodnft.gettokenid();
        vm.startBroadcast();
        MoodNft(recentaddress).flipMood(tokenid);
        vm.stopBroadcast();
    }
}
