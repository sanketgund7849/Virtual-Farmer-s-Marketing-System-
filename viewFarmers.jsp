<%@page import="java.sql.*"%>

<html>
<head>

<title>Farmers List</title>

<style>

body{
font-family: Arial;
background-image:url("images/farmbg.jpg");
background-size:cover;
}

.container{
width:80%;
margin:auto;
margin-top:60px;
background:white;
padding:30px;
border-radius:10px;
}

h2{
text-align:center;
}

table{
width:100%;
border-collapse:collapse;
margin-top:20px;
}

th{
background:#2e7d32;
color:white;
}

th,td{
padding:10px;
border:1px solid #ddd;
text-align:center;
}

.deletebtn{
background:red;
color:white;
padding:6px 12px;
text-decoration:none;
border-radius:5px;
}

.addbtn{
background:#2e7d32;
color:white;
padding:8px 15px;
text-decoration:none;
border-radius:5px;
}

</style>

</head>

<body>

<div class="container">

<h2>Farmers List</h2>

<a class="addbtn" href="addfarmer.jsp">Add Farmer</a>

<table>

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Status</th>
<th>Action</th>
</tr>

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

Statement st=con.createStatement();

ResultSet rs=st.executeQuery("SELECT * FROM farmers");

while(rs.next()){

int id=rs.getInt("farmer_id");

%>

<tr>

<td><%=id%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("status")%></td>

<td>

<a class="deletebtn" href="DeleteFarmerServlet?id=<%=id%>">
Delete
</a>

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.println(e);

}

%>

</table>

</div>

</body>
</html>