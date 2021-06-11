const Token = artifacts.require("Token");

module.exports = async function (deployer) {
  await deployer.deploy(Token, "NFT Game", "MAD");
  let tokenInstance = await Token.deployed();
  await tokenInstance.mint(100, 200, 100000); //token id
  let unicorn = await tokenInstance.getTokenDetails(0);
  console.log(unicorn);
};
