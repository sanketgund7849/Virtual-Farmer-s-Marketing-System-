<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Categories</title>
<style>
body{
    font-family: Arial;
    background-image:url("images/categorybg.jpg");
    background-size:cover;
    padding:20px;
}
.container{
    background:white;
    width:80%;
    margin:auto;
    padding:30px;
    border-radius:10px;
}
h2{
    text-align:center;
    color:#2e7d32;
}
table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}
th,td{
    border:1px solid #ddd;
    padding:10px;
    text-align:center;
}
th{
    background:#2e7d32;
    color:white;
}
tr:hover{background:#f1f1f1;}
.add-btn{
    background:#43a047;
    color:white;
    padding:8px 15px;
    border:none;
    border-radius:5px;
    text-decoration:none;
    margin-bottom:10px;
}
.edit-btn{
    background:#0288d1;
    color:white;
    padding:5px 10px;
    border:none;
    border-radius:4px;
    text-decoration:none;
}
.delete-btn{
    background:#e53935;
    color:white;
    padding:5px 10px;
    border:none;
    border-radius:4px;
    text-decoration:none;
}
</style>
</head>
<body>
<div class="container">
<h2>Manage Categories</h2>

<a href="addCategory.jsp" class="add-btn">➕ Add New Category</a>

<table>
<tr>
<th>ID</th>
<th>Category Name</th>
<th>Actions</th>
</tr>

<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777", "root", "admin123");

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM categories");

    while(rs.next()){
        int id = rs.getInt("category_id");
        String name = rs.getString("category_name");
%>
<tr>
<td><%=id%></td>
<td><%=name%></td>
<td>
<a href="editCategory.jsp?id=<%=id%>" class="edit-btn">Edit</a>
<a href="DeleteCategoryServlet?id=<%=id%>" class="delete-btn" 
onclick="return confirm('Are you sure to delete this category?')">Delete</a>
</td>
</tr>
<%
    }
    con.close();
}catch(Exception e){
    out.println("Error: "+e.getMessage());
}
%>

</table>
</div>
</body>
</html>