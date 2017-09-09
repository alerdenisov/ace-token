const expectThrow = require('./utils').expectThrow
const AceToken = artifacts.require('./AceToken.sol')
const SimpleAceVoting = artifacts.require('./SimpleAceVoting.sol')

let ACE
let VOT

describe('Communication with token', () => {
    function signature(index) {
        return accounts[index]
    }

    beforeEach(async() => {
        ACE = await AceToken.deployed(); //new(signature(0))
        console.log(ACE.address)
        VOT = await SimpleAceVoting.deployed();
        console.log(VOT.address);
    })

    it('both should be deployed', async() => {
        assert.fail();
        // assert.strictEqual(ACE.address, 0)
    })
})