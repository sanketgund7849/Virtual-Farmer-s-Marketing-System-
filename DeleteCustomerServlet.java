package Servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if(idStr == null){
            response.getWriter().println("Customer ID missing");
            return;
        }

        try{
            int id = Integer.parseInt(idStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/farmers_market0777",
                "root","admin123");

            // Delete customer
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM customers WHERE customer_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();

            // Redirect back to customer list
            response.sendRedirect("viewCustomers.jsp");

        } catch(Exception e){
            response.getWriter().println("Error: "+e.getMessage());
        }
    }
}