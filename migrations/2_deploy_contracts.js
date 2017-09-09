var AceToken = artifacts.require("./AceToken.sol");
var SimpleAceVoting = artifacts.require("./SimpleAceVoting.sol");

module.exports = async function(deployer) {
  await deployer.deploy(AceToken);
  await deployer.deploy(SimpleAceVoting, AceToken.address);
};
