package Servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        response.setContentType("text/html");
        java.io.PrintWriter out = response.getWriter();

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/farmers_market0777","root","admin123");

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM categories WHERE category_id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                String name = rs.getString("category_name");

                out.println("<form action='EditCategoryServlet' method='post'>");
                out.println("<input type='hidden' name='id' value='"+id+"'>");
                out.println("Category Name:<br>");
                out.println("<input type='text' name='categoryName' value='"+name+"' required><br><br>");
                out.println("<button type='submit'>Update</button>");
                out.println("</form>");
            } else {
                out.println("Category not found");
            }

            con.close();

        } catch(Exception e){
            out.println("Error: "+e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
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
                "UPDATE categories SET category_name=? WHERE category_id=?");
            ps.setString(1, categoryName);
            ps.setInt(2, id);
            ps.executeUpdate();
            con.close();

            response.sendRedirect("manageCategories.jsp");

        } catch(Exception e){
            response.getWriter().println("Error: "+e.getMessage());
        }
    }
}