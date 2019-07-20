pragma solidity >=0.4.21 <0.6.0;

/// @title Fundraising example contract. 
/// @author Alejandro Narancio
/// @notice This contract will allow to make a crowd fundraising using ethers, please see the readme for the rules considered in the contract.
contract Fundraising {

    address owner;

    uint deadline;

    uint minimumGoal;

    
    /// @notice Create the contract, initilize the fundraising attributes
    /// @param _deadline number of seconds the fundraising period will be active/open
    /// @param _minimumGoal the minimum amount of wei it must be collected in order to allow the owner to withdraw the funding
    constructor(uint _deadline, uint _minimumGoal) public {
        owner = msg.sender;
        deadline = _deadline;
        minimumGoal = _minimumGoal;
    }

}