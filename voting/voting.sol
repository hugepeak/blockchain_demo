pragma solidity ^0.4.24;

/// @title Voting for favorate puzzle by the puzzle index.
contract VotePuzzle {
    // Only manager can pick the winning puzzle
    address public manager;

    // A mapping to record whether a voter has voted or not
    mapping(address => bool) public voters;
    
    // A mapping to record the votes received of a puzzle
    mapping(uint => uint) public puzzles;
    
    // An array to store all unique puzzles that received votes
    uint[] public puzzlePool;

    /// Constructor.
    constructor() public {
        manager = msg.sender;
    }

    /// Give vote to puzzle
    function vote(uint puzzleIndex) public {
        require(!voters[msg.sender], "Already voted.");
        voters[msg.sender] = true;
        if (puzzles[puzzleIndex] == 0) {
            puzzlePool.push(puzzleIndex);
        }
        puzzles[puzzleIndex] += 1;
    }

    /// Computes the winning puzzle
    function winningPuzzle() public view returns (uint puzzleIndex) {
        require(msg.sender == manager, "Only manager can declare winner");
        require(puzzlePool.length > 0, "No voted puzzle yet");
        uint winningVoteCount = 0;
        for (uint i = 0; i < puzzlePool.length; i++) {
            if (puzzles[puzzlePool[i]] > winningVoteCount) {
                winningVoteCount = puzzles[puzzlePool[i]];
                puzzleIndex = puzzlePool[i];
            }
        }
    }
}

