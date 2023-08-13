//SPDX-License-Identifier: MIT

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.18;


import "hardhat/console.sol";


contract MyToken {
    
    string public _name = "Rdsb_Token";
    string public _symbol = "Rdsb";
    uint256 public _totalSupply = 23;
    address public _owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowances;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event TransferFrom(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);


    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner can call this function.");
        _;
    }

    constructor() {
        balances[msg.sender] = _totalSupply;
        _owner = msg.sender;
    }

    function tokenBalance(address account) external view returns (uint) {
        return balances[account];
    }

    function mintToken(address to , uint value) public onlyOwner{
        balances[to] += value;

        emit Mint(to, value);
    }

    function burnToken(uint value) public {
        require(balances[msg.sender] >= value , "Insufficient Balance");

        balances[msg.sender] -= value;
        
        emit Burn(msg.sender, value);
    }
    
    function transfer(address to, uint value) external {

        require(balances[msg.sender] >= value, "Not enough tokens");

        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
    }

     function approve(address _spender, uint256 _value) external  {
        require(_spender != address(0), "Invalid address");

        allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
     }
       
        function transferFrom(address from , address to, uint value) external {

        require(balances[from] >= value, "Not enough tokens");

        balances[from] -= value;
        balances[to] += value;

        emit TransferFrom(from, to, value);
    }
}
