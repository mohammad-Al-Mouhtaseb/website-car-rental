<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html>
<html lang="en">
<head>
   

<meta charset="windows-1256">
<style>
	
   
    body {
	background-image: url('assets/images/Background.jpg');
        background-size: cover;
    }
   
	
    .form-group {
        border: 1px solid #ddd;
        padding: 10px;
        margin-bottom: 10px;
    }
    
    .email-bt {
        border: none;
        width: 100%;
        padding: 10px;
    }
    
    .main_bt {
        text-align: center;
    }
    
    .main_bt input[type="submit"] {
        background: #007bff;
        color: #fff;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
    }
    
    .main_bt input[type="submit"]:hover {
        background: #0069d9;
    }
    
    .contact_section {
        padding: 50px 0;
    }
    
    .contact_text {
        font-size: 36px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
    }
    
    .container {
        max-width: 1170px;
        margin: 0 auto;
        padding: 0 15px;
    }
    
    .row {
        display: flex;
       justify-content: center;
    }
    
    .col-md-6 {
        max-width: 500px;
        width: 100%;
    }
</style>
</head>
<body>
 
<%@include file="header.jsp" %>
    
<%@ page import="java.sql.* , java.io.InputStream, java.util.Enumeration" %>
<%
ResultSet rs_car = null;
String img = null;
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
        if (!rs.getBoolean("is_admin")){
            throw new Exception(); // the catch will redirect to index.jsp
        }
    }
    else
        throw new Exception(); // the catch will redirect to index.jsp
} catch (Exception e) {
    response.sendRedirect("index.jsp");
}
%>

<div class="contact_section layout_padding">
    <div class="container"  style="margin-top: 100px">
        <div class="row">
            <div class="col-md-6">
                <h1 class="contact_text"></h1>
                <form action="add_car_servlet" method="POST" enctype = "multipart/form-data">
                    <div class="form-group">
                        <input type="file" class="email-bt" name="image">
                    </div>
                 
                    <div class="form-group">
                        <input type="text" class="email-bt" placeholder="Brand" name="brand">
                    </div>
                    <div class="form-group">
                        <input type="number" class="email-bt" placeholder="Year" name="year">
                    </div>
                 <div class="form-group">
                        <input type="text" class="email-bt" placeholder="Description" name="description">
                    </div>
                    <div class="form-group">
                        <input type="number" class="email-bt" placeholder="Price per day" name="price_per_day">
                    </div>
                    <div class="form-group">
                        <input type="number" class="email-bt" placeholder="Price per month" name="price_per_month">
                    </div>
                    
                    <div class="main_bt">
                        <input type="submit" value="Add" style="border-radius: 20px;background-color: #a4c639">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
              
</body>
</html>