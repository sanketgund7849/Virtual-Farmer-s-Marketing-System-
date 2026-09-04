package Servlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddFarmerServlet")

public class AddFarmerServlet extends HttpServlet {

protected void service(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

try{

String name=request.getParameter("name");
String email=request.getParameter("email");
String password=request.getParameter("password");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

PreparedStatement ps=con.prepareStatement(
"INSERT INTO farmers(name,email,password,status) VALUES(?,?,?,?)");

ps.setString(1,name);
ps.setString(2,email);
ps.setString(3,password);
ps.setString(4,"APPROVED");

ps.executeUpdate();

response.sendRedirect("viewFarmers.jsp");

}catch(Exception e){

response.getWriter().println(e);

}

}

}