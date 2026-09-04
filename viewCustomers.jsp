<%@page import="java.sql.*"%>
<html>
<head>
<title>View Customers</title>

<style>

body{
font-family:Arial;
background:url("images/customerbg.jpg");
background-size:cover;
}

.container{
background:rgba(255,255,255,0.9);
width:80%;
margin:auto;
margin-top:60px;
padding:30px;
border-radius:10px;
}

table{
width:100%;
border-collapse:collapse;
}

th,td{
padding:12px;
text-align:center;
border-bottom:1px solid #ddd;
}

th{
background:#388e3c;
color:white;
}

.action-btn{
padding:5px 10px;
border:none;
border-radius:5px;
color:white;
cursor:pointer;
}

.delete-btn{
background:#e53935;
}

.delete-btn:hover{
background:#b71c1c;
}

</style>
</head>

<body>

<div class="container">

<h2>Customers List</h2>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Actions</th>
</tr>

<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777",
        "root","admin123");

    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select * from customers");

    while(rs.next()){
        int id = rs.getInt("customer_id");
%>

<tr>
<td><%=id%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("email")%></td>
<td>
    <a href="DeleteCustomerServlet?id=<%=id%>" 
       onclick="return confirm('Are you sure you want to delete this customer?');">
       <button class="action-btn delete-btn">Delete</button>
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