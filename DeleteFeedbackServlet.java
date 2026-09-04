package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;

@WebServlet("/DeleteFeedbackServlet")

public class DeleteFeedbackServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

try {

int id = Integer.parseInt(request.getParameter("id"));

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/farmers_market0777",
"root",
"admin123");

PreparedStatement ps = con.prepareStatement(
"DELETE FROM feedback WHERE feedback_id=?");

ps.setInt(1, id);

ps.executeUpdate();

con.close();

response.sendRedirect("viewFeedback.jsp");

} catch(Exception e) {

response.getWriter().println("Error: " + e.getMessage());

}

}

}