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

@WebServlet("/FarmerRegisterServlet")
public class FarmerRegisterServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO farmers(farmer_id,name,email,password,status) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,id);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, password);
           
            ps.setString(5, status);

             ps.executeUpdate();

            
             response.sendRedirect(request.getContextPath() + "/farmerlogin.html");            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}