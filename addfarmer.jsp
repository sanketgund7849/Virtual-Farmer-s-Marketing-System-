<html>

<head>

<title>Add Farmer</title>

<style>

body{
font-family:Arial;
background-image:url("images/farmbg.jpg");
background-size:cover;
}

.container{
width:400px;
margin:auto;
margin-top:100px;
background:white;
padding:30px;
border-radius:10px;
}

input{
width:100%;
padding:10px;
margin:10px 0;
}

button{
background:#2e7d32;
color:white;
padding:10px;
border:none;
width:100%;
}

</style>

</head>

<body>

<div class="container">

<h2>Add Farmer</h2>

<form action="AddFarmerServlet" method="post">

Name
<input type="text" name="name" required>

Email
<input type="email" name="email" required>

Password
<input type="password" name="password" required>

<button type="submit">Add Farmer</button>

</form>

</div>

</body>

</html>