<%@ page import="java.sql.*" %>
<%
double grandTotal = 0;
boolean hasItems = false;
%>

<!DOCTYPE html>
<html>
<head>
<title>My Cart</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{
background:url('https://images.unsplash.com/photo-1606787366850-de6330128bfc') no-repeat center center/cover;
min-height:100vh;
padding:40px;
}

.overlay{
background:rgba(0,0,0,0.7);
padding:30px;
border-radius:12px;
}

.container{
width:90%;
margin:auto;
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 10px 25px rgba(0,0,0,0.4);
}

h2{
text-align:center;
color:#2e7d32;
margin-bottom:20px;
}

table{
width:100%;
border-collapse:collapse;
margin-top:20px;
}

th{
background:#2e7d32;
color:white;
padding:12px;
}

td{
padding:12px;
text-align:center;
border-bottom:1px solid #ddd;
}

tr:hover{
background:#f5f5f5;
}

.total-row{
background:#ecf0f1;
font-weight:bold;
}

.btn{
display:inline-block;
margin-top:20px;
padding:10px 20px;
background:#3498db;
color:white;
text-decoration:none;
border-radius:6px;
transition:0.3s;
border:none;
cursor:pointer;
font-weight:600;
}

.btn:hover{
background:#2980b9;
}

.order-btn{
background:#e67e22;
margin-left:10px;
}

.order-btn:hover{
background:#d35400;
}

</style>

</head>
<body>

<div class="overlay">

<div class="container">

<h2> My Shopping Cart</h2>

<table>
<tr>
<th>Product Name</th>
<th>Type</th>
<th>Price </th>
<th>Quantity</th>
<th>Total </th>
</tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777",
        "root",
        "admin123"
    );

    Integer customerId = (Integer) session.getAttribute("customer_id");

    if(customerId != null){

        PreparedStatement ps = con.prepareStatement(
            "SELECT c.cart_id, p.product_name, p.product_type, p.price, c.quantity " +
            "FROM cart c JOIN products p ON c.product_id = p.product_id " +
            "WHERE c.customer_id=?"
        );

        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            hasItems = true;
            double total = rs.getDouble("price") * rs.getInt("quantity");
            grandTotal += total;
%>

<tr>
<td><%= rs.getString("product_name") %></td>
<td><%= rs.getString("product_type") %></td>
<td> <%= rs.getDouble("price") %></td>
<td><%= rs.getInt("quantity") %></td>
<td> <%= total %></td>
</tr>

<%
        }

        if(!hasItems){
%>
<tr>
<td colspan="5">Your cart is empty.</td>
</tr>
<%
        }

    } else {
%>
<tr>
<td colspan="5">Please login first.</td>
</tr>
<%
    }

    con.close();
} catch(Exception e) {
    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
}
%>

<tr class="total-row">
<td colspan="4">Grand Total</td>
<td> <%= grandTotal %></td>
</tr>

</table>

<br>

<a href="viewAllProducts.jsp" class="btn"> Back to Products</a>

<%
if(hasItems){
%>

<form action="placeOrder.jsp" method="post" style="display:inline;">
<input type="hidden" name="grandTotal" value="<%= grandTotal %>">
<button type="submit" class="btn order-btn">Place Order</button>
</form>

<%
}
%>

</div>
</div>

</body>
</html>