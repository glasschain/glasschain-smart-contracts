// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Glasschain {
    
    struct User {
        address userAddress;
        bytes32[] ratingHashes;
        bytes32 companyId;
    }
    
    struct Rating {
        bytes32 ratingId;
        address userAddress;
        bytes32 companyId;
        string companyDomain;
        uint8 ratingScore;
        string ipfsCommentHash;
        uint256 timeCreated;
    }
    
    struct CompanyRating {
        bytes32 companyId;
        mapping(uint8 => uint256) ratingScores; // number of 1s, 2s, 3s, 4s, 5s
        bytes32[] ratingHashes;
    }
    
    struct CompanyObj {
        bytes32 companyId; // hash of the company domain
        string name;
        string ipfsComapnyHash;
        string companyDomain;
    }

    bytes32[] public companyIds;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // mapping of user address to user object
    mapping(address => User) public users;

    // mapping of company domain to company object
    mapping(bytes32 => CompanyObj) public companyObjs;

    // mapping of rating id to rating object
    mapping(bytes32 => Rating) public ratingObjs;

    // mapping of company domain to company rating object
    mapping(bytes32 => CompanyRating) public companyRatingObjs;

    function registerCompany(string memory companyName, string memory ipfsComapnyHash, string memory companyDomain) external {
        // make sure that only owner of the contract can register a company
        require(msg.sender == owner, "Only owner can register a company");
        bytes32 companyId = keccak256(abi.encodePacked(companyDomain));
        // add company to companyIds
        companyIds.push(companyId);
        companyObjs[companyId] = CompanyObj(companyId, companyName, ipfsComapnyHash, companyDomain);
    }

    function registerUser(string memory companyDomain) external {
        bytes32 companyId = keccak256(abi.encodePacked(companyDomain));
        // make sure that company is registered
        require(companyObjs[companyId].companyId != 0, "Company not registered");
        users[msg.sender] = User(msg.sender, new bytes32[](0), companyId);
    }

    function addReview(uint8 ratingScore, string memory companyDomain, string memory ipfsCommentHash) external {
        bytes32 companyId = keccak256(abi.encodePacked(companyDomain));
        require(companyObjs[companyId].companyId != 0, "Company not registered");
        require(users[msg.sender].userAddress != address(0), "User not registered");

        // user should only be able to add review for the company they are registered with
        require(users[msg.sender].companyId == companyId, "User not registered with the company");

        bytes32 ratingId = keccak256(abi.encodePacked(msg.sender, companyId));

        // make sure rating doesn't already exist in user's ratingHashes
        for (uint256 i = 0; i < users[msg.sender].ratingHashes.length; i++) {
            require(users[msg.sender].ratingHashes[i] != ratingId, "Rating already exists for the user and company");
        }

        Rating memory ratingObj = Rating(ratingId, msg.sender, companyId, companyDomain, ratingScore, ipfsCommentHash, block.timestamp);
        
        ratingObjs[ratingId] = ratingObj;
        users[msg.sender].ratingHashes.push(ratingId);

        companyRatingObjs[companyId].ratingScores[ratingScore]++;
        companyRatingObjs[companyId].ratingHashes.push(ratingId);
    }

    function fetchUser() external view returns (string memory companyDomain, bytes32[] memory ratingHashes) {
        require(users[msg.sender].userAddress != address(0), "User not registered");
        return (companyObjs[users[msg.sender].companyId].companyDomain, users[msg.sender].ratingHashes);
    }

    function fetchCompanyRatings(string memory companyDomain) external view returns (uint8[] memory, bytes32[] memory) {
        bytes32 companyId = keccak256(abi.encodePacked(companyDomain));
        require(companyObjs[companyId].companyId != 0, "Company not registered");

        CompanyRating storage companyRatingObj = companyRatingObjs[companyId];
        uint8[] memory ratingScores = new uint8[](5);

        for (uint8 i = 0; i < 5; i++) {
            ratingScores[i] = uint8(companyRatingObj.ratingScores[i+1]);
        }

        return (ratingScores, companyRatingObj.ratingHashes);
    }

    function fetchRating(bytes32 ratingId) external view returns (uint8 rating, string memory companyDomain, string memory ipfsCommentHash, uint256 timeCreated) {
        Rating storage ratingObj = ratingObjs[ratingId];
        return (ratingObj.ratingScore, ratingObj.companyDomain, ratingObj.ipfsCommentHash, ratingObj.timeCreated);
    }

    function fetchAllCompanies() external view returns (bytes32[] memory allCompanyIds, string[] memory ipfsComapnyHashes, string[] memory companyDomains) {
        uint256 length = companyIds.length;
        bytes32[] memory _allCompanyIds = new bytes32[](length);
        string[] memory _ipfsComapnyHashes = new string[](length);
        string[] memory _companyDomains = new string[](length);

        for (uint256 i = 0; i < length; i++) {
            _allCompanyIds[i] = companyObjs[companyIds[i]].companyId;
            _ipfsComapnyHashes[i] = companyObjs[companyIds[i]].ipfsComapnyHash;
            _companyDomains[i] = companyObjs[companyIds[i]].companyDomain;
        }

        return (_allCompanyIds, _ipfsComapnyHashes, _companyDomains);
    }
}
