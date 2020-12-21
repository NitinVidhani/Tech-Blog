/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public List<Category> getCategories() {

        ArrayList<Category> list = new ArrayList<>();

        try {

            String query = "select * from category";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {

                Category c = new Category(rs.getInt("cat_id"), rs.getString("cat_name"), rs.getString("cat_desc"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public boolean savePost(Post post) {
        boolean f = false;

        try {

            String query = "insert into post(post_title, post_content, post_code, post_pic, cid, user_id) values(?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);

            pstmt.setString(1, post.getPostTitle());
            pstmt.setString(2, post.getPostContent());
            pstmt.setString(3, post.getPostCode());
            pstmt.setString(4, post.getPostPic());
            pstmt.setInt(5, post.getCatId());
            pstmt.setInt(6, post.getUserId());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    public List<Post> getAllPosts() {

        List<Post> list = new ArrayList<Post>();

        try {

            String q = "select * from post order by post_id desc";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(q);
            while (rs.next()) {

                int id = rs.getInt("post_id");
                String postTitle = rs.getString("post_title");
                String postContent = rs.getString("post_content");
                String postCode = rs.getString("post_code");
                String postImage = rs.getString("post_pic");
                Timestamp postDate = rs.getTimestamp("post_date");
                int catId = rs.getInt("cid");
                int userId = rs.getInt("user_id");

                Post p = new Post(id, postTitle, postContent, postCode, postImage, postDate, catId, userId);
                list.add(p);
            }   
            

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }
    
    public List<Post> getPostByCatId(int cid) {
        
        List<Post> list = new ArrayList<>();
        
        try {
            
            String q = "select * from post where cid = ?";
            PreparedStatement pst = this.con.prepareStatement(q);
            pst.setInt(1, cid);
            
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                
                int id = rs.getInt("post_id");
                String postTitle = rs.getString("post_title");
                String postContent = rs.getString("post_content");
                String postCode = rs.getString("post_code");
                String postImage = rs.getString("post_pic");
                Timestamp postDate = rs.getTimestamp("post_date");
                int catId = cid;
                int userId = rs.getInt("user_id");

                Post p = new Post(id, postTitle, postContent, postCode, postImage, postDate, catId, userId);
                list.add(p);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return list;
        
    }
    
    public Post getPostById(int id) {
        
         Post post = null;
        
        try {
            
            String query = "select * from post where post_id = ?";
            
            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setInt(1, id);
            
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()) {
                
                String postTitle = rs.getString("post_title");
                String postContent = rs.getString("post_content");
                String postCode = rs.getString("post_code");
                String postImage = rs.getString("post_pic");
                Timestamp postDate = rs.getTimestamp("post_date");
                int catId = rs.getInt("cid");
                int userId = rs.getInt("user_id");
                
                
                post = new Post(id, postTitle, postContent, postCode, postImage, postDate, catId, userId);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return post;
        
    }

}
