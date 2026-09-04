package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Connection.DBConnection;

@WebServlet("/ ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");

        try {
            Connection con = DBConnection.getConnection();

            // Query: join with customer to get customer name
            String sql = "SELECT o.order_id, c.name AS customer_name, o.total_amount, o.order_status, o.order_date " +
                         "FROM orders o " +
                         "JOIN customers c ON o.customer_id = c.customer_id " +
                         "ORDER BY o.order_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            res.getWriter().println("<!DOCTYPE html>");
            res.getWriter().println("<html><head><meta charset='UTF-8'><title>View Orders</title>");
            res.getWriter().println("<style>");
            res.getWriter().println("body{font-family:Arial; background:#f4f6f9; padding:20px;}");
            res.getWriter().println("h2{text-align:center; color:#2e7d32; margin-bottom:20px;}");
            res.getWriter().println("table{width:90%; margin:0 auto; border-collapse:collapse; background:white; box-shadow:0 4px 10px rgba(0,0,0,0.1);}");
            res.getWriter().println("th,td{padding:12px 15px; text-align:center; border-bottom:1px solid #ddd;}");
            res.getWriter().println("th{background:#2e7d32; color:white;}");
            res.getWriter().println("tr:hover{background:#f1f1f1;}");
            res.getWriter().println(".status-PLACED{color:#ff9800; font-weight:500;}");
            res.getWriter().println(".status-DELIVERED{color:#43a047; font-weight:500;}");
            res.getWriter().println(".back-btn{display:block; width:max-content; margin:20px auto; padding:10px 20px; background-color:#0288d1; color:white; text-decoration:none; border-radius:5px; text-align:center;}");
            res.getWriter().println(".back-btn:hover{background-color:#01579b;}");
            res.getWriter().println("</style></head><body>");

            res.getWriter().println("<h2>All Customer Orders</h2>");
            res.getWriter().println("<table>");
            res.getWriter().println("<tr><th>Order ID</th><th>Customer Name</th><th>Total Amount</th><th>Status</th><th>Order Date</th></tr>");

            while(rs.next()) {
                int orderId = rs.getInt("order_id");
                String customerName = rs.getString("customer_name");
                double totalAmount = rs.getDouble("total_amount");
                String status = rs.getString("order_status");
                java.sql.Date orderDate = rs.getDate("order_date");

                res.getWriter().println("<tr>");
                res.getWriter().println("<td>"+orderId+"</td>");
                res.getWriter().println("<td>"+customerName+"</td>");
                res.getWriter().println("<td>₹ "+totalAmount+"</td>");
                res.getWriter().println("<td class='status-"+status+"'>"+status+"</td>");
                res.getWriter().println("<td>"+orderDate+"</td>");
                res.getWriter().println("</tr>");
            }

            res.getWriter().println("</table>");
            res.getWriter().println("<a href='farmerdashboard.html' class='back-btn'>Back to Dashboard</a>");
            res.getWriter().println("</body></html>");

            con.close();

        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Database Error: "+e.getMessage());
        }
    }
}