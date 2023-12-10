// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CompanyBadge is ERC721, Ownable {
    uint256 private _nextTokenId;

    mapping(string => mapping(bytes32 => bool)) private _mintedTokens;

    struct BadgeDetails {
        string campanyDomain;
        bytes32 usernameHash;
        address owner;
    }

    mapping(uint256 => BadgeDetails) public badges;

    constructor() ERC721("CampanyBadge", "BADGE") Ownable(msg.sender) {}

    function safeMint(
        string calldata companyDomain,
        bytes32 usernameHash
    ) public {
        require(!_mintedTokens[companyDomain][usernameHash], "Token already minted for this user and domain");

        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        _mintedTokens[companyDomain][usernameHash] = true;
        badges[tokenId] = BadgeDetails(companyDomain, usernameHash, msg.sender);

        // Add Push Notification
    }
}