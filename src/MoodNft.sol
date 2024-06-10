//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    string private s_saduri;
    string private s_happyuri;
    uint256 private s_tokencounter;

    error NotOwner();

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) public s_tokenIdtomood;

    constructor(
        string memory sad,
        string memory happy
    ) ERC721("Mood Nft", "MOOD") {
        s_tokencounter = 0;
        s_saduri = sad;
        s_happyuri = happy;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokencounter);
        s_tokenIdtomood[s_tokencounter] = Mood.HAPPY;
        s_tokencounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (
            ownerOf(tokenId) != msg.sender && getApproved(tokenId) != msg.sender
        ) {
            revert NotOwner();
        }
        if (s_tokenIdtomood[tokenId] == Mood.HAPPY) {
            s_tokenIdtomood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdtomood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdtomood[tokenId] == Mood.HAPPY) {
            imageUri = s_happyuri;
        } else {
            imageUri = s_saduri;
        }
        bytes memory tokenmetadata = abi.encodePacked(
            '{"name": "',
            name(),
            '", "description": "Nft that has mood swings", "attributes": "[{ "trait_type": "moddy", "value": 100}]", "image": "',
            imageUri,
            '"}'
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(tokenmetadata)
                )
            );
    }

    function gettokenid() external view returns (uint256) {
        uint256 tokenid = s_tokencounter - 1;
        return tokenid;
    }
}
