pragma solidity >=0.4.21 <0.6.0;

/// @title Fundraising example contract.
/// @author Alejandro Narancio
/// @notice This contract will allow to make a crowd fundraising using ethers, please see the readme for the rules considered in the contract.
contract Fundraising {

    address owner;

    uint deadline;

    uint minimumGoal;

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

    function donationsOf(address _donor) public view returns (uint) {
        return donations[_donor];
    }

    function donate() public payable {
        require(now <= deadline, "The fundraising period is closed.");
        require(msg.value > 0, "Your donation can't be 0.");
    }

}