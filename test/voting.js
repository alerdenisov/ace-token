const expectThrow = require('./utils').expectThrow
const AceToken = artifacts.require('./AceToken.sol')
const SimpleAceVoting = artifacts.require('./SimpleAceVoting.sol')

let ACE
let VOT

contract('SimpleAceVoting', accounts => {
    // function signature(index) {
    //     return { from: accounts[index] }
    // }

    // beforeEach(async() => {
    //     ACE = await AceToken.new(signature(0));
    //     VOT = await SimpleAceVoting.new(ACE.address, signature(1));

    //     await ACE.mintFor(accounts[4], 10000, signature(0))
    //     await ACE.mintFor(accounts[5],  2000, signature(0))
    //     await ACE.finishMinting(signature(0))
    //     await ACE.toggleTransfer(signature(0))
    // })

    // it('should throw then approved amount is less when required', async() => {
    //     await ACE.approve(accounts[1], 100, signature(4))
    //     await VOT.voteFor(accounts[5], 1000, signature(4))
    // })

    // it('less then required', async() => {
    //     await ACE.approve(accounts[1], 1000, signature(4))
    //     await VOT.voteFor(accounts[5], 100, signature(4))

    //     const allowed = await ACE.allowance(accounts[4], accounts[1])
    //     assert.match(allowed.equals(900), 'Expect 900 tokens')
    // })
})