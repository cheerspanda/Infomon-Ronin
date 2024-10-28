// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../ERC721Common.sol";

contract InfomonERC721 is ERC721Common {
    // Event to log the minting process
    event MintToClaimerCalled(address indexed to, uint256 tokenId);

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI
    ) ERC721Common(name, symbol, baseTokenURI) {}
}
