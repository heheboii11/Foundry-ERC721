//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Nft is ERC721 {
    uint256 public s_counter;
    mapping(uint256 => string) public s_tokenUritoId;

    constructor() ERC721("heheboii", "hehe") {
        s_counter = 0;
    }

    function mintNft(string memory tokenuri) public {
        s_tokenUritoId[s_counter] = tokenuri;

        _safeMint(msg.sender, s_counter);

        s_counter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenUritoId[tokenId];
    }
}
