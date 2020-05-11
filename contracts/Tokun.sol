pragma solidity ^0.5.0 ;

contract Tokun {
	//token info
	string public name="WYZEN Token";
	string public symbol = "WZT";
	string public standard = "WYZEN Token v0.0.1";

	//events
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	uint256 public totalSupply;
	mapping(address => uint256) public balanceOf;

	constructor(uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;	
		totalSupply = _initialSupply;
	}

	//transfer tokens ---> Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. 
	function transfer(address _to, uint256 _value) public returns (bool success){
		//senders account balance must have the min. tokens
		require(balanceOf[msg.sender] >= _value);
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		emit Transfer(msg.sender,_to,_value);

		return true;
	}
}