<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

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

/* Overlay for readability */
.overlay{
    background:rgba(0,0,0,0.65);
    min-height:100vh;
    padding:30px;
}

h2{
    text-align:center;
    color:white;
    margin-bottom:25px;
    font-size:30px;
}

table{
    border-collapse: collapse;
    width:80%;
    margin:0 auto;
    background:rgba(255,255,255,0.95);
    box-shadow:0 6px 20px rgba(0,0,0,0.4);
    border-radius:8px;
    overflow:hidden;
}

th, td{
    border:1px solid #ccc;
    padding:12px 15px;
    text-align:center;
}

th{
    background:#2e7d32;
    color:white;
}

tr:hover{
    background:#f1f1f1;
}

.total-row{
    font-weight:bold;
    color:#2e7d32;
    background:#ecf9ec;
}

/* Back Button */
.back-btn{
    display:inline-block;
    margin-top:25px;
    padding:10px 20px;
    background:#0288d1;
    color:white;
    text-decoration:none;
    border-radius:6px;
    font-weight:bold;
}

.back-btn:hover{
    background:#01579b;
}

</style>
</head>

<body>

<div class="overlay">

<h2> Order Details</h2>

<table>
<tr>
    <th>Product Name</th>
    <th>Price (₹)</th>
    <th>Quantity</th>
    <th>Total (₹)</th>
</tr>

<%
double grandTotal = 0;
try {

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777",
        "root",
        "admin123"
    );

    int orderId = Integer.parseInt(request.getParameter("order_id"));

    PreparedStatement ps = con.prepareStatement(
        "SELECT p.product_name, od.price, od.quantity " +
        "FROM order_details od " +
        "JOIN products p ON od.product_id = p.product_id " +
        "WHERE od.order_id = ?"
    );

    ps.setInt(1, orderId);
    ResultSet rs = ps.executeQuery();

    while(rs.next()) {

        double total = rs.getDouble("price") * rs.getInt("quantity");
        grandTotal += total;
%>

<tr>
<td><%= rs.getString("product_name") %></td>
<td>₹ <%= rs.getDouble("price") %></td>
<td><%= rs.getInt("quantity") %></td>
<td>₹ <%= total %></td>
</tr>

<%
    }

    con.close();

} catch(Exception e){
%>

<tr>
<td colspan="4" style="color:red;">Error: <%= e.getMessage() %></td>
</tr>

<%
}
%>

<tr class="total-row">
<td colspan="3">Grand Total</td>
<td>₹ <%= grandTotal %></td>
</tr>

</table>

<div style="text-align:center;">
<a href="vieworders.jsp" class="back-btn">⬅ Back to Orders</a>
</div>

</div>

</body>
</html>