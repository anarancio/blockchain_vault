pragma solidity >=0.4.21 <0.6.0;

import "./SafeMath.sol";
import './Ownable.sol';

/// @title Fundraising example contract.
/// @author Alejandro Narancio
/// @notice This contract will allow to make a crowd fundraising using ethers, please see the readme for the rules considered in the contract.
contract Fundraising is Ownable {

    using SafeMath for uint;

    uint private _deadline;

    uint private _minimumGoal;

    uint private _accumulatedDonations;

    mapping (address => uint) _donations;

    /// @notice Create the contract, initilize the fundraising attributes
    /// @param deadline number of seconds the fundraising period will be active/open
    /// @param minimumGoal the minimum amount of wei it must be collected in order to allow the owner to withdraw the funding
    constructor(uint deadline, uint minimumGoal) public {
        // we will use now in order to get the block timestamp, but remember that this variable can be manipulated by the miners.
        // for our educational purpose is fine to use now
        _deadline = now + deadline;
        _minimumGoal = minimumGoal;
    }

    /// @notice Returns the total amount of donations made by a specific address.
    /// @param _donor The address we want to get the donations.
    function donationsOf(address _donor) public view returns (uint) {
        return _donations[_donor];
    }

    /// @notice Returns the total accumulated donations. 
    function accumulatedDonations() public view returns (uint) {
        return _accumulatedDonations;
    }

    /// @notice Receive a donation
    function donate() public payable {
        require(now <= _deadline, "The fundraising period is closed.");
        require(msg.value > 0, "Your donation can't be 0.");
        _donations[msg.sender] = _donations[msg.sender].add(msg.value);
        _accumulatedDonations = _accumulatedDonations.add(msg.value);
    }

    /// @notice This function will be called by the contract owner when it wants to withdraw the money collected. This only can be called after the fundraising period finished and when the minimum goal has been reached.
    function retireDonations() public onlyOwner {
        require(now > _deadline, "To retire the donations the fundraising period must expire");
        require(_accumulatedDonations >= _minimumGoal, "To retire the donations, the contract should have collected at least the minimum goal");

        // destruct the contract and send all the balance to the owner
        address payable _owner = address(uint160(owner()));
        selfdestruct(_owner);
    }

    /// @notice This function will be called by the donors of the contract. If the fundraising period ended and the minimum goal is not reached, the donors can get his money back calling this function.
    function refundDonation() public {
        require(now > _deadline, "To get a refund the fundraising period must expire");
        require(_accumulatedDonations < _minimumGoal, "To get a refund of your donation, the contract should have NOT reach the minimum goal");
        require(_donations[msg.sender] > 0, "To get a refund, you should have donated something.");

        // create a payable address of the donor
        address payable donor = address(uint160(msg.sender));
        donor.transfer(_donations[msg.sender]);
        _donations[msg.sender] = 0;
    }

}