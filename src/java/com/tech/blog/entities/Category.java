/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.entities;

/**
 *
 * @author HP
 */
public class Category {
    
    private int catId;
    private String catName;
    private String catDesc;

    public Category() {
    }

    public Category(int catId, String catName, String catDesc) {
        this.catId = catId;
        this.catName = catName;
        this.catDesc = catDesc;
    }

    public Category(String catName, String catDesc) {
        this.catName = catName;
        this.catDesc = catDesc;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getCatDesc() {
        return catDesc;
    }

    public void setCatDesc(String catDesc) {
        this.catDesc = catDesc;
    }
    
        
}
