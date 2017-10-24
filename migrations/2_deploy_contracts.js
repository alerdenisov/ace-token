var AceToken = artifacts.require("./AceToken.sol");
var AceTokenDistribution = artifacts.require('./AceTokenDistribution.sol');

module.exports = function(deployer) {
  deployer.deploy(AceToken, function(token) {
    console.log(token)
    deployer.deploy(AceTokenDistribution, token.address)
  });
};
