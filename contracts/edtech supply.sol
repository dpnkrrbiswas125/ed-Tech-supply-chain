// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EdTechSupplyChain {
    struct Product {
        string name;
        address owner;
        bool isAuthentic;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount = 0;

    event ProductRegistered(uint256 productId, string name, address owner);
    event OwnershipTransferred(uint256 productId, address newOwner);
    event ProductVerified(uint256 productId, bool isAuthentic);

    // Register a new product
    function registerProduct(string memory _name) public {
        productCount++;
        products[productCount] = Product(_name, msg.sender, true);
        emit ProductRegistered(productCount, _name, msg.sender);
    }

    // Transfer ownership of a product
    function transferOwnership(uint256 _productId, address _newOwner) public {
        require(products[_productId].owner == msg.sender, "Only the owner can transfer ownership");
        products[_productId].owner = _newOwner;
        emit OwnershipTransferred(_productId, _newOwner);
    }

    // Verify the authenticity of a product
    function verifyProduct(uint256 _productId) public view returns (bool) {
        return products[_productId].isAuthentic;
    }

    // Track the current owner of a product
    function trackOwnership(uint256 _productId) public view returns (address) {
        return products[_productId].owner;
    }
}
