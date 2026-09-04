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
import javax.servlet.http.HttpSession;

import Connection.DBConnection;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer customerId = (Integer) session.getAttribute("customer_id");

        if(customerId == null) {
            res.getWriter().println("Please login first!");
            return;
        }

        String productIdStr = req.getParameter("product_id");
        String quantityStr = req.getParameter("quantity");

        if(productIdStr == null || productIdStr.isEmpty()) {
            res.getWriter().println("Invalid Product ID!");
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        int quantity = 1;
        if(quantityStr != null && !quantityStr.isEmpty()) {
            quantity = Integer.parseInt(quantityStr);
        }

        try {
            Connection con = DBConnection.getConnection();

            // Check if product already in cart
            String checkSql = "SELECT * FROM cart WHERE customer_id=? AND product_id=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, customerId);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();

            if(rs.next()) {
                // Update quantity if already in cart
                int existingQty = rs.getInt("quantity");
                String updateSql = "UPDATE cart SET quantity=? WHERE cart_id=?";
                PreparedStatement updatePs = con.prepareStatement(updateSql);
                updatePs.setInt(1, existingQty + quantity);
                updatePs.setInt(2, rs.getInt("cart_id"));
                updatePs.executeUpdate();
            } else {
                // Insert new product in cart
                String insertSql = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (?,?,?)";
                PreparedStatement insertPs = con.prepareStatement(insertSql);
                insertPs.setInt(1, customerId);
                insertPs.setInt(2, productId);
                insertPs.setInt(3, quantity);
                insertPs.executeUpdate();
            }

            con.close();

            // Redirect back to products page
            res.sendRedirect("viewCart.jsp?added=success");

        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Database Error: "+e.getMessage());
        }
    }
}