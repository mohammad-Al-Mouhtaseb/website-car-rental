<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Car Rental | Contact us </title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/owl.css">
  </head>

  <body>
<%@include file="header.jsp" %>
  

    <!-- Page Content -->
    <div class="page-heading header-text">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1>Contact Us</h1>
            <span>feel free to send us a message now!</span>
          </div>
        </div>
      </div>
    </div>

    <div class="contact-information">
      <div class="container">
        <div class="row">
          <div class="col-md-4">
            <div class="contact-item">
              <i class="fa fa-phone"></i>
              <h4>Phone</h4>
              <p>Call Us :</p>
              <a href="#">+963 998133690</a>
            </div>
          </div>
          <div class="col-md-4">
            <div class="contact-item">
              <i class="fa fa-envelope"></i>
              <h4>Email</h4>
              <p>Send Email to : </p>
              <a href="#">admin.2122@aiu.com</a>
            </div>
          </div>
          <div class="col-md-4">
            <div class="contact-item">
              <i class="fa fa-map-marker"></i>
              <h4>Location</h4>
              <p>Damascus <br> Syria</p>
            </div>
          </div>
        </div>
      </div>
    </div>
 <% 
      String errors = null;
    try{
      Object submit_msg = request.getParameter("submit_msg");

      if(submit_msg != null){

    	  	String name = (String)request.getParameter("name");
            String email = (String)request.getParameter("email");
            String subject = (String)request.getParameter("subject");
            String msg = (String)request.getParameter("message");

            if ((email.equals("") || name.equals("") || subject.equals("")|| msg.equals("")))
              errors = "<span style='color: red; font-size:32;'>All Fields Are Required.</span>\n";
            else{
              
              try {
              // set the driver
            	Class.forName("com.mysql.jdbc.Driver");
              //make connection
              Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT","root","");
              // create a statement
              Statement stmt = dbConnect.createStatement();
                // make a query	
             
            	  stmt.executeUpdate("insert into contactus (`name`, `email`, `subject`,msg) values('"+name+"','"+email+"','"+subject+"','"+msg+"');");
            	  session.setAttribute("loged_in","TRUE");
                  session.setAttribute("email",email);
                  
                  stmt.close();
                  dbConnect.close();
                  
                  response.sendRedirect("contact.jsp");
            
             

            } catch (Exception e) {
              out.println(e);
            }
        }
    	  
    	  
      }
    }catch(Exception q){}
    %>
    <div class="callback-form contact-us">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="section-heading">
              <h2>Send us a <em>message</em></h2>
              <span>share your feedback with us</span>
            </div>
          </div>
          <div class="col-md-12">
            <div class="contact-form">
              <form id="contact" action="" method="get">
                <div class="row">
                  <div class="col-lg-4 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="name" type="text" class="form-control" id="name" placeholder="Full Name">
                    </fieldset>
                  </div>
                  <div class="col-lg-4 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="email" type="text" class="form-control" id="email" pattern="[^ @]*@[^ @]*" placeholder="E-Mail Address">
                    </fieldset>
                  </div>
                  <div class="col-lg-4 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="subject" type="text" class="form-control" id="subject" placeholder="Subject" >
                    </fieldset>
                  </div>
                  <div class="col-lg-12">
                    <fieldset>
                      <textarea name="message" rows="6" class="form-control" id="message" placeholder="Your Message"></textarea>
                    </fieldset>
                  </div>
                  <div class="col-lg-12">
                    <fieldset>
					<input class="button" type="submit" value="Send Massage" style="background-color: #a4c639" name="submit_msg">
                    </fieldset>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>



    
    <div class="sub-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <p>
                Copyright © 2023 PL PROJECT
               
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Additional Scripts -->
    <script src="assets/js/custom.js"></script>
    <script src="assets/js/owl.js"></script>
    <script src="assets/js/slick.js"></script>
    <script src="assets/js/accordions.js"></script>



  </body>
</html>