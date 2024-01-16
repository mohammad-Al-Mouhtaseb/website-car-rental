<%@ page language="java" contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="windows-1256">
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    
<script type="text/javascript" src="assets/js/lang.js"></script>
<script>

  function submit_from_select(form_id){
  	document.getElementById(form_id).submit();
  }
  
  </script>
</head>
<body>


   
      <nav class="navbar navbar-expand-lg"  style="background-color: black">
        <div class="container">
        
   <a class="navbar-brand" href="index.jsp">
					<h2 >Rental Car</h2>

				</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home
                  <span class="sr-only">(current)</span>
                </a>
              </li>
              
              
              
              <% if(session.getAttribute("email")!=null)
            	  	out.print("<li class='nav-item'> <a class='nav-link' href='cars.jsp'>Cars</a> </li>");
              	
              else{
            	  out.print("<li class='nav-item'><a class='nav-link' href='index.jsp'>About Us</a></li><li class='nav-item'><a class='nav-link' href='contact.jsp'>Contact Us</a></li>");
              }
              
              %>
              
              
             <li class="nav-item dropdown">    
             <a class="dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Language</a>
 <div>
<% 
    boolean lang = false; // false -> english (default) ,    true -> arabic
  	if(request.getParameter("language-picker-select") != null)
  		if(request.getParameter("language-picker-select").equals("arabic")){
  			response.addCookie(new Cookie("language","arabic"));
  			lang = true;
  		}
  		else
  			response.addCookie(new Cookie("language","english"));
  	else {
    	Cookie[] cookies = request.getCookies();
    	for(Cookie cookie : cookies){
    		if (cookie.getName().equals("language"))
    			if(cookie.getValue().equals("arabic"))
    				lang = true;
    	}
    }
    %>
    <div class="dropdown-menu">
	<div class="js">
  <div class="language-picker js-language-picker" data-trigger-class="btn btn--subtle">
  <form action="" id="lang_form" class="language-picker__form" method="post">  
    <select name="language-picker-select" id="language-picker-select" onchange="submit_from_select('lang_form')">
      <option lang="ar" value="arabic" <% if (lang) out.println("selected"); %>>Arabic</option>
      <option lang="en" value="english" <% if (!lang) out.println("selected"); %>>English</option>
    </select>
  </form>
</div></div>
	
</div></div>
 </li>
  
                <li class="nav-item active">
               <% if (session.getAttribute("email") != null)
               		out.println("<a class='nav-link' >"+session.getAttribute("u_name")+"</a>");
                  else
					out.println("<a class='nav-link' href='login.jsp' >LOGIN</a>"); 
               %>
                
              </li>
              <%@ page import="java.sql.* , java.util.Base64" %>
              <% if (session.getAttribute("email") != null){
               		out.println("<li class='nav-item active'> <a class='nav-link' style='color:white;' href='logout.jsp' >LOGOUT</a></li>");
              }
              try {
            	    // set the driver
            	    Class.forName("com.mysql.jdbc.Driver");
            	    //make connection
            	    Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT","root","");
            	    // create a statement
            	    Statement stmt = dbConnect.createStatement();
            	    
            	    boolean is_admin = false;
            		if(session.getAttribute("email") != null){
            			ResultSet rs = stmt.executeQuery("select * from user where email='"+session.getAttribute("email")+"' ;");
            			rs.next();
            			is_admin = rs.getBoolean("is_admin");
            		}
            		if(is_admin)
                	  	out.println("<li class='nav-item active'> <a class='nav-link' style='color:white;' href='add_car.jsp' >Add Car</a></li>");

              }catch(Exception q){
            	  System.out.println(q);
              }              		
              %>
               
            </ul>
          </div>
        </div>
      </nav>
     
                 
            
        
   
	
</body>
</html>