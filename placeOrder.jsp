<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    double grandTotal = 0;

    // Logged in customer
    Integer customerId = (Integer) session.getAttribute("customer_id");
    if(customerId == null){
        response.sendRedirect("login.html");
        return;
    }

    Connection con = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/farmers_market0777",
            "root",
            "admin123"
        );

        con.setAutoCommit(false); // Start transaction

        // Fetch cart items
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
            out.println("<h2>Cart is empty! Add products first.</h2>");
            return;
        }

        // Calculate grand total
        while(cartRs.next()){
            grandTotal += cartRs.getDouble("price") * cartRs.getInt("quantity");
        }

        // Insert into orders table
        PreparedStatement orderPs = con.prepareStatement(
            "INSERT INTO orders (customer_id, order_date, total_amount, order_status) VALUES (?, CURDATE(), ?, ?)",
            Statement.RETURN_GENERATED_KEYS
        );
        orderPs.setInt(1, customerId);
        orderPs.setDouble(2, grandTotal);
        orderPs.setString(3, "PLACED");
        orderPs.executeUpdate();

        ResultSet generatedKeys = orderPs.getGeneratedKeys();
        int orderId = 0;
        if(generatedKeys.next()){
            orderId = generatedKeys.getInt(1);
        }

        // Insert into order_details table
        cartRs.beforeFirst();
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

        // Clear cart
        PreparedStatement clearCart = con.prepareStatement(
            "DELETE FROM cart WHERE customer_id=?"
        );
        clearCart.setInt(1, customerId);
        clearCart.executeUpdate();

        con.commit();
        con.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Placed</title>
<style>
body { font-family: Arial, sans-serif; background:#f4f6f9; text-align:center; padding:50px;}
h2 { color:#2e7d32; }
button { padding:10px 20px; margin:10px; background:#2e7d32; color:white; border:none; border-radius:5px; cursor:pointer;}
button:hover { background:#1b5e20; }
</style>
</head>
<body>
<h2>🎉 Order Placed Successfully!</h2>
<p>Total Amount: ₹ <%=grandTotal%></p>
<a href="viewAllProducts.jsp"><button>Continue Shopping</button></a>
<a href="vieworders.jsp"><button>View My Orders</button></a>
</body>
</html>

<%
    }catch(Exception e){
        if(con != null){
            try{ con.rollback(); }catch(Exception ex){}
        }
        e.printStackTrace();
        out.println("Error: "+e.getMessage());
    }
%>