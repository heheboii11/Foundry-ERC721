//SPDX-License-Identifier

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Nft} from "../src/Nft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract interaction is Script {
    string public constant TOKENURIID =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostrecentdeplyed = DevOpsTools.get_most_recent_deployment(
            "Nft",
            block.chainid
        );
        mintNftoncontract(mostrecentdeplyed);
    }

    function mintNftoncontract(address mostrecentaddress) public {
        vm.startBroadcast();
        Nft(mostrecentaddress).mintNft(TOKENURIID);
        vm.stopBroadcast();
    }
}
