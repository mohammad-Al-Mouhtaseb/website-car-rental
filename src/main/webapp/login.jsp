<!DOCTYPE html>
<html>
<head>
	<title>Login | Sign Up</title>
	<style>
		body{
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	font-family: 'Jost', sans-serif;
	/* background: linear-gradient(to bottom, #0f0c29, #302b63, #24243e); */
  background: url("assets/images/blog-image-1-940x460.jpg");
  background-repeat:no-repeat;
	background-size: cover;
}
.main{
	width: 350px;
	height: 500px;
	background: red;
	overflow: hidden;
	background: url("https://doc-08-2c-docs.googleusercontent.com/docs/securesc/68c90smiglihng9534mvqmq1946dmis5/fo0picsp1nhiucmc0l25s29respgpr4j/1631524275000/03522360960922298374/03522360960922298374/1Sx0jhdpEpnNIydS4rnN4kHSJtU1EyWka?e=view&authuser=0&nonce=gcrocepgbb17m&user=03522360960922298374&hash=tfhgbs86ka6divo3llbvp93mg4csvb38") no-repeat center/ cover;
	border-radius: 10px;
	box-shadow: 5px 20px 50px #000;
}
#chk{
	display: none;
}
.signup{
	position: relative;
	width:100%;
	height: 100%;
}
label{
	color: black;
	font-size: 2.3em;
	justify-content: center;
	display: flex;
	margin: 60px;
	font-weight: bold;
	cursor: pointer;
	transition: .5s ease-in-out;
}
input{
	width: 60%;
	height: 20px;
	background: #e0dede;
	justify-content: center;
	display: flex;
	margin: 20px auto;
	padding: 10px;
	border: none;
	outline: none;
	border-radius: 5px;
}
.button{
	width: 60%;
	height: 40px;
	margin: 10px auto;
	justify-content: center;
	display: block;
	color: #fff;
	background: #a4c639;
	font-size: 1em;
	font-weight: bold;
	margin-top: 20px;
	outline: none;
	border: none;
	border-radius: 5px;
	transition: .2s ease-in;
	cursor: pointer;
}
button:hover{
	background: #6d44b8;
}
.login{
	height: 460px;
	background: #2c2e3a;
	border-radius: 60% / 10%;
	transform: translateY(-180px);
	transition: .8s ease-in-out;
}
.login label{
	color: white;
	transform: scale(.6);
}

#chk:checked ~ .login{
	transform: translateY(-500px);
}
#chk:checked ~ .login label{
	transform: scale(1);	
}
#chk:checked ~ .signup label{
	transform: scale(.6);
}

	</style>
	<link rel="stylesheet" type="text/css" href="slide navbar style.css">
<link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
</head>
<body>
	<div class="main">  	
		<input type="checkbox" id="chk" aria-hidden="true">

			<div class="signup">
        <%@ page import="java.sql.*" %>
  <% 
      String errors = null;
    try{
      Object submit_signup = request.getParameter("submit_signup");

      if(submit_signup != null){

    	  	String name = (String)request.getParameter("name");
            String email = (String)request.getParameter("email");
            String password = (String)request.getParameter("password");
            if ((email.equals("") || name.equals("") || password.equals("")))
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
              ResultSet rs = stmt.executeQuery("select * from user where email='"+email+"';");
              if (!rs.next()){
            	  stmt.executeUpdate("insert into user (`name`, `email`, `password`,is_admin) values('"+name+"','"+email+"','"+password+"','0');");
            	  session.setAttribute("loged_in","TRUE");
                  session.setAttribute("email",email);

                  
                  stmt.close();
                  dbConnect.close();
                  
                  response.sendRedirect("index.jsp");
              }
              else{
                errors = "<span style='color: red; font-size:32;'>Email Already Used.</span>\n";
              }

            } catch (Exception e) {
              out.println(e);
            }
        }
    	  
    	  
      }
    }catch(Exception q){}
    %>

    <% 
      if (errors != null){
        out.println("<div style='display:inline-block;'>"+errors+"</div>");
      }
    %>
				<form method="post">

					<label for="chk" aria-hidden="true">Sign up</label>
					
					<input type="text" name="name" placeholder="User name">
					<input type="email" name="email" placeholder="Email">
					<input type="password" name="password" placeholder="Password">
					<input class="button" type="submit" value="Sign up" name="submit_signup">
				</form>
			</div>

			<div class="login">
        <%@ page import="java.sql.*" %>
  <% 
      String errors2 = null;
    try{
      Object submit_login = request.getParameter("submit_login");

      if(submit_login != null){

          String email = (String)request.getParameter("email");
          String password = (String)request.getParameter("password");
          if ((email.equals("") || password.equals("")))
            errors2 = "<span style='color: red; font-size:32;'>All Fields Are Required.</span>\n";
          else if(submit_login != null ){
            
            try {
            // set the driver
            Class.forName("com.mysql.jdbc.Driver");
            //make connection
            Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT","root","");
            // create a statement
            Statement stmt = dbConnect.createStatement();
              // make a query	
            ResultSet rs = stmt.executeQuery("select * from user where email='"+email+"';");
            if (!rs.next())
              errors2 = "<span style='color: red; font-size:32;'>No Account Found.</span>\n";
            else {
            if (rs.getString("password").equals(password)){
              session.setAttribute("loged_in","TRUE");
              session.setAttribute("email",email);

              session.setAttribute("u_name",rs.getString("name"));
              response.sendRedirect("index.jsp");
            }
            else{
              errors2 = "<span style='color: red; font-size:32;'>Wrong Password.</span>\n";
            }
              stmt.close();
                dbConnect.close();
              }//end of else

          } catch (Exception e) {
            out.println(e);
          }

      }
    	  
    	  
      }
    }catch(Exception q){}
    %>

    <% 
      if (errors2 != null){
    	  out.println("<div style='display:inline-block;'>"+errors2+"</div>");
      }
    %>
				<form method="post">
					<label for="chk" aria-hidden="true">Login</label>
					<input type="email" name="email" placeholder="Email">
					<input type="password" name="password" placeholder="Password">
					<input class="button" type="submit" value="Login" name="submit_login">
				</form>
			</div>
	</div>
</body>
</html>