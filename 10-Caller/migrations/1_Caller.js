var Caller = artifacts.require("Caller");
var CalledLibrary = artifacts.require("CalledLibrary");
var CalledContract = artifacts.require("CalledContract");
module.exports = function(deployer) {
    deployer.deploy(CalledContract);
    deployer.deploy(CalledLibrary);
    deployer.link(CalledLibrary, Caller);
    deployer.deploy(Caller);
};