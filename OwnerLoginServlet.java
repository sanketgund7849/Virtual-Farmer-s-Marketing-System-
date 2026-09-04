package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OwnerLoginServlet")

public class OwnerLoginServlet extends HttpServlet {

protected void service(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

response.setContentType("text/html");

String name = request.getParameter("name");
String password = request.getParameter("password");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

String sql = "SELECT * FROM owner WHERE name=? AND password=?";

PreparedStatement ps = con.prepareStatement(sql);

ps.setString(1,name);
ps.setString(2,password);

ResultSet rs = ps.executeQuery();

if(rs.next()){

HttpSession session = request.getSession();
session.setAttribute("ownerName", name);

response.sendRedirect("ownerdashboard.html");

}
else{

response.getWriter().println("<h3>Invalid Name or Password</h3>");

}

con.close();

}
catch(Exception e){

e.printStackTrace();

response.getWriter().println("<h3>Error : "+e.getMessage()+"</h3>");

}

}

}