pragma solidity ^0.5.0 ;

contract Tokun {
	//token info
	string public name="WYZEN Token";
	string public symbol = "WZT";
	string public standard = "WYZEN Token v0.0.1";

	//events

	//Emit Transfer
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	//approval
	event Approval(
		address indexed _owner,
		address indexed _spender, 
		uint256 _value
	);

	uint256 public totalSupply;
	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;

	//assigning all the tokens to an admin account
	constructor(uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;	
		totalSupply = _initialSupply;
	}

	//functions

	//transferFrom

	//transfer tokens ---> Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. 
	function transfer(address _to, uint256 _value) public returns (bool success){
		//senders account balance must have the min. tokens
		require(balanceOf[msg.sender] >= _value);

		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		emit Transfer(msg.sender,_to,_value);

		return true;
	}

	//approve 
	function approve(address _spender, uint256 _value) public returns (bool success){
		//allowance
		allowance[msg.sender][_spender] = _value;
		//Approval event
		emit Approval(msg.sender, _spender, _value);

		return true;
	}

	//delegated transfer
	function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
		require(_value <= balanceOf[_from]);
		require(_value <= allowance[_from][msg.sender]);

		//update the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;

		//update the allowance
		allowance[_from][msg.sender] -= value;

		//transfer event to log the record to the ledger
		emit Transfer(_from,_to,_value);

		return true;
	}

}















