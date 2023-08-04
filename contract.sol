/*
Write a smart contract to create your own token on a local HardHat network. Once you have your contract, you should be able to use remix to interact with it. From remix, 
the contract owner should be able to mint tokens to a provided address. Any user should be able to burn and transfer tokens.
*/

// SPDX-License-Identifier: MIT    

pragma solidity ^0.8.0; 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CustomToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("MyToken", "MyTk") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
