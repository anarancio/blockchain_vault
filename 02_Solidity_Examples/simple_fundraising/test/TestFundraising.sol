pragma solidity ^0.5.8;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Fundraising.sol";

contract TestFundraising {

    uint public initialBalance = 1 ether;

    function testDonationsOfInitial () public {
        Fundraising c = Fundraising(DeployedAddresses.Fundraising());
        Assert.equal(c.donationsOf(msg.sender), 0, "All the initial donations must be 0");
    }

    function testDonate () public {
        Fundraising c = Fundraising(DeployedAddresses.Fundraising());
        uint actualDonations = c.donationsOf(address(this));
        uint amountToDonate = 1000;
        uint contractBalance = address(c).balance;
        
        c.donate.value(amountToDonate)();
        uint newDonationsBalance = c.donationsOf(address(this));
        uint newContractBalance = address(c).balance;

        uint expectedDonationsBalance = actualDonations + amountToDonate;
        uint expectedContractBalance = contractBalance + amountToDonate;

        Assert.equal(newDonationsBalance, expectedDonationsBalance, "After a donation the donation balance should be increased");
        Assert.equal(newContractBalance, expectedContractBalance, "After a donation the contract balance should be increased");
    }

}