var AceToken = artifacts.require("./AceToken.sol");
var AceTokenDistribution = artifacts.require('./AceTokenDistribution.sol');

module.exports = async function(deployer) {
  await deployer.deploy(AceToken)
  await deployer.deploy(AceTokenDistribution, AceToken.address)

  const tokenInstance = await AceToken.deployed()
  const distrInstance = await AceTokenDistribution.deployed()

  console.log(`Initial owner: ${await tokenInstance.owner()}`)

  await tokenInstance.transferOwnership(distrInstance.address)

  console.log(`Final owner: ${await tokenInstance.owner()}`)
  // await deployer.deploy(AceTokenDistribution, '0x87aa42ab921a7179add7e0152f2c85c08b78977e')
};
