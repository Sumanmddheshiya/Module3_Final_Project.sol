// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("DegenToken", "DGN") {}

    function mint(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount must be greater than zero.");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeemPrize(uint256 prizeCost) external {
require(prizeCost > 0, "Prize cost must be greater than zero.");
        require(balanceOf(_msgSender()) >= prizeCost, "Insufficient balance.");

        // Generate a pseudo-random number using block hash
        uint256 blockHashRandom = uint256(blockhash(block.number - 1));

        // Determine the prize selection based on the generated random number
        bool selectedPrizeA = (blockHashRandom % 2 == 0); // true for Prize A, false for Prize B

        // Emit an event to indicate the prize selection
        emit PrizeSelected(_msgSender(), prizeCost, selectedPrizeA);

        // Deduct the prize cost from the sender's balance
        _burn(_msgSender(), prizeCost);

        // Emit an event to indicate successful redemption
        emit RedemptionSuccessful(_msgSender(), prizeCost);
    }
function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    // Custom events to emit during the prize redemption process
    event PrizeSelected(address indexed account, uint256 prizeCost, bool selectedPrizeA);
    event RedemptionSuccessful(address indexed account, uint256 prizeCost);
}
