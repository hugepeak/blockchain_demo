pragma solidity ^0.4.24;

/// @title Customer referral campaign
contract Referral {
    // Address of the manager who can create and withdraw from this contract
    address public manager;
    
    // Prize pool amount is from the constructor
    uint public prizePool;
    
    // Ticket price is in Wei
    uint public ticketPrice = 10;
    
    // Total count of tickets purchased
    uint public totalCount;
    
    // If this referral campaign is completed or not
    bool public completed;
    
    // Referrer address and corresponding count
    mapping(address => uint) public referrers;
    
    // Array to store all referrers
    address[] public referrerAddresses;
    
    uint time;
    
    /// Create a new referral campaign
    constructor() public payable {
        manager = msg.sender;
        prizePool = msg.value;
        totalCount = 0;
        completed = false;
        time = now;
    }
    
    /// Purchase tickets with referral
    function purchase(address referrerAddress, uint ticketNumber) public 
        payable {
        require(
            msg.value == ticketPrice * ticketNumber, 
            "Not exact money for the tickets"
        );
        if (referrers[referrerAddress] == 0) {
            referrerAddresses.push(referrerAddress);
        }
        referrers[referrerAddress] += ticketNumber;
        totalCount += ticketNumber;
    }
    
    /// Distribute the prize pool and collect the balance by the manager
    function withdraw() public {
        require(msg.sender == manager, "Only manager can withdraw money");
        require(totalCount > 0, "No referrers yet");
        require(!completed, "Pool money already withdrawn");
        uint unitPrize = prizePool / totalCount;
        for (uint i = 0; i < referrerAddresses.length; i++) {
            referrerAddresses[i].transfer(
                unitPrize * referrers[referrerAddresses[i]]
            );
        }
        manager.transfer(address(this).balance);
        completed = true;
    }
    
    /// Get summary of balance, referrer numbers and creation time
    function getSummary() public view returns (
        uint, uint, uint) {
        return (
            address(this).balance,
            referrerAddresses.length,
            time
        );
    }
}
