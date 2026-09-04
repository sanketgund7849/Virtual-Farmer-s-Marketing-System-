package Servlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteFarmerServlet")

public class DeleteFarmerServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

try{

int id=Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

PreparedStatement ps=con.prepareStatement(
"DELETE FROM farmers WHERE farmer_id=?");

ps.setInt(1,id);

ps.executeUpdate();

response.sendRedirect("viewFarmers.jsp");

}catch(Exception e){

response.getWriter().println(e);

}

}

}