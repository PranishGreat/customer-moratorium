package com.pranish.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pranish.dao.CustomerRegisterDao;
import com.pranish.model.CustomerRegister;


@WebServlet("/register")
public class CustomerRegisterServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;
    private CustomerRegisterDao custRegdao;

    public void init() {
        custRegdao = new CustomerRegisterDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	PrintWriter out=response.getWriter();
   	 String username1 = request.getParameter("username");
     String password = request.getParameter("password");
     String password1=request.getParameter("password1");
     String email = request.getParameter("email");
     String account_no = request.getParameter("account_no");

     CustomerRegister custreg = new CustomerRegister();
     custreg.setUsername(username1);
     custreg.setPassword(password);
     custreg.setEmail(email);
     custreg.setAccount(account_no);
     try {
    	 Class.forName("com.mysql.jdbc.Driver");
         Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");

         PreparedStatement st = connection.prepareStatement("select * from customer where username = ?");
         st.setString(1, username1);
         ResultSet r1=st.executeQuery();

          if(r1.next()) 
          {
        	  	
        	  	out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
        		out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
        		out.println("<script>");
        		out.println("$(document).ready(function(){");
        		out.println("swal ('Username already exist','','error');");
        		out.println("});");
        		out.println("</script>");
        		RequestDispatcher rd= request.getRequestDispatcher("CustomerRegister.jsp");
    			rd.include(request, response);    			
          }
          else
          {
        	PreparedStatement st1 = connection.prepareStatement("select * from customer where email = ?");
      	  	st1.setString(1, email);
      	  	ResultSet r2=st1.executeQuery();
      	  	PreparedStatement st2 = connection.prepareStatement("select * from customer where account_no = ?");
      	  	st2.setString(1, account_no);
      	  	ResultSet r3=st2.executeQuery();
      	  	PreparedStatement st3 = connection.prepareStatement("select * from adhar where acc_no = ?");
    	  	st3.setString(1, account_no);
    	  	ResultSet r4=st3.executeQuery();
  			if(r2.next())
      	  	{
      	  		out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
          		out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
          		out.println("<script>");
          		out.println("$(document).ready(function(){");
          		out.println("swal ('Email already exist','','error');");
          		out.println("});");
          		out.println("</script>");
          		RequestDispatcher rd= request.getRequestDispatcher("CustomerRegister.jsp");
      			rd.include(request, response);
      	  	}
  			
    	  	else if(r3.next())
    	  	{
    	  		out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
        		out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
        		out.println("<script>");
        		out.println("$(document).ready(function(){");
        		out.println("swal ('Account No. already exist  ','','error');");
        		out.println("});");
        		out.println("</script>");
        		RequestDispatcher rd= request.getRequestDispatcher("CustomerRegister.jsp");
    			rd.include(request, response);
    	  	}
    	  	else if(!password.equals(password1))
    	  	{
    	  		out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
  				out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
  				out.println("<script>");
  				out.println("$(document).ready(function(){");
  				out.println("swal ('Wrong Password','','error');");
  				out.println("});");
  				out.println("</script>");
  				RequestDispatcher rd= request.getRequestDispatcher("CustomerRegister.jsp");
  				rd.include(request, response);
    	  	}
    	  	else 
    	  	{
    	  		if(r4.next()) {
    	  		out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
      			out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
      			out.println("<script>");
      			out.println("$(document).ready(function(){");
      			out.println("swal ('Submitted Successful','','success');");
      			out.println("});");
      			out.println("</script>");
      			try {
      				custRegdao.registerEmployee(custreg);		
      			} catch (ClassNotFoundException e) {
      				e.printStackTrace();
      			}
      			
      			RequestDispatcher rd= request.getRequestDispatcher("CustomerLogin.jsp");
      			rd.include(request, response);
    	  		}
    	  		else {
    	  			out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>");
            		out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>");
            		out.println("<script>");
            		out.println("$(document).ready(function(){");
            		out.println("swal ('Account No. not exist  ','','error');");
            		out.println("});");
            		out.println("</script>");
            		RequestDispatcher rd= request.getRequestDispatcher("CustomerRegister.jsp");
        			rd.include(request, response);
    	  		}
    	  	}
  		}

     }
     catch (SQLException e) 
     {
        System.out.println("SQL Exception: "+ e.toString());
     } 
     catch (ClassNotFoundException cE) 
     {
        System.out.println("Class Not Found Exception: "+ cE.toString());
     }


    }
}