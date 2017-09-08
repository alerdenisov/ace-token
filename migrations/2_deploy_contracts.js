var AceToken = artifacts.require("./AceToken.sol");

module.exports = function(deployer) {
  deployer.deploy(AceToken);
};
