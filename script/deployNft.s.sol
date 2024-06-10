//SPDX-License-Identifier

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Nft} from "../src/Nft.sol";

contract deployNft is Script {
    Nft nft;

    function run() external returns (Nft) {
        vm.startBroadcast();

        nft = new Nft();

        vm.stopBroadcast();
        return nft;
    }
}
