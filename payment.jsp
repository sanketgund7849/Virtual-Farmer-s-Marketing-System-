<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Payment</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
text-align:center;
padding:40px;
}

.container{
background:white;
padding:30px;
width:400px;
margin:auto;
border-radius:10px;
box-shadow:0 0 10px rgba(0,0,0,0.2);
}

button{
padding:10px 20px;
background:#2e7d32;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
}

button:hover{
background:#1b5e20;
}

</style>

</head>

<body>

<div class="container">

<h2>Select Payment Method</h2>

<%
String orderId=request.getParameter("order_id");
%>

<form action="PaymentSuccess.jsp" method="post">

<input type="hidden" name="order_id" value="<%=orderId%>">

<input type="radio" name="payment_mode" value="UPI" required> UPI<br><br>

<input type="radio" name="payment_mode" value="CARD"> Credit / Debit Card<br><br>

<input type="radio" name="payment_mode" value="COD"> Cash On Delivery<br><br>

<button type="submit">Pay Now</button>

</form>

</div>

</body>
</html>