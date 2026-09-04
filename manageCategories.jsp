<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Categories</title>

<style>
body {
    font-family: Arial;
    background: url("images/categorybg.jpg") no-repeat center center fixed;
    background-size: cover;
    padding: 20px;
}

.container {
    background: rgba(255,255,255,0.95);
    width: 700px;
    margin: 50px auto;
    padding: 30px;
    border-radius: 10px;
}

h2 {
    text-align: center;
    color: #2e7d32;
    margin-bottom: 20px;
}

input[type=text] {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    border-radius: 5px;
    border: 1px solid #ccc;
}

button {
    padding: 10px 20px;
    background: #2e7d32;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background: #1b5e20;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #2e7d32;
    color: white;
}

.action-btn {
    padding: 5px 10px;
    border: none;
    border-radius: 4px;
    color: white;
    cursor: pointer;
    margin: 0 2px;
}

.edit-btn { background: #0288d1; }
.edit-btn:hover { background: #01579b; }

.delete-btn { background: #e53935; }
.delete-btn:hover { background: #b71c1c; }

</style>
</head>
<body>

<div class="container">

<h2>Manage Categories</h2>

<!-- Add Category Form -->
<form action="AddCategoryServlet" method="post">
    <input type="text" name="categoryName" placeholder="Enter Category" required>
    <button type="submit">Add Category</button>
</form>

<!-- Categories Table -->
<table>
<tr>
<th>ID</th>
<th>Category Name</th>
<th>Actions</th>
</tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777","root","admin123");

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
    <a href="EditCategoryServlet?id=<%=id%>"><button class="action-btn edit-btn">Edit</button></a>
    <a href="DeleteCategoryServlet?id=<%=id%>" onclick="return confirm('Are you sure to delete?');">
        <button type="button" class="action-btn delete-btn">Delete</button>
    </a>
</td>
</tr>
<%
    }
    con.close();
} catch(Exception e){
    out.println("<tr><td colspan='3' style='color:red;'>Error: "+e.getMessage()+"</td></tr>");
}
%>

</table>
</div>

</body>
</html>