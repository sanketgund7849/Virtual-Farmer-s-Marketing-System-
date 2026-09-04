package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/FeedbackServlet")

public class FeedbackServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

try {

HttpSession session = request.getSession(false);

if(session==null || session.getAttribute("customer_id")==null){

response.getWriter().println("Customer not logged in");
return;

}

int cid = (Integer) session.getAttribute("customer_id");

String message = request.getParameter("message");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

PreparedStatement ps = con.prepareStatement(
"INSERT INTO feedback(customer_id,message) VALUES(?,?)");

ps.setInt(1, cid);
ps.setString(2, message);

int i = ps.executeUpdate();

if(i>0){

response.sendRedirect("feedback.jsp");

}else{

response.getWriter().println("Feedback not submitted");

}

con.close();

}catch(Exception e){

e.printStackTrace();

}

}

}