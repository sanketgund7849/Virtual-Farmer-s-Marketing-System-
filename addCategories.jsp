<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Add Category</title>
<style>
body{font-family:Arial;background:#f4f6f9;padding:50px;}
.container{background:white;width:400px;margin:auto;padding:30px;border-radius:10px;}
input,button{width:100%;padding:10px;margin-top:10px;border-radius:5px;border:1px solid #ccc;}
button{background:#2e7d32;color:white;border:none;cursor:pointer;}
button:hover{background:#1b5e20;}
</style>
</head>
<body>
<div class="container">
<h2>Add New Category</h2>
<form action="AddCategoryServlet" method="post">
Category Name:<br>
<input type="text" name="category_name" required><br>
<button type="submit">Add Category</button>
</form>
</div>
</body>
</html>