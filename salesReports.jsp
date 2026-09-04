<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-image: url("images/farmbg.jpg");
    background-size: cover;
    background-position: center;
    padding: 20px;
}

.container {
    background: rgba(255,255,255,0.95);
    width: 80%;
    margin: 50px auto;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}

h2 {
    text-align: center;
    color: #2e7d32;
    margin-bottom: 30px;
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
}

th {
    background-color: #2e7d32;
    color: white;
}

tr:hover {
    background-color: #f1f1f1;
}

.back-btn {
    display: inline-block;
    margin-top: 20px;
    padding: 8px 15px;
    background: #2e7d32;
    color: white;
    text-decoration: none;
    border-radius: 5px;
}
</style>
</head>

<body>

<div class="container">
<h2>Sales Report</h2>

<table>
<tr>
<th>Total Orders</th>
<th>Total Sales Amount</th>
</tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777",
        "root",
        "admin123"
    );

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(
        "SELECT COUNT(order_id) AS total_orders, SUM(total_amount) AS total_sales FROM orders"
    );

    if(rs.next()){
%>
<tr>
<td><%= rs.getInt("total_orders") %></td>
<td><%= rs.getDouble("total_sales") %></td>
</tr>
<%
    } else {
%>
<tr>
<td colspan="2" style="color:red;">No Orders Found</td>
</tr>
<%
    }

    con.close();
} catch(Exception e) {
%>
<tr>
<td colspan="2" style="color:red;">Error: <%= e.getMessage() %></td>
</tr>
<%
}
%>
</table>

<div style="text-align:center;">
<a href="ownerdashboard.html" class="back-btn"> Back to Dashboard</a>
</div>

</div>

</body>
</html>