// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define a contract named SimpleMessaging
contract SimpleMessaging {
    // Define a Message struct with id, sender, and content fields
    struct Message {
        uint id;         // Unique identifier for the message
        address sender;  // Ethereum address of the message sender
        string content;  // Content of the message
    }

    // Array to store messages
    Message[] private messages;
    // Mapping from message ID to the owner's address
    mapping(uint => address) private messageToOwner;

    // Events to notify about changes in the contract state
    event MessageCreated(uint id, address sender, string content);
    event MessageUpdated(uint id, string oldContent, string newContent);
    event MessageDeleted(uint id);

    // Function to create a new message
    function createMessage(string memory _content) public {
        // Add the new message to the array
        messages.push(Message(messages.length, msg.sender, _content));
        // Map the message's ID to the sender's address
        messageToOwner[messages.length - 1] = msg.sender;
        // Emit an event for the message creation
        emit MessageCreated(messages.length - 1, msg.sender, _content);
    }

    // Function to read a message by its ID
    function readMessage(uint _id) public view returns (uint, address, string memory) {
        // Ensure the message exists
        require(_id < messages.length, "Message does not exist.");
        // Retrieve the message
        Message storage message = messages[_id];
        // Return the message details
        return (message.id, message.sender, message.content);
    }

    // Function to update a message by its ID
    function updateMessage(uint _id, string memory _newContent) public {
        // Check if the message exists and the sender owns the message
        require(_id < messages.length, "Message does not exist.");
        require(msg.sender == messageToOwner[_id], "Only the sender can update the message.");
        // Save the old content, update the message, and emit an event
        string memory oldContent = messages[_id].content;
        messages[_id].content = _newContent;
        emit MessageUpdated(_id, oldContent, _newContent);
    }

    // Function to delete a message by its ID
    function deleteMessage(uint _id) public {
        // Check if the message exists and the sender owns the message
        require(_id < messages.length, "Message does not exist.");
        require(msg.sender == messageToOwner[_id], "Only the sender can delete the message.");
        // Delete the message and emit an event
        delete messages[_id];
        emit MessageDeleted(_id);
    }

    // Function to get the total number of messages
    function getTotalMessages() public view returns (uint) {
        // Return the length of the messages array
        return messages.length;
    }
}
// this is the end 