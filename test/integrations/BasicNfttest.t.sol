//SPDX-License-Identifier

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {deployNft} from "../../script/deployNft.s.sol";
import {Nft} from "../../src/Nft.sol";

contract TestNft is Test {
    deployNft deploy;
    Nft Nfttoken;
    address user = makeAddr("user");
    string public constant TOKENURIID =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deploy = new deployNft();
        Nfttoken = deploy.run();
    }

    function testmint() public {
        vm.prank(user);
        Nfttoken.mintNft(TOKENURIID);
        bytes32 tokenuri = keccak256(abi.encodePacked(Nfttoken.tokenURI(0)));

        assertEq(tokenuri, keccak256(abi.encodePacked(TOKENURIID)));
    }

    function testname() public view {
        bytes32 expectedname = keccak256(abi.encodePacked("heheboii"));
        bytes32 nftname = keccak256(abi.encodePacked(Nfttoken.name()));

        assertEq(expectedname, nftname);
    }
}
