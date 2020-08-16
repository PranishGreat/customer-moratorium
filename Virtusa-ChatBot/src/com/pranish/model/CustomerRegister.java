package com.pranish.model;

import java.io.Serializable;
//Model Class of CustomerRegister
public class CustomerRegister implements Serializable {
    private static final long serialVersionUID = 1L;
    private String username;
    private String password;
    private String email;
    private String account_no;

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getAccount() {
        return account_no;
    }
    public void setAccount(String account_no) {
        this.account_no = account_no;
    }
 
}

