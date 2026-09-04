package Servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Connection.DBConnection;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("farmerId") == null) {
            response.sendRedirect("farmerdashboard.html");
            return;
        }

        int farmerId = (int) session.getAttribute("farmerId");

        String productName = request.getParameter("productName");
        String productType = request.getParameter("productType");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try {
            Connection con = DBConnection.getConnection();

            String status = request.getParameter("status");

            String sql = "INSERT INTO products (farmer_id, product_name, product_type, price, quantity, status) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, farmerId);
            ps.setString(2, productName);
            ps.setString(3, productType);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, status);

            int i = ps.executeUpdate();

            if (i > 0) {
                response.sendRedirect("farmerdashboard.html");
            } else {
                response.getWriter().println("Product Not Added!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}