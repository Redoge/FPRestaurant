package app.redoge.restaurant.DAO;

import com.mysql.cj.jdbc.Driver;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    private static final Logger log = Logger.getLogger(ConnectDB.class);
    private static Connection connection = null;

    public static Connection getConnection() {

        if (connection != null)
            return connection;
        else {
            try {
                Driver driver;
                Connection con;
                driver = new com.mysql.cj.jdbc.Driver();
                DriverManager.registerDriver(driver);
                String url = "jdbc:mysql://localhost:3306/";
                String dbName = "restaurant";
                String driverr = "com.mysql.cj.jdbc.Driver";
                String userName = "root";
                String password = "danylo2003";
                connection = DriverManager.getConnection(url + dbName, userName, password);
            }
            catch (SQLException e) {
                log.error(e);
            }
            return connection;
        }
    }
}
