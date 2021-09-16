const RockPaperScissors = artifacts.require("RockPaperScissors");

module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(RockPaperScissors);
};
