// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VentPost {
    struct Post {
        uint256 id;
        address user;        // Người tạo bài viết
        string media;        // Media đính kèm
        string content;      // Nội dung bài viết
        uint256 timestamp;   // Thời gian tạo
        uint256 commentCount; // Số lượng bình luận
    }

    struct Comment {
        address user;        // Người tạo bình luận
        string media;        // Media đính kèm
        string content;      // Nội dung bình luận
        uint256 timestamp;   // Thời gian tạo
    }

    // Mapping người dùng -> bài viết
    mapping(address => mapping(uint256 => Post)) public posts;
    // Mapping bài viết -> danh sách bình luận
    mapping(uint256 => Comment[]) public comments;

    // Mapping để đếm số bài viết của mỗi người dùng
    mapping(address => uint256) public postCounts;

    uint256 public totalPosts; // Tổng số bài viết (ID duy nhất)

    function createPost(string memory _media, string memory _content) public {
        posts[msg.sender][postCounts[msg.sender]] = Post({
            id: totalPosts,           // Sử dụng totalPosts làm ID
            user: msg.sender,
            media: _media,
            content: _content,
            timestamp: block.timestamp,
            commentCount: 0
        });
        postCounts[msg.sender]++; // Tăng số bài viết của người dùng
        totalPosts++;             // Tăng tổng số bài viết (và ID cho bài viết tiếp theo)
    }

    // Thêm bình luận vào bài viết
    function addComment(address postOwner, uint256 postId, uint256 globalPostId, string memory _media, string memory _content) public {
        require(globalPostId < totalPosts, "Invalid post ID");
        require(postId < postCounts[postOwner], "Invalid user post ID");

        Post storage post = posts[postOwner][postId];
        comments[globalPostId].push(Comment({
            user: msg.sender,
            media: _media,
            content: _content,
            timestamp: block.timestamp
        }));

        post.commentCount++; // Tăng số lượng bình luận cho bài viết
    }

    // Lấy thông tin bài viết
    function getPost(address user, uint256 postId) public view returns (uint256, address, string memory, string memory, uint256, uint256) {
        require(postId < postCounts[user], "Invalid post ID");

        Post storage post = posts[user][postId];
        return (post.id, post.user, post.media, post.content, post.timestamp, post.commentCount);
    }

    // Lấy thông tin bình luận
    function getComment(uint256 globalPostId, uint256 commentId) public view returns (address, string memory, string memory, uint256) {
        require(globalPostId < totalPosts, "Invalid post ID");
        require(commentId < comments[globalPostId].length, "Invalid comment ID");

        Comment storage comment = comments[globalPostId][commentId];
        return (comment.user, comment.media, comment.content, comment.timestamp);
    }

    // Lấy tổng số bài viết của một người dùng
    function getPostCount(address user) public view returns (uint256) {
        return postCounts[user];
    }

    // Lấy tổng số bình luận của một bài viết
    function getCommentCount(uint256 postId) public view returns (uint256) {
        return comments[postId].length;
    }
}
