package com.tech.blog.entities;

public class Like {
    private int likeId;
    private int postId;
    private int userId;

    public Like(int likeId, int postId, int userId) {
        this.likeId = likeId;
        this.postId = postId;
        this.userId = userId;
    }

    public Like(int postId, int userId) {
        this.postId = postId;
        this.userId = userId;
    }

    public Like() {
    }

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    
}
