package app.redoge.restaurant.DAO;

import app.redoge.restaurant.User;
import app.redoge.restaurant.UserRole;
import com.mysql.cj.jdbc.Driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static java.util.Objects.isNull;

public class UserDao {
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
                e.printStackTrace();
            }
            return connection;
        }
    }

    private static String getPassword(String email) throws SQLException {
        String  out = "";
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `email` = '"+email+"'");
        while(rs.next()) {
            out = (rs.getString("password"));

        }
        return out;
    }

    public static User getUser(String email) throws SQLException {
        ResultSet rs = null;
        connection = getConnection();
        try {
            Statement statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM user  WHERE `email` = '"+email+"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        User user = null;
        while(rs.next()) {
            int id = rs.getInt("id");
            int role = Integer.parseInt(rs.getString("role_id"));
            String username = rs.getString("username");
            user = new User(username, email, id, role);

        }




        return user;
    }

    public static boolean setUser(String username, String email, String password, int access){
        System.out.println(9);
        boolean rs = false;
        Statement statement = null;
        connection = getConnection();
        String sql = "INSERT INTO user (username, email, password, role_id)" +
                "VALUE ('"+username+"', '"+email+"', '"+password+"', "+access+")";
        try {
             statement = connection.createStatement();
             statement.executeUpdate(sql);
             rs = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(10);
        return rs;
    }

    public static boolean isTruePassword(String password, String email){
        if(password == null || email == null) return false;

        boolean out = false;
        String passwordTrue = "";
        email = email.trim();
        if (password.length() < 3 || email.length() < 3){
            return false;
        }

        try {
            passwordTrue = getPassword(email);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return password.equals(passwordTrue);
    }

    public static boolean isEmailExists(String email) throws SQLException {
        boolean  out = true;
        String tmp = null;
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `email` = '"+email+"'");
        while(rs.next()) {
            tmp = rs.getString("email");
        }
        return !isNull(tmp);
    }

    public static boolean isUsernameExists(String username) throws SQLException {
        boolean  out = true;
        String tmp = null;
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `username` = '"+username+"'");
        while(rs.next()) {
            tmp = rs.getString("username");
        }
        return !isNull(tmp);
    }


    public static void main(String[] args) throws SQLException {
        System.out.println(isEmailExists("danylo.klas@gmail.com"));
        System.out.println(isTruePassword("admin","mail.redoge@gmail.com" ));
    }
}
