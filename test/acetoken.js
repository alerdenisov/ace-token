const expectThrow = require('./utils').expectThrow
const AceToken = artifacts.require("./AceToken.sol");

let ACE

contract('AceToken', accounts => {
    const OWNER_SIGNATURE = { from: accounts[0] }

    beforeEach(async() => {
        ACE = await AceToken.new(OWNER_SIGNATURE)
    })

    describe('Ownership', () => {
        it('should have a owner', async() => {
            const owner = await ACE.owner()
            assert.strictEqual(owner, accounts[0])
        })
        it('should transfer owner when it needed', async() => { 
            await ACE.transferOwnership(accounts[1], OWNER_SIGNATURE)
            assert.strictEqual(await ACE.owner.call(), accounts[1])
        })

        it('should throw then not owner try to transfer ownership', async() => {
            return expectThrow(ACE.transferOwnership(accounts[2], { from: accounts[1] }))
        })
    })    

    describe('Emission Tests', () => {
        const assertSupply = async (expect, msg) => {
            const supply = await ACE.totalSupply()
            if(msg) {
                assert(supply.equals(expect), msg)
            } else {
                assert(supply.equals(expect), `amount of supply isnt expected! (current is ${supply} but expected is ${expect})`)
            }
        }

        it('should starts with zero supply', async() => {
            return assertSupply(0, 'supply isnt zero')
        })

        it('should create extra 2 tokens for each 3 tokens', async() => {
            await ACE.emitFor(accounts[1], 3, OWNER_SIGNATURE)
            await assertSupply(3+2) // 3 token allocated for account1 and few extra for a team and bounty
        })

        it('should create extra tokens only for each 3 tokens', async() => {
            await ACE.emitFor(accounts[1], 7, OWNER_SIGNATURE)
            await assertSupply(7+4)
        })

        it('should allocate huge amount', async() => {
            await ACE.emitFor(accounts[2], 60000000, OWNER_SIGNATURE)
            await assertSupply(100000000)
        })

        it('prevent to emit more than hard cap', async() => {
            await ACE.emitFor(accounts[3], await ACE.MAXSOLD_SUPPLY(), OWNER_SIGNATURE)
            await expectThrow(ACE.emitFor(accounts[2], 3, OWNER_SIGNATURE))
            await assertSupply(await ACE.HARDCAPPED_SUPPLY())
        })
    })

    describe('Token Manipulations', () => {
        async function assertBalance(account, expect) {
            const balance = await ACE.balanceOf.call(account)
            assert(balance.equals(expect), `${account} balance isn't expected (current is ${balance}, but expected is ${expect}`)
        }

        beforeEach(async() => {
            await ACE.emitFor(accounts[1], 10000, OWNER_SIGNATURE)
            await ACE.emitFor(accounts[2],  2000, OWNER_SIGNATURE)

            await assertBalance(accounts[1], 10000)
            await assertBalance(accounts[2], 2000)
        })

        describe('Transfers', () => {
            it('should throw on transfer', async() => {
                return expectThrow(ACE.transfer(accounts[2], 1000, { from: accounts[1] }))
            })

            it('should throw on transfer also on owner', async() => {
                return expectThrow(ACE.transfer(accounts[1], 1000, OWNER_SIGNATURE))
            })

            it('should allow to transfer funds', async() => {
                await ACE.toggleTransfer(OWNER_SIGNATURE)
                return ACE.transfer(accounts[1], 1000, OWNER_SIGNATURE)
            })

            it('should allow transfer for special account', async() => {
                await ACE.toggleTransferFor(accounts[1], OWNER_SIGNATURE)
                await ACE.transfer(accounts[2], 5000, { from: accounts[1] })
                await assertBalance(accounts[1], 5000)
                await assertBalance(accounts[2], 7000)
            })

            it('should close transfer for special account', async() => {
                await ACE.toggleTransferFor(accounts[1], OWNER_SIGNATURE)
                await ACE.transfer(accounts[2], 5000, { from: accounts[1] })
                await assertBalance(accounts[1], 5000)
                await assertBalance(accounts[2], 7000)

                await ACE.toggleTransferFor(accounts[1], OWNER_SIGNATURE)
                await expectThrow(ACE.transfer(accounts[2], 5000, { from: accounts[1] }))
                await assertBalance(accounts[1], 5000)
                await assertBalance(accounts[2], 7000)
            })
        })

        describe('Allowance', () => {
            it('should prevent transfer allowed tokens', async() => {
                await ACE.approve(accounts[2], 5000, { from: accounts[1] })
                await expectThrow(ACE.transferFrom(accounts[1], accounts[2], 5000, { from: accounts[2] }),
                                  'transfer should throw exception before transfer open')
                await assertBalance(accounts[1], 10000)
                await assertBalance(accounts[2], 2000)
            })

            it('should transfer tokens as always', async() => {
                await ACE.approve(accounts[2], 5000, { from: accounts[1] })
                await ACE.toggleTransfer(OWNER_SIGNATURE)
                await ACE.transferFrom(accounts[1], accounts[2], 5000, { from: accounts[2] })
                await assertBalance(accounts[1], 5000)
                await assertBalance(accounts[2], 7000)
            })
        })
    })
})