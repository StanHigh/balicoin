// BALI COIN ETHEREUM ERC20 SMART CONTRACT
// By. ADAM YUSFAN EDWIN
// =======================================

pragma solidity ^0.4.11;
 
contract Token {
    string public symbol = "BALI";                              // Our Symbol
    string public name = "BALI COIN";                           // Our Name
    uint8 public constant decimals = 18;
    uint256 _totalSupply = 70000000;                            // Total Supply Bali Coin is 70 Million
    address owner = 0x24FF5A1905f2d18c97cE7CEA9f78b354bb17F586; // BALI COIN Address owner
    bool setupDone = false;
   
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
 
    mapping(address => uint256) balances;
 
    mapping(address => mapping (address => uint256)) allowed;
 
 
    function Token(address adr) {
        owner = adr;        
    }
   
    function SetupToken(string tokenName, string tokenSymbol, uint256 tokenSupply)
    {
        if (msg.sender == owner && setupDone == false)
        {
            symbol = tokenSymbol;
            name = tokenName;
            _totalSupply = tokenSupply * 1000000000000000000;
            balances[owner] = _totalSupply;
            setupDone = true;
        }
    }
 
    function totalSupply() constant returns (uint256 totalSupply) {        
        return _totalSupply;
    }
 
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }
 
    function transfer(address _to, uint256 _amount) returns (bool success) {
        if (balances[msg.sender] >= _amount
            && _amount > 0
            && balances[_to] + _amount > balances[_to]) {
            balances[msg.sender] -= _amount;
            balances[_to] += _amount;
            Transfer(msg.sender, _to, _amount);
            return true;
        } else {
            return false;
        }
    }
 
    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) returns (bool success) {
        if (balances[_from] >= _amount
            && allowed[_from][msg.sender] >= _amount
            && _amount > 0
            && balances[_to] + _amount > balances[_to]) {
            balances[_from] -= _amount;
            allowed[_from][msg.sender] -= _amount;
            balances[_to] += _amount;
            Transfer(_from, _to, _amount);
            return true;
        } else {
            return false;
        }
    }
 
 // APPROVE ADDRESS TO SEND COIN
 
    function approve(address _spender, uint256 _amount) returns (bool success) {
        allowed[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount);
        return true;
    }

// LIMIT ALLOWANCE FOR SPENDER ADDRESS
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
