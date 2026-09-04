package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Connection.DBConnection;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String orderIdStr = request.getParameter("order_id");

        if(orderIdStr == null || orderIdStr.isEmpty()){
            response.sendRedirect("vieworders.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE orders SET order_status='Cancelled' WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.executeUpdate();

            con.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        // Redirect back to view orders
        response.sendRedirect("vieworders.jsp");
    }
}