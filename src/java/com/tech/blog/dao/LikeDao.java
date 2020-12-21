package com.tech.blog.dao;

import com.mysql.cj.jdbc.PreparedStatementWrapper;
import com.tech.blog.entities.Like;
import java.sql.*;

public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean doLike(Like like) {
        
        boolean f = false;
        
        try {
            
            String query = "insert into liketbl(post_id, user_id) values(?, ?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setInt(1, like.getPostId());
            pst.setInt(2, like.getUserId());
            
            pst.executeUpdate();
            f = true;
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
    
    public int countLikeOnPost(int postId) {
        int count = 0;
        
        try {
            
            String query = "select count(*) from liketbl where post_id = ?";
            
            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setInt(1, postId);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public boolean isLikedByUser(int postId, int userId) {
        boolean f = false;
        
        try {
            
            String query = "select * from liketbl where post_id = ? and user_id = ?";
            
            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setInt(1, postId);
            pst.setInt(2, userId);
            
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()) {
                f = true;
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
    
    public boolean undoLike(Like like) {
        
        boolean f = false;
        
        try {
            
            String query = "delete from liketbl where like_id = ?";
            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setInt(1, like.getLikeId());
            
            pst.executeUpdate();
            f = true;
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
}
