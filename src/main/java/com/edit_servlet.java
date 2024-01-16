package com;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
/**
 * Servlet implementation class edit_servlet
 */
@MultipartConfig(maxFileSize = 1699999999)
@WebServlet("/edit_servlet")
public class edit_servlet extends HttpServlet {


	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		    //make connection
		    Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT","root","");
		    // create a statement
		    Statement stmt_users = dbConnect.createStatement();
		      // make a query	
			if(req.getSession().getAttribute("email") != null){
				ResultSet rs = stmt_users.executeQuery("select * from user where email='"+req.getSession().getAttribute("email")+"' ;");
				rs.next();
				System.out.println("pl");
				if (!rs.getBoolean("is_admin")){
					res.sendRedirect("index.jsp");
					
				}
			}
			else
				res.sendRedirect("login.jsp");
		
			Part image = (Part) req.getPart("image");
			InputStream in = null;
			if(req.getPart("image").getSize() != 0) {
				in = image.getInputStream();
			}
			else
				System.out.println("hi");
			try {
	            Statement stmt_image = dbConnect.createStatement();
	            ResultSet img = stmt_image.executeQuery("select image from car where id="+req.getParameter("id")+";");
	            img.next();
	            
	            
	            String query = "update car set brand=?,year=?,description=?,price_per_day=?,price_per_month=?,image=?  where id="+req.getParameter("id")+";";
	            if (in == null) { 
	            	query = "update car set brand=?,year=?,description=?,price_per_day=?,price_per_month=? where id="+req.getParameter("id")+";";
	            }
	            		
	            		
	            PreparedStatement stmt = dbConnect.prepareStatement(query);
	          
	        	stmt.setString(1, req.getParameter("brand"));
	        	stmt.setInt(2, Integer.parseInt(req.getParameter("year")));  
	            stmt.setString(3, req.getParameter("description"));
	            stmt.setInt(4, Integer.parseInt(req.getParameter("price_per_day")));   
	            stmt.setInt(5, Integer.parseInt(req.getParameter("price_per_month")));   
	            if (in != null) {
	            	stmt.setBlob(6, in);
	            }
	          
	            
	            stmt.executeUpdate();
	            String url = "cars.jsp?id="+req.getParameter("id");
	            res.sendRedirect(url);
	            
			} catch (Exception e) {System.out.println(e);}
		}catch (Exception e) {System.out.println(e); res.getWriter().println("Error, Please Fill All Fields With The Correct Value Type.");}
		
	}
}
