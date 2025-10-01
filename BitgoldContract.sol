// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

/**
 * @title Bitgold
 * @dev An ERC20 standard token contract
 * Name: Bitgold
 * Symbol: BTG
 * Decimals: 18
 * Total Supply: 20 million BTG (20,000,000 * 10^18)
 * No minting or burning functionality included
 */
contract Bitgold {
    // Token name
    string public constant name = "Bitgold";
    // Token symbol
    string public constant symbol = "BTG";
    // Decimal places
    uint8 public constant decimals = 18;
    // Total supply (20 million * 10^18)
    uint256 public constant totalSupply = 20000000 * 10**18;
    
    // Balance mapping
    mapping(address => uint256) private _balances;
    // Allowance mapping
    mapping(address => mapping(address => uint256)) private _allowances;
    
    // Transfer event
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Approval event
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    /**
     * @dev Constructor that assigns all tokens to the contract deployer
     */
    constructor() {
        _balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    
    /**
     * @dev Gets the token balance of an address
     * @param account The address to query
     * @return The token balance of the address
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    
    /**
     * @dev Transfers tokens
     * @param recipient The address of the recipient
     * @param amount The amount to transfer
     * @return Whether the transfer was successful
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    
    /**
     * @dev Queries the allowed amount
     * @param owner The address of the approver
     * @param spender The address of the approved spender
     * @return The allowed amount
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }
    
    /**
     * @dev Approves an allowance
     * @param spender The address of the spender
     * @param amount The amount to approve
     * @return Whether the approval was successful
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    /**
     * @dev Transfers tokens from an approved address
     * @param sender The address of the sender
     * @param recipient The address of the recipient
     * @param amount The amount to transfer
     * @return Whether the transfer was successful
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Sender is the zero address");
        require(recipient != address(0), "Recipient is the zero address");
        require(_balances[sender] >= amount, "Sender has insufficient balance");
        require(_allowances[sender][msg.sender] >= amount, "Allowance is insufficient");
        
        _allowances[sender][msg.sender] -= amount;
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}
    