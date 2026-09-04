package Servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {

    protected void service(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");

        if(categoryName == null || categoryName.trim().isEmpty()){
            response.getWriter().println("Category Name cannot be empty");
            return;
        }

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/farmers_market0777","root","admin123");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO categories(category_name) VALUES(?)");
            ps.setString(1, categoryName);
            ps.executeUpdate();
            con.close();

            response.sendRedirect("manageCategories.jsp");

        } catch(Exception e){
            response.getWriter().println("Error: "+e.getMessage());
        }
    }
}