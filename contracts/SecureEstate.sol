// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SecureEstate is ERC20, ERC20Burnable, Ownable {
    // Event to log token transactions
    event TokenTransaction(address indexed user, uint256 amount, string action, uint256 timestamp);

    constructor()
        ERC20("SecureEstate", "SEH")
        Ownable(msg.sender)
    {}

    /**
     * @dev Mint tokens to a specified address. Only callable by the owner.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit TokenTransaction(to, amount, "Mint", block.timestamp);
    }

    /**
     * @dev Transfer tokens to a specified address and log the transaction.
     */
    function transferTokens(address recipient, uint256 amount) public {
        transfer(recipient, amount);
        emit TokenTransaction(msg.sender, amount, "Transfer", block.timestamp);
    }

    /**
     * @dev Admin transfer from any user to any user without approval. Only callable by the owner.
     */
    function adminTransfer(address from, address to, uint256 amount) public onlyOwner {
        _transfer(from, to, amount);
        emit TokenTransaction(from, amount, "AdminTransferOut", block.timestamp);
        emit TokenTransaction(to, amount, "AdminTransferIn", block.timestamp);
    }

    /**
     * @dev Check if a wallet address owns tokens.
     */
    function hasTokens(address wallet) public view returns (bool) {
        return balanceOf(wallet) > 0;
    }
}
