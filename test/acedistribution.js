const expectThrow = require('./utils').expectThrow
const promisify = require('./utils').promisify
const AceToken = artifacts.require("./AceToken.sol");
const AceTokenDistribution = artifacts.require("./AceTokenDistribution.sol");


let ACE;
let DISTR;

contract('AceTokenDistribution', accounts => {
  const OWNER_SIGNATURE = { from: accounts[0] }

  beforeEach(async () => {
    ACE = await AceToken.new(accounts[1], accounts[2], OWNER_SIGNATURE)
    DISTR = await AceTokenDistribution.new(ACE.address, accounts[0], OWNER_SIGNATURE)
  })

  describe('Initialization', async() => {
    it('should be deploeyd', async() => {
      assert(DIST)
    })
  })
})