<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String name = "";
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777","root","admin123");
    PreparedStatement ps = con.prepareStatement("SELECT category_name FROM categories WHERE category_id=?");
    ps.setInt(1,Integer.parseInt(id));
    ResultSet rs = ps.executeQuery();
    if(rs.next()){
        name = rs.getString("category_name");
    }
    con.close();
}catch(Exception e){ out.println(e);}
%>
<html>
<head>
<title>Edit Category</title>
<style>
body{font-family:Arial;background:#f4f6f9;padding:50px;}
.container{background:white;width:400px;margin:auto;padding:30px;border-radius:10px;}
input,button{width:100%;padding:10px;margin-top:10px;border-radius:5px;border:1px solid #ccc;}
button{background:#0288d1;color:white;border:none;cursor:pointer;}
button:hover{background:#01579b;}
</style>
</head>
<body>
<div class="container">
<h2>Edit Category</h2>
<form action="EditCategoryServlet" method="post">
<input type="hidden" name="category_id" value="<%=id%>">
Category Name:<br>
<input type="text" name="category_name" value="<%=name%>" required><br>
<button type="submit">Update Category</button>
</form>
</div>
</body>
</html>