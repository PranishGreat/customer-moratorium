package com.pranish.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.pranish.model.CustomerRegister;
import com.pranish.security.AESEncryption;


public class CustomerRegisterDao {


    public int registerEmployee(CustomerRegister custreg) throws ClassNotFoundException {
        String INSERT_USERS_SQL = "insert into customer (id,username, password, email, account_no) VALUES (?,?,?,?,?);";

        int result = 0;
        
        Class.forName("com.mysql.jdbc.Driver");

        int i = 0;
		try (Connection connection = DriverManager
            .getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");
        	
          
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setInt(1, i);
            AESEncryption AES=new AESEncryption();
            final String secretKey = "Virtusa@2021#";
            String originalString = custreg.getPassword();
            String encryptedString = AES.encrypt(originalString, secretKey) ;
            preparedStatement.setString(2, custreg.getUsername());
            preparedStatement.setString(3, encryptedString);
            preparedStatement.setString(4, custreg.getEmail());
            preparedStatement.setString(5, custreg.getAccount());
            System.out.println(preparedStatement);
            result = preparedStatement.executeUpdate();

        } catch (SQLException e) {
        	System.err.println(e);
        }
        i++;
        return result;
    }
}