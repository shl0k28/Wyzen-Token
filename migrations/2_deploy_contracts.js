const Tokun = artifacts.require("./Tokun.sol");

module.exports = function(deployer) {
  deployer.deploy(Tokun);
};
