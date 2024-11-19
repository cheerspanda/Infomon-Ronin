// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract InfomonERC1155 is ERC1155, AccessControl {
    using Strings for uint256;
    

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // Metadata Uri
    string private _baseURI;

    // Event to log the minting process
    event MintToClaimerCalled(
        address indexed to,
        uint256 tokenId,
        uint256 amount
    );

    // Event to log the burning process
    event BurnCalled(address indexed from, uint256 tokenId, uint256 amount);

    constructor(string memory uri_) ERC1155(uri_) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _baseURI = uri_;
    }

    // Function: mintToClaimer
    // Purpose: Allows accounts with the MINTER_ROLE to mint tokens for a specified address `to_`.
    // Parameters:
    //    - to_: The address that will receive the minted tokens.
    //    - tokenId_: The ID of the token type to mint (for ERC1155 tokens, this is the type of the token).
    //    - amount_: The quantity of tokens to mint (for ERC1155, this could be greater than 1).
    // Returns:
    //    - uint256: The ID of the minted token (same as `tokenId_` provided).
    //    - uint256: The amount of tokens minted (same as `amount_` provided).
    // Events:
    //    - Emits a MintToClaimerCalled event indicating the recipient address, tokenId, and amount of tokens minted.
    function mintToClaimer(
        address to_,
        uint256 tokenId_,
        uint256 amount_
    ) external onlyRole(MINTER_ROLE) returns (uint256, uint256) {
        _mint(to_, tokenId_, amount_, "");
        emit MintToClaimerCalled(to_, tokenId_, amount_);
        return (tokenId_, amount_);
    }

    // Function: burn
    // Purpose: Allows the token holder to burn a specified amount of tokens of a specific token ID.
    // Parameters:
    //    - tokenId_: The ID of the token type to burn.
    //    - amount_: The quantity of tokens to burn.
    // Events:
    //    - Emits a BurnCalled event indicating the token holder's address, tokenId, and amount of tokens burned.
    function burn(uint256 tokenId_, uint256 amount_) external {
        _burn(msg.sender, tokenId_, amount_);
        emit BurnCalled(msg.sender, tokenId_, amount_);
    }
    
    // Function: tokenURI
    // Purpose: Constructs and returns the metadata URI for a specific token ID.
    // Parameters:
    //    - _tokenId: The ID of the token whose metadata URI is being requested.
    // Returns:
    //    - A string representing the full metadata URI for the specified token ID.
    // Example:
    //    - If the base URI is "https://example.com/metadata/" and _tokenId is 1,
    //      the function will return "https://example.com/metadata/1".
    // Requirements:
    //    - The token ID (_tokenId) must correspond to an existing token.
    //    - The base URI (_baseURI) must be correctly set in the contract.
    function tokenURI(uint256 _tokenId)
        external
        view
        virtual
        returns (string memory)
    {
        return string(abi.encodePacked(_baseURI, _tokenId.toString()));
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
