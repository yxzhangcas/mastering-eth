var METoken = artifacts.require("./METoken.sol");
module.exports = function(deployer) {
    deployer.deploy(METoken);
};