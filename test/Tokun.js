var Tokun = artifacts.require("./Tokun.sol");

contract('Tokun', function(accounts){
	it('sets the total supply upon deployment', function(){
		return Tokun.deployed().then(function(instance){
			tokenInstance = instance;
			return tokenInstance.totalSupply();
		})
		.then(function(totalSupply){
			assert.equal(totalSupply.toNumber(),1000000, 'sets the total supply');
		});
	});
})