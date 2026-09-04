
package Connection;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con=null ;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/farmers_market0777",
                    "root",
                    "admin123");   // password असेल तर इथे टाक
        } catch (Exception e) {
            e.printStackTrace();
        }
		return con;

       
    }
}