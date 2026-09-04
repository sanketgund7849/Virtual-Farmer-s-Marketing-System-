<!DOCTYPE html>
<html>
<head>
<title>Submit Feedback</title>

<style>
body{
font-family: Arial;
background-image:url("images/farmbg.jpg");
background-size:cover;
}

.container{
width:400px;
background:white;
padding:30px;
margin:100px auto;
border-radius:10px;
text-align:center;
}

textarea{
width:100%;
height:100px;
}

button{
padding:10px 20px;
background:green;
color:white;
border:none;
}
</style>

</head>

<body>

<div class="container">

<h2>Submit Your Feedback</h2>

<form action="FeedbackServlet" method="post">

Feedback:<br>
<textarea name="message" required></textarea><br><br>

<button type="submit">Submit Feedback</button>

</form>

</div>

</body>
</html>