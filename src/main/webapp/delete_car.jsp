<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<title>Delete Car</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
try {
    // set the driver
    Class.forName("com.mysql.jdbc.Driver");
    //make connection
    Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT","root","");
    // create a statement
    Statement stmt = dbConnect.createStatement();
      // make a query	
    if(session.getAttribute("email") != null){
		ResultSet rs = stmt.executeQuery("select * from user where email='"+session.getAttribute("email")+"' ;");
		rs.next();
		if (rs.getBoolean("is_admin")){
			stmt.executeUpdate("delete from car where id='"+request.getParameter("id")+"';");
			response.sendRedirect("cars.jsp");
		}
		else
			response.sendRedirect("index.jsp");
	}
    else
    	response.sendRedirect("login.jsp");
    

  } catch (Exception e) {
    out.println(e);
  }
%>
</body>
</html>