<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

      <link rel="stylesheet" href="css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" href="css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <!-- owl stylesheets --> 
      <link rel="stylesheet" href="css/owl.carousel.min.css">
      <link rel="stylesheet" href="css/owl.theme.default.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">


 <%@ page import="java.sql.* , java.util.Base64" %>
              <% 
             
	      	  String brand = "";
	      	  String description = "";
	      	  int price_per_day = -1;
	      	  int year = -1;
	      	  int price_per_month = -1;
			  String img = "";
	      	  
              if (request.getParameter("id") != null){
              try {
            	    // set the driver
            	    Class.forName("com.mysql.jdbc.Driver");
            	    //make connection
            	    Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT","root","");
            	    // create a statement
            	    Statement stmt = dbConnect.createStatement();
            	    
            		ResultSet rs = stmt.executeQuery("select * from car where id='"+request.getParameter("id")+"' ;");
            		if (!rs.next())
            			out.println("<h1>car Not Found</h1>");
            		else{
            			brand = rs.getString("brand");
            			year = rs.getInt("year");
            			description = rs.getString("description");
            			price_per_day = rs.getInt("price_per_day");
            			price_per_month = rs.getInt("price_per_month");
            			img = "data:image/jpeg;base64,"+Base64.getEncoder().encodeToString(rs.getBytes("image"));
            		}
            		
              }catch(Exception q){} 
              finally{}
              }             		
              %>
             	<style>
    body {
	background-image: url('assets/images/black.jpeg');
        background-size: cover;
    }
 
	</style>
<title><% out.println(brand); %></title>
</head>
<body>

<%@include file="header.jsp"%>

		
  <section id="cars" class="cars section-bg">
            <div class="container">
               <div class="row justify-content-center">
                  <div class="card">
                     <% if(!img.equals("")) { %>
                     <img class="img-fluid" src="<%= img %>" alt="">
                     <% } %>
                     <div class="d-flex justify-content-between">
                        <p>Model <%= brand %></p>
                         <p class="year"> Year <%= year %></p>
                        </div>
                      <hr class="my-0" />
                       
                        <div class="_p-features">
                           <% if(!description.equals("")) { %>
                           <p><%= description %></p>
                           <% } %>
                        </div>
                         <hr class="my-0" />
                        
                        <div class="_p-price-box">
                           <% if(price_per_day > 0) { %>
                           <div class="_p-features">
                              <p class="price_per_day">$ <%= price_per_day %> per day</p>
                           </div>
                                                 <hr class="my-0" />
                           
                           <% } %>
                           <% if(price_per_month > 0) { %>
                           <div class="_p-features">
                              <p class="price_per_month">$ <%= price_per_month %> per month</p>
                           </div>
                           <%} %>
                        </div>
                     </div>
                    
                  </div>
               </div>
         </section>
       
</body>
</html>