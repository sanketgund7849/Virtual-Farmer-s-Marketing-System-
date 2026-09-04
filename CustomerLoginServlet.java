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

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if(email == null || password == null || email.isEmpty() || password.isEmpty()){
            res.getWriter().println("Please enter email and password!");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM customers WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                // Login success → set session
                HttpSession session = req.getSession();
                session.setAttribute("customer_id", rs.getInt("customer_id"));
                session.setAttribute("customer_name", rs.getString("name"));
                
                res.sendRedirect("customerdashboard.html");
            } else {
                res.getWriter().println("Invalid Email or Password!");
            }
            
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Database Error: " + e.getMessage());
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("login.html");
    }
}