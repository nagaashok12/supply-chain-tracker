
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    enum State { Manufactured, Shipped, Received }

    struct Product {
        uint id;
        string name;
        address owner;
        State state;
    }

    uint public productCounter = 0;
    mapping(uint => Product) public products;

    event ProductCreated(uint id, string name, address owner);
    event StateChanged(uint id, State state);

    function createProduct(string memory name) public {
        productCounter++;
        products[productCounter] = Product(productCounter, name, msg.sender, State.Manufactured);
        emit ProductCreated(productCounter, name, msg.sender);
    }

    function changeState(uint id, State newState) public {
        Product storage product = products[id];
        require(msg.sender == product.owner, "Only owner can update state");
        product.state = newState;
        emit StateChanged(id, newState);
    }
}
