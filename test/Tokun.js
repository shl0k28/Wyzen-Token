var Tokun = artifacts.require("./Tokun.sol");

contract('Tokun', function(accounts){

	var tokenInstance;

	it('Initializies the contract with the correct values',function(){
		return Tokun.deployed().then(function(instance){
			tokenInstance = instance;
			return tokenInstance.name();
		})
		.then(function(name){
			assert.equal(name,'WYZEN Token','has the correct name');
			return tokenInstance.symbol();
		})
		.then(function(symbol){
			assert.equal(symbol,'WZT','has the correct symbol');
			return tokenInstance.standard();
		})
		.then(function(standard){
			assert.equal(standard,'WYZEN Token v0.0.1','has the correct standard');
		});
	});

	it('sets the total supply upon deployment', function(){
		return Tokun.deployed().then(function(instance){
			tokenInstance = instance;
			return tokenInstance.totalSupply();
		})
		.then(function(totalSupply){
			assert.equal(totalSupply.toNumber(),1000000, 'sets the total supply');
			return tokenInstance.balanceOf(accounts[0]);
		})
		.then(function(adminBalance){
			assert.equal(adminBalance.toNumber(),1000000,'allocates the initial supply to an admin');
		});
	});

	it('Transfers token ownership',function(){
		return Tokun.deployed().then(function(instance){
			tokenInstance = instance;
			return tokenInstance.transfer.call(accounts[1],9999999999);
		}).then(assert.fail).catch(function(error){
			assert(error.message.indexOf('revert')>=0,'error msg must contain revert');	
			return tokenInstance.transfer(accounts[1],200000,{
				from: accounts[0]
			});
		}).then(function(receipt){
			assert.equal(receipt.logs[0].event,'Transfer','Event must be a "Transfer" event');
			assert.equal(receipt.logs[0].args._from,accounts[0],'Must be transferred from [0] acc');
			assert.equal(receipt.logs[0].args._to,accounts[1],'Must be transferred to [1] acc');
			assert.equal(receipt.logs[0].args._value,200000,'# of tokens should be equal');
			return tokenInstance.balanceOf(accounts[1]);
		}).then(function(balance){
			assert.equal(balance.toNumber(),200000,'token transfer success');
		});
	});
})