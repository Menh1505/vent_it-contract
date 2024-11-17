// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VentPost {
    struct Post {
        address user; // Người tạo bài viết hoặc bình luận
        string media; // Media đính kèm
        string content; // Nội dung bài viết hoặc bình luận
        uint256 timestamp; // Thời gian tạo
        uint256 commentCount; // Số lượng bình luận
        mapping(uint256 => Post) comments; // Bình luận của bài viết
    }

    mapping(address => mapping(uint256 => Post)) public posts; // Mapping người dùng -> bài viết
    mapping(address => uint256) public postCounts; // Đếm số bài viết của mỗi người dùng

    // Tạo một bài viết mới
    function createPost(string memory _media, string memory _content) public {
        uint256 postId = postCounts[msg.sender]; // ID bài viết mới
        Post storage newPost = posts[msg.sender][postId]; // Tạo bài viết

        newPost.user = msg.sender;
        newPost.media = _media;
        newPost.content = _content;
        newPost.timestamp = block.timestamp;
        newPost.commentCount = 0;

        postCounts[msg.sender]++; // Tăng số lượng bài viết
    }

    // Thêm bình luận vào bài viết
    function addComment(
        address postOwner,
        uint256 postId,
        string memory _media,
        string memory _content
    ) public {
        // Kiểm tra bài viết tồn tại
        require(postId < postCounts[postOwner], "Invalid post ID");

        Post storage post = posts[postOwner][postId];
        uint256 commentId = post.commentCount; // Lấy ID bình luận mới

        // Tạo bình luận dưới dạng Post
        Post storage newComment = post.comments[commentId];
        newComment.user = msg.sender;
        newComment.media = _media;
        newComment.content = _content;
        newComment.timestamp = block.timestamp;
        newComment.commentCount = 0;

        post.commentCount++; // Tăng số lượng bình luận
    }

    // Lấy thông tin bài viết
    function getPost(
        address user,
        uint256 postId
    )
        public
        view
        returns (address, string memory, string memory, uint256, uint256)
    {
        require(postId < postCounts[user], "Invalid post ID");

        Post storage post = posts[user][postId];
        return (
            post.user,
            post.media,
            post.content,
            post.timestamp,
            post.commentCount
        );
    }

    // Lấy thông tin bình luận
    function getComment(
        address postOwner,
        uint256 postId,
        uint256 commentId
    ) public view returns (address, string memory, string memory, uint256) {
        require(postId < postCounts[postOwner], "Invalid post ID");

        Post storage post = posts[postOwner][postId];
        require(commentId < post.commentCount, "Invalid comment ID");

        Post storage comment = post.comments[commentId];
        return (
            comment.user,
            comment.media,
            comment.content,
            comment.timestamp
        );
    }

    // Lấy tổng số bài viết của một người dùng
    function getPostCount(address user) public view returns (uint256) {
        return postCounts[user];
    }
}
