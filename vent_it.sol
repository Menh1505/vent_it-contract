// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageContract {
    // Cấu trúc để lưu trữ một tin nhắn
    struct Message {
        address sender; // Địa chỉ ví gửi
        string content; // Nội dung tin nhắn
        uint256 timestamp; // Thời gian gửi
    }

    // Mapping để lưu trữ danh sách tin nhắn cho mỗi địa chỉ ví nhận
    mapping(address => Message[]) private messages;

    // Sự kiện để thông báo khi một tin nhắn mới được gửi
    event MessageSent(address indexed sender, address indexed recipient, string content);

    // Hàm gửi tin nhắn
    function sendMessage(address recipient, string calldata content) external {
        require(recipient != address(0), "Recipient address cannot be zero");
        require(bytes(content).length > 0, "Message content cannot be empty");

        // Tạo một tin nhắn mới
        Message memory newMessage = Message({
            sender: msg.sender,
            content: content,
            timestamp: block.timestamp
        });

        // Lưu tin nhắn vào mapping
        messages[recipient].push(newMessage);

        // Phát sự kiện
        emit MessageSent(msg.sender, recipient, content);
    }

    // Các thư viện như ethers.js hoặc web3.js có thể gặp khó khăn trong việc giải mã mảng các cấu trúc, đặc biệt khi chúng chứa chuỗi (string).
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
}
