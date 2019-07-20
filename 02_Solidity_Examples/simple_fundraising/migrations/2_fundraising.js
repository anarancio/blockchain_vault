const Fundraising = artifacts.require("Fundraising");

module.exports = function(deployer) {
    deployer.deploy(Fundraising, 1000000, 1000000);
};
