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

@WebServlet("/ViewProductsServlet")
public class ViewProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT p.product_id, p.product_name, p.product_type, p.price, p.quantity, f.name AS farmer_name " +
                         "FROM products p " +
                         "JOIN farmers f ON p.farmer_id = f.farmer_id " +
                         "WHERE p.status='AVAILABLE'";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            res.getWriter().println("<!DOCTYPE html>");
            res.getWriter().println("<html><head><meta charset='UTF-8'><title>All Products</title>");

            res.getWriter().println("<link href='https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap' rel='stylesheet'>");

            res.getWriter().println("<style>");

            res.getWriter().println("*{margin:0;padding:0;box-sizing:border-box;font-family:Poppins;}");

            res.getWriter().println("body{");
            res.getWriter().println("background:url('https://images.unsplash.com/photo-1500382017468-9049fed747ef') no-repeat center center/cover;");
            res.getWriter().println("min-height:100vh;");
            res.getWriter().println("}");

            res.getWriter().println(".overlay{");
            res.getWriter().println("background:rgba(0,0,0,0.6);");
            res.getWriter().println("min-height:100vh;");
            res.getWriter().println("padding:40px;");
            res.getWriter().println("}");

            res.getWriter().println("h2{");
            res.getWriter().println("text-align:center;");
            res.getWriter().println("color:white;");
            res.getWriter().println("margin-bottom:30px;");
            res.getWriter().println("}");

            res.getWriter().println("table{");
            res.getWriter().println("width:90%;");
            res.getWriter().println("margin:auto;");
            res.getWriter().println("border-collapse:collapse;");
            res.getWriter().println("background:white;");
            res.getWriter().println("border-radius:10px;");
            res.getWriter().println("overflow:hidden;");
            res.getWriter().println("box-shadow:0 8px 25px rgba(0,0,0,0.3);");
            res.getWriter().println("}");

            res.getWriter().println("th{");
            res.getWriter().println("background:#2e7d32;");
            res.getWriter().println("color:white;");
            res.getWriter().println("padding:15px;");
            res.getWriter().println("}");

            res.getWriter().println("td{");
            res.getWriter().println("padding:12px;");
            res.getWriter().println("text-align:center;");
            res.getWriter().println("border-bottom:1px solid #ddd;");
            res.getWriter().println("}");

            res.getWriter().println("tr:hover{background:#f5f5f5;}");

            res.getWriter().println(".back-btn{");
            res.getWriter().println("display:block;");
            res.getWriter().println("width:200px;");
            res.getWriter().println("margin:30px auto;");
            res.getWriter().println("padding:12px;");
            res.getWriter().println("background:#ff9800;");
            res.getWriter().println("color:white;");
            res.getWriter().println("text-align:center;");
            res.getWriter().println("text-decoration:none;");
            res.getWriter().println("border-radius:5px;");
            res.getWriter().println("font-weight:bold;");
            res.getWriter().println("}");

            res.getWriter().println(".back-btn:hover{background:#e68900;}");

            res.getWriter().println("</style></head><body>");

            res.getWriter().println("<div class='overlay'>");

            res.getWriter().println("<h2>🛒 All Available Products</h2>");

            res.getWriter().println("<table>");
            res.getWriter().println("<tr><th>ID</th><th>Name</th><th>Type</th><th>Price</th><th>Quantity</th><th>Farmer</th></tr>");

            while(rs.next()) {

                int productId = rs.getInt("product_id");
                String name = rs.getString("product_name");
                String type = rs.getString("product_type");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String farmerName = rs.getString("farmer_name");

                res.getWriter().println("<tr>");
                res.getWriter().println("<td>"+productId+"</td>");
                res.getWriter().println("<td>"+name+"</td>");
                res.getWriter().println("<td>"+type+"</td>");
                res.getWriter().println("<td>₹ "+price+"</td>");
                res.getWriter().println("<td>"+quantity+" Kg</td>");
                res.getWriter().println("<td>"+farmerName+"</td>");
                res.getWriter().println("</tr>");
            }

            res.getWriter().println("</table>");

            res.getWriter().println("<a href='customerdashboard.html' class='back-btn'>⬅ Back To Dashboard</a>");

            res.getWriter().println("</div>");
            res.getWriter().println("</body></html>");

            con.close();

        } catch(Exception e) {

            e.printStackTrace();
            res.getWriter().println("Database Error: "+e.getMessage());

        }
    }
}