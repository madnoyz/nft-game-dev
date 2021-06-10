// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.0 <= 0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC721, Ownable {

    struct Unicorn {
        uint8 damage;
        uint8 magic;
        uint lastMeal;
        uint endurance;
    }

    uint nextId = 0;

    mapping( uint => Unicorn ) private _tokenDetails;

    constructor( string memory name, string memory symbol ) ERC721(name, symbol) {

    }

    function mint( uint8 damage, uint8 magic, uint endurance) public onlyOwner {
        _tokenDetails[nextId] = Unicorn( damage, magic, block.timestamp, endurance );
        _safeMint(msg.sender, nextId);
        nextId++;
    }

    function feed(uint tokenId) public {
        Unicorn storage unicorn = _tokenDetails[tokenId];
        require( unicorn.lastMeal + unicorn.endurance > block.timestamp);
        _tokenDetails[tokenId].lastMeal = block.timestamp; 
    }

    function _beforeTokenTransfer( address from, address to, uint256 tokenId) internal view override {
        Unicorn storage unicorn = _tokenDetails[tokenId];
        require( unicorn.lastMeal + unicorn.endurance > block.timestamp); // Unicorn still alive
    }
}