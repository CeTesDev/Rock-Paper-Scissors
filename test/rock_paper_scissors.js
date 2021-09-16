const RockPaperScissors = artifacts.require("RockPaperScissors");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("RockPaperScissors", function (accounts) {
  let instance;

  before(async function() {
    instance = await RockPaperScissors.new({value: web3.utils.toWei("1", "ether")})
  });

  it("should balance is charged when it is deployed", async function () {
    let balance = await web3.eth.getBalance(instance);
    expect(balance).to.be.bignumber.equal(new BigInt(web3.utils.toWei("1", "ether")))
  });

  it("should balance is charged when it is deployed", async function () {
    // const instance = await RockPaperScissors.deployed();
    
    let beterBalance = await web3.eth.getBalance(accounts[1]);
    let orineBalance = await web3.eth.getBalance(instance);

    let betAmount = 5;
    const result = await instance.play(0, {from:accounts[1], value: betAmount});
    expect(result.receipt.status).to.be.equal(true)
    const gameR = result.logs[0].args["result"]
    if (gameR === 0)

    let balance = await web3.eth.getBalance(instance);
    let refundBalance = await web3.eth.getBalance(instance);
    return assert.isTrue(true);
  });

});
