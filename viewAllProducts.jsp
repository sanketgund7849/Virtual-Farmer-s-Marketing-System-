<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Products</title>

<style>

body{
    font-family: Arial, sans-serif;
    margin:0;
    padding:20px;

    /* Vegetable Market Background */
    background-image:url("https://images.unsplash.com/photo-1542838132-92c53300491e");
    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;
}

/* Dark overlay */
.overlay{
    background:rgba(0,0,0,0.6);
    min-height:100vh;
    padding:20px;
}

h2{
    text-align:center;
    color:white;
    margin-bottom:25px;
    font-size:30px;
}

table{
    border-collapse: collapse;
    width:85%;
    margin:auto;
    background:rgba(255,255,255,0.95);
    box-shadow:0 6px 20px rgba(0,0,0,0.3);
    border-radius:8px;
    overflow:hidden;
}

th, td{
    border:1px solid #ddd;
    padding:12px;
    text-align:center;
}

th{
    background:#2e7d32;
    color:white;
    font-size:16px;
}

tr:hover{
    background:#f1f1f1;
}

input[type=number]{
    width:60px;
    padding:5px;
}

/* Add to cart button */
button{
    padding:7px 14px;
    border:none;
    border-radius:5px;
    cursor:pointer;
    background:#ff9800;
    color:white;
    font-weight:bold;
}

button:hover{
    background:#e68900;
}

/* Dashboard button */
.back-btn{
    background:#0288d1;
    margin-top:25px;
    padding:10px 20px;
}

.back-btn:hover{
    background:#01579b;
}

</style>
</head>

<body>

<div class="overlay">

<h2>Fresh Products From Farmers Market</h2>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Type</th>
<th>Price</th>
<th>Quantity</th>
<th>Action</th>
</tr>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/farmers_market0777",
    "root",
    "admin123"
);

String sql = "SELECT product_id, product_name, product_type, price, quantity FROM products WHERE status='AVAILABLE'";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%= rs.getInt("product_id") %></td>
<td><%= rs.getString("product_name") %></td>
<td><%= rs.getString("product_type") %></td>
<td>₹ <%= rs.getDouble("price") %></td>
<td><%= rs.getInt("quantity") %></td>

<td>
<form action="AddToCartServlet" method="post">

<input type="hidden" name="product_id"
value="<%= rs.getInt("product_id") %>">

<input type="number" name="quantity" value="1" min="1">

<button type="submit">Add to Cart</button>

</form>
</td>

</tr>

<%
}
con.close();
%>

</table>

<div style="text-align:center;">
<a href="customerdashboard.html">
<button class="back-btn">Back to Dashboard</button>
</a>
</div>

</div>

</body>
</html>