<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap"
	rel="stylesheet">

<title>Car Rental</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Additional CSS Files -->
<link rel="stylesheet" href="assets/css/fontawesome.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/owl.css">
<style>
<!--
body {
	background-image: url('assets/images/black.jpeg');
	background-size: cover;
}

.form-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}
</style>


</head>
<body>

	<%@include file="header.jsp"%>



	<!-- header section end -->
	<!-- cars section start -->
	<div class="car_section layout_padding padding_bottom_0">
		<div class="container" style="margin-buttom: 30px">

			<%@ page import="java.sql.* , java.util.Base64"%>
			<div class="text-center form-container container py-5">
				<form style="margin-top: 300px">
					<%
					try {
						// set the driver
						Class.forName("com.mysql.jdbc.Driver");
						//make connection
						Connection dbConnect = DriverManager.getConnection("jdbc:mysql://localhost:3306/rental_car?serverTimezone=GMT",
						"root", "");
						// create a statement
						Statement stmt = dbConnect.createStatement();

						boolean is_admin = false;
						if (session.getAttribute("email") != null) {
							ResultSet rs = stmt.executeQuery("select * from user where email='" + session.getAttribute("email") + "' ;");
							rs.next();
							is_admin = rs.getBoolean("is_admin");
						}

						// make a query
						ResultSet rs = stmt.executeQuery("select * from car;");

						if (!rs.next()) {
							out.println("<div clas='text-center container py-5'><h1 style='color: #a4c639;'>No cars.</h1></div>");
						} else {
							int i = 0;
							out.println("<div class='row' style='margin-top: 30px;'>"); // added a row div to wrap the cars
							do {
						String edit_delete = "";
						if (is_admin) {
							edit_delete = " <div class='d-flex justify-content-between' style='padding:10px 20px'><a class='button' href='delete_car.jsp?id=" + rs.getInt("id")
									+ "' style='color:red;font-size:20px;padding:4px 4px;border-radius:5px; margin-right:25px;'>Delete</a> <a href='edit_car.jsp?id="
									+ rs.getInt("id")
									+ "' style='color:black;font-size:20px;padding:4px 4px;border-radius:5px; margin-right:25px;'>Edit</a></div>";
						}
						String img = Base64.getEncoder().encodeToString(rs.getBytes("image"));
						out.println(
								"<div class='col-lg-4'><div class='card'><div class='call_image bg-image hover-overlay ripple ripple-surface ripple-surface-light' style='text-align: center;'><a href='car_details.jsp?id="
										+ rs.getInt("id")
										+ "'><img style='height: 200px;border-top-left-radius: 15px; border-top-right-radius: 15px;' class='img-fluid' src='data:image/jpeg;base64,"
										+ img + "'></a></div><p>" + rs.getString("brand") + "</p><p class='dolor_text'>"
										+ rs.getInt("year") + "</p>" + edit_delete + "</div></div>");
						

						i++;
						if (i % 3 == 0) { // check if we have added 3 cars in a row
							out.println("</div>"); // close the row div since we haveadded 3 cars in a row
							out.println("<div class='row' style='margin-top: 50px;'>"); // start a new row
						}
							} while (rs.next());
							out.println("</div>"); // close the last row div
						}
						stmt.close();
						dbConnect.close();
					} catch (Exception e) {
						out.println(e);
					}
					%>
				</form>
			</div>
		</div>
	</div>

</body>
</html>