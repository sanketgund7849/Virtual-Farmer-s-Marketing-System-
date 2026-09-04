<%@page import="java.sql.*"%>

<html>
<head>

<title>Payment Report</title>

<style>

body{
background:url("images/paymentbg.jpg");
background-size:cover;
font-family:Arial;
}

.container{

background:white;
width:80%;
margin:auto;
margin-top:60px;
padding:30px;

}

table{
width:100%;
border-collapse:collapse;
}

th,td{

padding:12px;
border-bottom:1px solid #ddd;
text-align:center;

}

th{
background:#2e7d32;
color:white;
}

</style>

</head>

<body>

<div class="container">

<h2>Payment Report</h2>

<table>

<tr>
<th>Payment ID</th>
<th>Order ID</th>
<th>Mode</th>
<th>Status</th>
</tr>

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root","admin123");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery("select * from payments");

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("payment_id")%></td>
<td><%=rs.getInt("order_id")%></td>
<td><%=rs.getString("payment_mode")%></td>
<td><%=rs.getString("payment_status")%></td>

</tr>

<%

}

}catch(Exception e){
out.println(e);
}

%>

</table>

</div>

</body>
</html>