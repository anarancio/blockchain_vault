const Fundraising = artifacts.require("Fundraising");

module.exports = function(deployer) {
    deployer.deploy(Fundraising, 600000, 1000000000);
};
