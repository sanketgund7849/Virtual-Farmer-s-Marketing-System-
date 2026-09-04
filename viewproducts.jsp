<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Connection.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Products</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{
background:url('https://images.unsplash.com/photo-1500382017468-9049fed747ef') no-repeat center center/cover;
min-height:100vh;
padding:40px;
}

.overlay{
background:rgba(0,0,0,0.6);
padding:40px;
border-radius:10px;
}

h2{
text-align:center;
color:white;
margin-bottom:25px;
}

table{
width:95%;
margin:auto;
border-collapse:collapse;
background:white;
border-radius:10px;
overflow:hidden;
box-shadow:0 8px 25px rgba(0,0,0,0.4);
}

th, td{
padding:12px;
border-bottom:1px solid #ddd;
text-align:center;
}

th{
background:#2e7d32;
color:white;
}

tr:hover{
background:#f5f5f5;
}

input[type="number"]{
width:70px;
padding:6px;
border-radius:5px;
border:1px solid #ccc;
}

button{
padding:8px 14px;
background:#ff9800;
color:white;
border:none;
border-radius:6px;
cursor:pointer;
font-weight:600;
}

button:hover{
background:#e68900;
}

.back-btn{
display:inline-block;
margin-top:25px;
padding:12px 25px;
background:#2e7d32;
color:white;
text-decoration:none;
border-radius:6px;
font-weight:bold;
}

.back-btn:hover{
background:#1b5e20;
}

</style>

</head>
<body>

<div class="overlay">

<h2>🛒 All Available Products</h2>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Type</th>
<th>Price</th>
<th>Available Qty</th>
<th>Action</th>
</tr>

<%
try{
Connection con = DBConnection.getConnection();

String sql = "SELECT product_id, product_name, product_type, price, quantity FROM products WHERE status='AVAILABLE'";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

boolean hasProducts = false;

while(rs.next()){
    hasProducts = true;
%>

<tr>
<td><%= rs.getInt("product_id") %></td>
<td><%= rs.getString("product_name") %></td>
<td><%= rs.getString("product_type") %></td>
<td>&#8377; <%= rs.getDouble("price") %></td>
<td><%= rs.getInt("quantity") %></td>
<td>

<form action="AddToCartServlet" method="post">

<input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>">

<input type="number" name="quantity" value="1" min="1" max="<%= rs.getInt("quantity") %>">

<br><br>

<button type="submit">Add to Cart</button>

</form>

</td>
</tr>

<%
}

if(!hasProducts){
%>

<tr>
<td colspan="6">No Products Available</td>
</tr>

<%
}

con.close();
}catch(Exception e){
%>

<tr>
<td colspan="6">Error: <%= e.getMessage() %></td>
</tr>

<%
}
%>

</table>

<div style="text-align:center;">
<a href="customerdashboard.html" class="back-btn">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>