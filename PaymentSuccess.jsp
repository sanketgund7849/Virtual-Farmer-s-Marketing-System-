<%@ page import="java.sql.*" %>

<%

String orderId=request.getParameter("order_id");
String paymentMode=request.getParameter("payment_mode");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123"
);

PreparedStatement ps=con.prepareStatement(
"INSERT INTO payments(order_id,payment_date,payment_mode,payment_status) VALUES(?,CURDATE(),?,?)"
);

ps.setInt(1,Integer.parseInt(orderId));
ps.setString(2,paymentMode);
ps.setString(3,"SUCCESS");

ps.executeUpdate();

con.close();
%>

<!DOCTYPE html>
<html>
<head>
<title>Payment Success</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
text-align:center;
padding:40px;
}

.container{
background:white;
padding:30px;
width:400px;
margin:auto;
border-radius:10px;
box-shadow:0 0 10px rgba(0,0,0,0.2);
}

h2{
color:#2e7d32;
}

a{
display:inline-block;
margin-top:20px;
padding:10px 20px;
background:#0288d1;
color:white;
text-decoration:none;
border-radius:5px;
}

</style>

</head>

<body>

<div class="container">

<h2>Payment Successful </h2>

<p>Your payment has been completed successfully.</p>

<a href="vieworders.jsp">Back to Orders</a>

</div>

</body>
</html>