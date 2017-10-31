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
    DISTR = await AceTokenDistribution.new(ACE.address, OWNER_SIGNATURE)
  })

  describe('Initialization', async() => {
    it('should be deploeyd', async() => {
      assert(DISTR)
    })

    it('should haven\'t right to mint by default', async() => {
      expectThrow(DISTR.bulkMint(accounts, accounts.map(acc => 100000), OWNER_SIGNATURE))
    })

    it('should give right to mint', async() => {
      await ACE.transferOwnership(DISTR.address, OWNER_SIGNATURE);
      await DISTR.bulkMint(accounts, accounts.map(acc => 100000), OWNER_SIGNATURE);
    })

    it('should return rights to mint', async() => {
      await ACE.transferOwnership(DISTR.address, OWNER_SIGNATURE);
      assert(await ACE.owner() == DISTR.address);
      await DISTR.returnOwnership(OWNER_SIGNATURE);
      assert(await ACE.owner() == accounts[0]);
    })
  })

  describe('Minting', async() => {
    const assertEquals = async (func, expect, msg) => {
      const value = await func()
      assert(value.equals(expect), msg || `Value isnt expected! (current is ${value} but expected is ${expect})`)
    }

    const assertSupply = async (expect, msg) => {
      await assertEquals(ACE.totalSupply, expect, msg)
    }

    beforeEach(async() => {
      await ACE.transferOwnership(DISTR.address, OWNER_SIGNATURE)
    })

    it('should mint 10000 tokens', async() => {
      await DISTR.bulkMint([accounts[0], accounts[1]], [5000,5000], OWNER_SIGNATURE)
      assertSupply(10000)
    })

    it('should mint 6000+4000 tokens', async() => {
      await DISTR.bulkMint([accounts[0], accounts[1]], [3000,3000], OWNER_SIGNATURE)
      await DISTR.extraMint(OWNER_SIGNATURE)
      assertSupply(10000)
    })

    it('should mint tokens for 50 accounts', async() => {
      const count = 50
      const recepeinets = []
      const amounts = []
      for(let index = 0; index < count; index++) {
        recepeinets[index] = accounts[index % accounts.length]
        amounts[index] = 1000
      }

      await DISTR.bulkMint(recepeinets, amounts, OWNER_SIGNATURE)
      assertSupply(1000 * count)
    })
  })
})