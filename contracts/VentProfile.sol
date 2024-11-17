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
        mapping(uint256 => address) follower;
        uint256 n_following;
        mapping(uint256 => address) following;
    }

    mapping(address => User) public users; // Mapping từ địa chỉ tới thông tin người dùng
    address[] public userAddresses; // Danh sách địa chỉ của tất cả người dùng
    VentPost public ventPost; // Contract VentPost

    // Khởi tạo contract với địa chỉ VentPost
    constructor(address _ventPostAddress) {
        ventPost = VentPost(_ventPostAddress);
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
        newUser.n_follower = 0;
        newUser.n_following = 0;

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

    // Liên kết bài viết với người dùng
    function createPostForUser(
        string memory _media,
        string memory _content
    ) public {
        require(
            bytes(users[msg.sender].name).length > 0,
            "User does not exist"
        );

        ventPost.createPost(_media, _content);
    }

    // Lấy tất cả bài viết của người dùng
    function getPostsOfUser(address user) public view returns (uint256) {
        return ventPost.getPostCount(user);
    }

    // Lấy thông tin bài viết của người dùng
    function getPostDetails(
        address user,
        uint256 postId
    )
        public
        view
        returns (address, string memory, string memory, uint256, uint256)
    {
        return ventPost.getPost(user, postId);
    }
}
