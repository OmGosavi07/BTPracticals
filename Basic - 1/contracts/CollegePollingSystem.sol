pragma solidity ^0.8.0;
contract CollegePollingSystem {

    // Define a struct to represent a poll
    struct Poll {
        string question;
        string[] options;
        mapping (string => uint) votes;
        bool active;
    }

    // Define a hashmap to store the polls
    mapping (uint => Poll) public polls;
    uint public numPolls;

    // Define a struct to represent a voter
    struct Voter {
        bool voted;
        uint pollIndex;
    }

    // Define a hashmap to store the voters
    mapping (address => Voter) public voters;

    // Define an event to log poll creation
    event PollCreated(uint pollIndex, string question, string[] options);

    // Define an event to log vote submission
    event VoteSubmitted(address voter, uint pollIndex, string option);

    // Create a new poll
    function createPoll(string memory question, string[] memory options) public {
        numPolls++;
        polls[numPolls].question = question;
        polls[numPolls].options = options;
        polls[numPolls].active = true;

        emit PollCreated(numPolls, question, options);
    }

    // Vote in a poll
    function vote(uint pollIndex, string memory option) public {
        // Check if poll exists and is active
        require(pollIndex <= numPolls && polls[pollIndex].active == true, "Poll does not exist or is inactive");

        // Check if voter has already voted
        require(voters[msg.sender].voted == false, "Voter has already voted");

        // Check if option is valid
        require(isOptionValid(pollIndex, option) == true, "Invalid option");

        // Record vote
        polls[pollIndex].votes[option]++;
        voters[msg.sender].voted = true;
        voters[msg.sender].pollIndex = pollIndex;

        emit VoteSubmitted(msg.sender, pollIndex, option);
    }

    // Check if an option is valid
    function isOptionValid(uint pollIndex, string memory option) public view returns (bool) {
        for (uint i = 0; i < polls[pollIndex].options.length; i++) {
            if (keccak256(bytes(polls[pollIndex].options[i])) == keccak256(bytes(option))) {
                return true;
            }
        }
        return false;
    }

    // Get the number of votes for an option
    function getVotes(uint pollIndex, string memory option) public view returns (uint) {
        require(pollIndex <= numPolls && polls[pollIndex].active == false, "Poll does not exist or is active");
        require(isOptionValid(pollIndex, option) == true, "Invalid option");

        return polls[pollIndex].votes[option];
    }
}