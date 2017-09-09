var AceToken = artifacts.require("./AceToken.sol");
var SimpleAceVoting = artifacts.require("./SimpleAceVoting.sol");

module.exports = function(deployer) {
  deployer.deploy(AceToken).then(function() {
    return deployer.deploy(SimpleAceVoting, AceToken.address);
  })
};
