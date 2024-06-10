//SPDX-License-Identifier

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import "forge-std/console.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract deployMood is Script {
    MoodNft MoodNFT;
    string s_saduri = vm.readFile("./img/sad.svg");
    string s_happyuri = vm.readFile("./img/smile.svg");

    function run() external returns (MoodNft) {
        string memory saduri = SvgtoUri(s_saduri);
        string memory happyuri = SvgtoUri(s_happyuri);
        vm.startBroadcast();
        MoodNFT = new MoodNft(saduri, happyuri);
        vm.stopBroadcast();
        console.log(s_happyuri);
        return MoodNFT;
    }

    function SvgtoUri(string memory Svg) public pure returns (string memory) {
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory SvgbasedUri = Base64.encode(
            bytes(string(abi.encodePacked(Svg)))
        );
        return string(abi.encodePacked(baseUri, SvgbasedUri));
    }
}
