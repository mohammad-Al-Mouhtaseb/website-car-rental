package com;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
/**
 * Servlet implementation class add_car_servlet
 */
@MultipartConfig(maxFileSize = 1699999999)
@WebServlet("/add_car_servlet")
public class add_car_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    try {
	      Class.forName("com.mysql.jdbc.Driver");
	      // make connection
	      Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT",
	          "root", "");
	      // create a statement
	      Statement stmt_user = dbConnect.createStatement();
	      // make a query
	      if (req.getSession().getAttribute("email") != null) {
	        ResultSet rs = stmt_user
	            .executeQuery("select * from user where email='" + req.getSession().getAttribute("email") + "' ;");
	        rs.next();
	        if (!rs.getBoolean("is_admin")) {
	          res.sendRedirect("index.jsp");
	        }
	      } else
	        res.sendRedirect("login.jsp");

	      Part image = req.getPart("image");
	      String brand = req.getParameter("brand");
	      int year = Integer.parseInt(req.getParameter("year"));
	      String description = req.getParameter("description");
	      int price_per_day = Integer.parseInt(req.getParameter("price_per_day"));
	      int price_per_month = Integer.parseInt(req.getParameter("price_per_month"));

	      InputStream in = null;
	      if (image != null) {
	        image.getSize();
	        image.getContentType();
	        in = image.getInputStream();
	      }

	      try {
	        PreparedStatement stmt = dbConnect
	            .prepareStatement("insert into car(image,brand,year,description,price_per_day,price_per_month) values(?,?,?,?,?,?);");
	        stmt.setBlob(1, in);
	        stmt.setString(2, brand);
	        stmt.setInt(3, year);
	        stmt.setString(4, description);
	        stmt.setInt(5, price_per_day);
	        stmt.setInt(6, price_per_month);

	        stmt.executeUpdate();

	        res.sendRedirect("add_car.jsp");

	      } catch (Exception e) {
	        System.out.println(e);
	      }

	    } catch (Exception e) {
	      System.out.println(e);
	      res.getWriter().println("Error, Please Fill All Fields With The Correct Value Type.");
	    }
	  }


}
