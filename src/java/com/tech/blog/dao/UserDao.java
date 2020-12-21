package com.tech.blog.dao;

import java.sql.*;
import com.tech.blog.entities.User; 

public class UserDao {
    
    private Connection con;

    
    public UserDao(Connection con) {
        this.con = con;
    }
   
    
    // Method to insert user into database
    public boolean saveUser(User user) {
        
        boolean f = false;
        
        try {
            
            String query = "insert into user(name, email, password, gender) values(?, ?, ?, ?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            
            pstmt.executeUpdate();
            f = true;
            
        } catch (Exception e) {
        
            
            
        }
        return f;
    }
    
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        
        try {
            
            String query = "select * from user where email =? and password =?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                user = new User();
                
                String name = rs.getString("name");
                
                user.setName(name);
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setDateTime(rs.getTimestamp("rdate"));
                user.setProfile(rs.getString("profile"));
                
            }
            
        } catch(Exception e) {
            
            e.printStackTrace();
            
        }
        
        return user;
    }
    
    public boolean updateUser(User user) {
        
            boolean f = false;
        
            try {
                
                String query = "update user set name =? , email=? , password=?, gender=?, profile=? where id=?";
                
                PreparedStatement p = this.con.prepareStatement(query);
                p.setString(1, user.getName());
                p.setString(2, user.getEmail());
                p.setString(3, user.getPassword());
                p.setString(4, user.getGender());
                p.setString(5, user.getProfile());
                p.setInt(6, user.getId());
                
                p.executeUpdate();
                f =  true;
                
            } catch(Exception e) {
            
                e.printStackTrace();
            
            }
            
            return f;
            
        }
    
    public User getUserById(int id) {
        User user = null;
        
        try {
            
            String q = "select * from user where id = ?";
            PreparedStatement pst = this.con.prepareStatement(q);
            pst.setInt(1, id);
            
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()) {
                user = new User();
                
                String name = rs.getString("name");
                
                user.setName(name);
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setDateTime(rs.getTimestamp("rdate"));
                user.setProfile(rs.getString("profile"));
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
    
}
