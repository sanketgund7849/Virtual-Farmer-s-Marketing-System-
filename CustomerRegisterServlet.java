package Servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/CustomerRegisterServlet")
public class CustomerRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1️⃣ Form se data receive
    	String id=request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");

        // 2️⃣ Database connection details
        String url = "jdbc:mysql://localhost:3306/farmers_market0777";
        String user = "root";
        String pass = "admin123";  

        try {
            // 3️⃣ JDBC Driver load
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 4️⃣ Connection
            Connection con = DriverManager.getConnection(url, user, pass);

            // 5️⃣ SQL Insert Query
            String sql = "INSERT INTO customers(customer_id,name, email, password, mobile, address, gender) "
                       + "VALUES (?,?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,id);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, mobile);
            ps.setString(6, address);
            ps.setString(7, gender);

            // 6️⃣ Execute
            int i = ps.executeUpdate();

            if (i > 0) {
                response.sendRedirect("login.html");
            } else {
                response.sendRedirect("register.html?error=failed");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error : " + e.getMessage());
        }
    }
}