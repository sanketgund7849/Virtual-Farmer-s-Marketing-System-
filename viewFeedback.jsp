<%@page import="java.sql.*"%>

<html>
<head>

<title>Feedback</title>

<style>

body{
background:url("images/feedbackbg.jpg");
background-size:cover;
font-family:Arial;
}

.container{
background:white;
width:70%;
margin:auto;
margin-top:80px;
padding:30px;
}

table{
width:100%;
border-collapse:collapse;
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
padding:5px 10px;
text-decoration:none;
}

</style>

</head>

<body>

<div class="container">

<h2>Customer Feedback</h2>

<table>

<tr>
<th>ID</th>
<th>Customer ID</th>
<th>Message</th>
<th>Action</th>
</tr>

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM feedback");

while(rs.next()){

int id = rs.getInt("feedback_id");

%>

<tr>

<td><%=id%></td>
<td><%=rs.getInt("customer_id")%></td>
<td><%=rs.getString("message")%></td>

<td>
<a class="deletebtn" href="DeleteFeedbackServlet?id=<%=id%>">
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