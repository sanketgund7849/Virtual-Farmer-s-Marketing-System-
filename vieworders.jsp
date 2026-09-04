<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>
<style>
body {
    font-family: Arial, sans-serif;
    background: #f0f4f8;
    padding: 20px;
}

h2 {
    text-align: center;
    color: #2e7d32;
    margin-bottom: 20px;
}

table {
    width: 95%;
    margin: auto;
    border-collapse: collapse;
    background: white;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background: #2e7d32;
    color: white;
}

tr:hover {
    background: #f1f1f1;
}

.actions {
    display: flex;
    justify-content: center;
    gap: 8px;
    flex-wrap: wrap;
}

button {
    padding: 6px 12px;
    border: none;
    border-radius: 5px;
    color: white;
    cursor: pointer;
    font-weight: bold;
    font-size: 13px;
    transition: 0.3s;
}

.view-btn { background: #0288d1; }
.view-btn:hover { background: #01579b; }

.cancel-btn { background: #e53935; }
.cancel-btn:hover { background: #b71c1c; }

.pay-btn { background: #43a047; }
.pay-btn:hover { background: #2e7d32; }

.back-btn {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 18px;
    background: #2e7d32;
    color: white;
    text-decoration: none;
    border-radius: 6px;
}

@media(max-width: 600px){
    table, th, td {
        font-size: 12px;
    }
    .actions {
        flex-direction: column;
        gap: 5px;
    }
}
</style>
<script>
function confirmCancel() {
    return confirm("Are you sure you want to cancel this order?");
}
</script>
</head>
<body>

<h2>My Orders</h2>

<table>
<tr>
<th>Order ID</th>
<th>Date</th>
<th>Total Amount</th>
<th>Status</th>
<th>Actions</th>
</tr>

<%
HttpSession sessionObj = request.getSession(false);
if(sessionObj == null || sessionObj.getAttribute("customer_id") == null){
%>
<tr><td colspan="5" style="color:red;">Please Login First</td></tr>
<%
    return;
}

int customerId = (Integer) sessionObj.getAttribute("customer_id");

try{
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/farmers_market0777",
        "root",
        "admin123"
    );

    String sql = "SELECT o.order_id, o.order_date, o.total_amount, o.order_status, " +
                 "p.payment_status " +
                 "FROM orders o LEFT JOIN payments p ON o.order_id = p.order_id " +
                 "WHERE o.customer_id=?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, customerId);
    ResultSet rs = ps.executeQuery();

    boolean hasOrders = false;

    while(rs.next()){
        hasOrders = true;
        int orderId = rs.getInt("order_id");
        Date orderDate = rs.getDate("order_date");
        double total = rs.getDouble("total_amount");
        String status = rs.getString("order_status");
        String paymentStatus = rs.getString("payment_status");
        if(paymentStatus == null) paymentStatus = "Pending";
%>

<tr>
<td><%=orderId%></td>
<td><%=orderDate%></td>
<td>₹ <%=total%></td>
<td><%=status%></td>
<td>
<div class="actions">
    <a href="viewOrderDetails.jsp?order_id=<%=orderId%>"><button type="button" class="view-btn">View Details</button></a>

    <% if(!status.equalsIgnoreCase("Cancelled") && !status.equalsIgnoreCase("Delivered")) { %>
    <form action="CancelOrderServlet" method="post" onsubmit="return confirmCancel();">
        <input type="hidden" name="order_id" value="<%=orderId%>">
        <button type="submit" class="cancel-btn">Cancel Order</button>
    </form>
    <% } %>

    <% if(!status.equalsIgnoreCase("Cancelled") && !"Success".equalsIgnoreCase(paymentStatus)) { %>
    <form action="payment.jsp" method="get">
        <input type="hidden" name="order_id" value="<%=orderId%>">
        <button type="submit" class="pay-btn">Pay Now</button>
    </form>
    <% } %>
</div>
</td>
</tr>

<%
    }

    if(!hasOrders){
%>
<tr><td colspan="5" style="color:red;">No Orders Found</td></tr>
<%
    }

    con.close();
} catch(Exception e){
%>
<tr><td colspan="5" style="color:red;">Error: <%=e.getMessage()%></td></tr>
<%
}
%>
</table>

<div style="text-align:center;">
<a href="customerdashboard.html" class="back-btn">⬅ Back to Dashboard</a>
</div>

</body>
</html>