package Servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import Connection.DBConnection;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,HttpServletResponse response)
throws ServletException,IOException{

int orderId = Integer.parseInt(request.getParameter("order_id"));
String mode = request.getParameter("payment_mode");

try{

Connection con = DBConnection.getConnection();

String sql = "INSERT INTO payments(order_id,payment_date,payment_mode,payment_status) VALUES(?,CURDATE(),?,?)";

PreparedStatement ps = con.prepareStatement(sql);

ps.setInt(1,orderId);
ps.setString(2,mode);
ps.setString(3,"PAID");

ps.executeUpdate();

response.sendRedirect("PaymentSuccess.jsp");

}catch(Exception e){
e.printStackTrace();
}

}
}