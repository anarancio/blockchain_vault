pragma solidity >=0.4.21 <0.6.0;

import "./SafeMath.sol";

/// @title Fundraising example contract.
/// @author Alejandro Narancio
/// @notice This contract will allow to make a crowd fundraising using ethers, please see the readme for the rules considered in the contract.
contract Fundraising {

    using SafeMath for uint;

    address private owner;

    uint private deadline;

    uint private minimumGoal;

    uint private accumulatedDonations;

    mapping (address => uint) donations;

    /// @notice Create the contract, initilize the fundraising attributes
    /// @param _deadline number of seconds the fundraising period will be active/open
    /// @param _minimumGoal the minimum amount of wei it must be collected in order to allow the owner to withdraw the funding
    constructor(uint _deadline, uint _minimumGoal) public {
        owner = msg.sender;
        // we will use now in order to get the block timestamp, but remember that this variable can be manipulated by the miners.
        // for our educational purpose is fine to use now
        deadline = now + _deadline;
        minimumGoal = _minimumGoal;
    }

    /// @notice Returns the total amount of donations made by a specific address.
    /// @param _donor The address we want to get the donations.
    function donationsOf(address _donor) public view returns (uint) {
        return donations[_donor];
    }

    /// @notice Returns the total accumulated donations. 
    function getAccumulatedDonations() public view returns (uint) {
        return accumulatedDonations;
    }

    /// @notice Receive a donation
    function donate() public payable {
        require(now <= deadline, "The fundraising period is closed.");
        require(msg.value > 0, "Your donation can't be 0.");
        donations[msg.sender] = donations[msg.sender].add(msg.value);
        accumulatedDonations = accumulatedDonations.add(msg.value);
    }

}