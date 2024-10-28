// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageContract {
    // Cấu trúc để lưu trữ một tin nhắn
    struct Message {
        address sender; // Địa chỉ ví gửi
        string content; // Nội dung tin nhắn
        uint256 timestamp; // Thời gian gửi
    }

    mapping(address => Message[]) private messages;

    mapping(address => Message[]) private sentMessages;

    event MessageSent(address indexed sender, address indexed recipient, string content);

    function sendMessage(address recipient, string calldata content) external {
        require(recipient != address(0), "Recipient address cannot be zero");
        require(bytes(content).length > 0, "Message content cannot be empty");

        Message memory newMessage = Message({
            sender: msg.sender,
            content: content,
            timestamp: block.timestamp
        });

        messages[recipient].push(newMessage);

        sentMessages[msg.sender].push(newMessage);

        emit MessageSent(msg.sender, recipient, content);
    }

    function getMessages(address recipient) external view returns (address[] memory senders, string[] memory contents, uint256[] memory timestamps) {
    uint256 messageCount = messages[recipient].length;
    senders = new address[](messageCount);
    contents = new string[](messageCount);
    timestamps = new uint256[](messageCount);

    for (uint256 i = 0; i < messageCount; i++) {
        Message storage message = messages[recipient][i];
        senders[i] = message.sender;
        contents[i] = message.content;
        timestamps[i] = message.timestamp;
        }
    }

    function getSentMessages() external view returns (Message[] memory) {
        return sentMessages[msg.sender];
    }
}
