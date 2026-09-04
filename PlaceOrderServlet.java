package Servlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if customer is logged in
        if(session == null || session.getAttribute("customer_id") == null){
            response.sendRedirect("login.html");
            return;
        }

        int customerId = (Integer) session.getAttribute("customer_id");
        Connection con = null;

        try {
            // 1️⃣ Connect to DB
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/farmers_market0777",
                    "root",
                    "admin123"
            );
            con.setAutoCommit(false); // Transaction start

            // 2️⃣ Fetch cart items (scrollable)
            double grandTotal = 0;
            PreparedStatement cartPs = con.prepareStatement(
                    "SELECT c.product_id, p.product_name, p.price, c.quantity " +
                    "FROM cart c JOIN products p ON c.product_id=p.product_id " +
                    "WHERE c.customer_id=?",
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY
            );
            cartPs.setInt(1, customerId);
            ResultSet cartRs = cartPs.executeQuery();

            if(!cartRs.isBeforeFirst()){
                response.getWriter().println("Cart is empty! Add products first.");
                return;
            }

            // 3️⃣ Calculate grand total
            while(cartRs.next()){
                grandTotal += cartRs.getDouble("price") * cartRs.getInt("quantity");
            }

            // 4️⃣ Insert into orders table
            PreparedStatement orderPs = con.prepareStatement(
                    "INSERT INTO orders (customer_id, order_date, total_amount, order_status) VALUES (?, CURDATE(), ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );

            orderPs.setInt(1, customerId);       // customer_id
            orderPs.setDouble(2, grandTotal);    // total_amount
            orderPs.setString(3, "PLACED");      // order_status
            orderPs.executeUpdate();

            // Get generated order_id
            ResultSet generatedKeys = orderPs.getGeneratedKeys();
            int orderId = 0;
            if(generatedKeys.next()){
                orderId = generatedKeys.getInt(1);
            }

            // 5️⃣ Insert into order_details table
            cartRs.beforeFirst(); // Reset cursor
            PreparedStatement detailPs = con.prepareStatement(
                    "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)"
            );

            while(cartRs.next()){
                detailPs.setInt(1, orderId);
                detailPs.setInt(2, cartRs.getInt("product_id"));
                detailPs.setInt(3, cartRs.getInt("quantity"));
                detailPs.setDouble(4, cartRs.getDouble("price"));
                detailPs.executeUpdate();
            }

            // 6️⃣ Clear cart
            PreparedStatement clearCart = con.prepareStatement(
                    "DELETE FROM cart WHERE customer_id=?"
            );
            clearCart.setInt(1, customerId);
            clearCart.executeUpdate();

            // 7️⃣ Commit transaction
            con.commit();
            con.close();

            // 8️⃣ Redirect to view orders page
            response.sendRedirect("vieworders.jsp");

        } catch(Exception e){
            // Rollback if error occurs
            if(con != null){
                try { con.rollback(); } catch(Exception ex) {}
            }
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}