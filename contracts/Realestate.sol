// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract Realestate {
    struct User {
        uint id;
        address userAddress;
        uint[] postedProperties;
        uint[] purchasedProperties;
        string role;
    }

    struct Property {
        uint id;
        string name;
        string location;
        bool forRent;
        uint rent;
        uint fullCost;
        address propertyOwner;
        address propertyBuyer;
        bool isActive;
        string postingDate;
        string purchaseDate;
        bool isPurchased;
        string[] imageURL;
    }

    Property[] public properties;
    User[] public users;
    mapping(address => Property[]) public postingsMapping;

    constructor() {
        users.push(User(0, msg.sender, new uint[](0), new uint[](0), "admin"));
    }

    //function

    function createProperty(
        string memory _name,
        string memory _location,
        bool _forRent,
        uint _rent,
        uint _fullCost,
        address _propertyOwner,
        string memory _postingDate,
        string[] memory _imageURL
    ) public returns (Property memory) {
        // Check if a property with the same name and location already exists
        for (uint i = 0; i < properties.length; i++) {
            if (
                keccak256(abi.encodePacked(properties[i].name)) ==
                keccak256(abi.encodePacked(_name)) &&
                keccak256(abi.encodePacked(properties[i].location)) ==
                keccak256(abi.encodePacked(_location))
            ) {
                return properties[i];
            }
        }

        Property memory newProperty = Property({
            id: properties.length,
            name: _name,
            location: _location,
            forRent: _forRent,
            rent: _rent,
            fullCost: _fullCost,
            propertyOwner: _propertyOwner,
            propertyBuyer: address(0),
            isActive: true,
            postingDate: _postingDate,
            purchaseDate: "",
            isPurchased: false,
            imageURL: _imageURL
        });

        properties.push(newProperty);

        return newProperty;
    }

    function createUser() public returns (User memory) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].userAddress == msg.sender) {
                return users[i];
            }
        }

        User memory newUser = User({
            id: users.length,
            userAddress: msg.sender,
            postedProperties: new uint[](0),
            purchasedProperties: new uint[](0),
            role: "user"
        });

        users.push(newUser);

        return newUser;
    }

    function createMapping(
        Property memory _property,
        User memory _user
    ) public returns (Property[] memory) {
        postingsMapping[_user.userAddress].push(_property);
        return postingsMapping[_user.userAddress];
    }

    function getAllPropertyOfAddress(
        address _userAddress
    ) public view returns (Property[] memory) {
        return postingsMapping[_userAddress];
    }
}
