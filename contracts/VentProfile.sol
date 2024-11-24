// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VentPost.sol"; // Import contract VentPost

contract VentProfile {
    struct User {
        string name;
        string avatar;
        string bio;
        uint256 birthday; // Timestamp của ngày sinh
        uint256 jointTime; // Timestamp của ngày tham gia
        address addr;
        uint256 n_follower;
        uint256 n_following;
    }

    mapping(address => User) public users; // Mapping từ địa chỉ tới thông tin người dùng
    mapping(address => mapping(uint256 => address)) private followers; // Lưu trữ danh sách followers
    mapping(address => mapping(uint256 => address)) private followings; // Lưu trữ danh sách following
    mapping(address => uint256) public followerCount; // Số lượng followers của mỗi người dùng
    mapping(address => uint256) public followingCount; // Số lượng followings của mỗi người dùng

    address[] public userAddresses; // Danh sách địa chỉ của tất cả người dùng

    function getUser(address addr) public view returns (User memory) {
        return users[addr];
    }
    // Tạo hồ sơ người dùng mới
    function createUser(
        string memory _name,
        string memory _avatar,
        string memory _bio,
        uint256 _birthday
    ) public {
        require(
            bytes(users[msg.sender].name).length == 0,
            "User already exists"
        );

        User storage newUser = users[msg.sender];
        newUser.name = _name;
        newUser.avatar = _avatar;
        newUser.bio = _bio;
        newUser.birthday = _birthday;
        newUser.jointTime = block.timestamp; // Lấy timestamp hiện tại làm ngày tham gia
        newUser.addr = msg.sender;

        userAddresses.push(msg.sender); // Thêm địa chỉ người dùng vào danh sách
    }

    // Cập nhật hồ sơ người dùng
    function updateUser(
        string memory _name,
        string memory _avatar,
        string memory _bio,
        uint256 _birthday
    ) public {
        require(
            bytes(users[msg.sender].name).length > 0,
            "User does not exist"
        );

        User storage user = users[msg.sender];
        user.name = _name;
        user.avatar = _avatar;
        user.bio = _bio;
        user.birthday = _birthday;
    }

    // Thêm follower
    function addFollower(address userAddress, address followerAddress) public {
        require(users[userAddress].addr != address(0), "User does not exist");
        require(
            users[followerAddress].addr != address(0),
            "Follower does not exist"
        );

        uint256 index = followerCount[userAddress];
        followers[userAddress][index] = followerAddress;
        followerCount[userAddress]++;

        uint256 followingIndex = followingCount[followerAddress];
        followings[followerAddress][followingIndex] = userAddress;
        followingCount[followerAddress]++;
    }

    // Lấy follower của người dùng
    function getFollower(
        address userAddress,
        uint256 index
    ) public view returns (address) {
        return followers[userAddress][index];
    }

    // Lấy following của người dùng
    function getFollowing(
        address userAddress,
        uint256 index
    ) public view returns (address) {
        return followings[userAddress][index];
    }

    // Xóa hồ sơ người dùng
    function deleteUser() public {
        require(
            bytes(users[msg.sender].name).length > 0,
            "User does not exist"
        );

        delete users[msg.sender];

        // Xóa địa chỉ khỏi danh sách
        for (uint256 i = 0; i < userAddresses.length; i++) {
            if (userAddresses[i] == msg.sender) {
                userAddresses[i] = userAddresses[userAddresses.length - 1];
                userAddresses.pop();
                break;
            }
        }
    }
}
