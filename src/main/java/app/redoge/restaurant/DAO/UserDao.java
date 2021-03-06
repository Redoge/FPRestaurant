package app.redoge.restaurant.DAO;

import app.redoge.restaurant.User;
import app.redoge.restaurant.enums.UserRole;
import com.mysql.cj.jdbc.Driver;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import static app.redoge.restaurant.DAO.ConnectDB.getConnection;
import static java.util.Objects.isNull;

/**
 * The type User dao.
 */
public class UserDao {
    private static final Logger log = Logger.getLogger(UserDao.class);

    private static Connection connection = null;

    private static String getPassword(String email) throws SQLException {
        String out = "";
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `email` = '" + email + "'");
        while (rs.next()) {
            out = (rs.getString("password"));
        }
        return out;
    }

    private static String getPasswordByUsername(String username) throws SQLException {
        String out = "";
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `username` = '" + username + "'");
        while (rs.next()) {
            out = (rs.getString("password"));
        }
        return out;
    }

    /**
     * Gets user.
     *
     * @param email the email
     * @return the user
     * @throws SQLException the sql exception
     */
    public static User getUser(String email) throws SQLException {
        ResultSet rs = null;
        connection = getConnection();
        try {
            Statement statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM user  WHERE `email` = '" + email + "'");
        } catch (SQLException e) {
            log.error(e);
        }
        User user = null;
        while (rs.next()) {
            int id = rs.getInt("id");
            int role = Integer.parseInt(rs.getString("role_id"));
            String username = rs.getString("username");
            String language = rs.getString("language");
            user = new User(username, email, id, role, language);

        }
        return user;
    }


    /**
     * Gets user.
     *
     * @param username the email
     * @return the user
     * @throws SQLException the sql exception
     */
    public static User getUserByUsername(String username) throws SQLException {
        ResultSet rs = null;
        connection = getConnection();
        try {
            Statement statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM user  WHERE `username` = '" + username + "'");
        } catch (SQLException e) {
            log.error(e);
        }
        User user = null;
        while (rs.next()) {
            int id = rs.getInt("id");
            int role = Integer.parseInt(rs.getString("role_id"));
            String email = rs.getString("email");
            String language = rs.getString("language");
            user = new User(username, email, id, role, language);

        }
        return user;
    }

    /**
     * Gets all user.
     *
     * @return the all user
     * @throws SQLException the sql exception
     */
    public static ArrayList<User> getAllUser() throws SQLException {
        ArrayList<User> userList = new ArrayList<>();
        ResultSet rs = null;
        connection = getConnection();
        try {
            Statement statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM user");
        } catch (SQLException e) {
            log.error(e);
        }
        while (rs.next()) {
            int id = rs.getInt("id");
            int role = Integer.parseInt(rs.getString("role_id"));
            String username = rs.getString("username");
            String email = rs.getString("email");
            String language = rs.getString("language");
            userList.add(new User(username, email, id, role, language));

        }
        return userList;
    }

    /**
     * Set user boolean.
     * If the addition is successful, the return is true.
     * If the addition is not successful, it is not true to return
     *
     * @param username the username
     * @param email    the email
     * @param password the password
     * @param access   the access
     * @return the boolean
     */
    public static boolean setUser(String username, String email, String password, int access, String language) {
        System.out.println(9);
        boolean rs = false;
        Statement statement = null;
        connection = getConnection();
        String sql = "INSERT INTO user (username, email, password, role_id, language)" +
                "VALUE ('" + username + "', '" + email + "', '" + password + "', " + access + ",'" + language + "')";
        try {
            statement = connection.createStatement();
            statement.executeUpdate(sql);
            rs = true;
        } catch (SQLException e) {
            log.error(e);
        }
        log.info("Added new user " + email);
        return rs;
    }

    /**
     * Is true password boolean.
     * If the password is correct, it will return true.
     * Otherwise false
     *
     * @param password the password
     * @param email    the email
     * @return the boolean
     */
    public static boolean isTruePassword(String password, String email) {
        if (password == null || email == null) return false;

        boolean out = false;
        String passwordTrue = "";
        email = email.trim();
        if (password.length() < 3 || email.length() < 3) {
            return false;
        }

        try {
            passwordTrue = getPassword(email);
        } catch (SQLException e) {
            log.error(e);
        }
        return password.equals(passwordTrue);
    }


    /**
     * Is true password boolean.
     * If the password is correct, it will return true.
     * Otherwise false
     *
     * @param password the password
     * @param username the username
     * @return the boolean
     */
    public static boolean isTruePasswordByUsername(String password, String username) {
        if (password == null || username == null) return false;

        boolean out = false;
        String passwordTrue = "";
        username = username.trim();
        if (password.length() < 3 || username.length() < 3) {
            return false;
        }

        try {
            passwordTrue = getPasswordByUsername(username);
        } catch (SQLException e) {
            log.error(e);
        }
        return password.equals(passwordTrue);
    }

    /**
     * Is email exists boolean.
     * If the email is exists, it will return true.
     * Otherwise false
     *
     * @param email the email
     * @return the boolean
     * @throws SQLException the sql exception
     */
    public static boolean isEmailExists(String email) throws SQLException {
        boolean out = true;
        String tmp = null;
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `email` = '" + email + "'");
        while (rs.next()) {
            tmp = rs.getString("email");
        }
        return !isNull(tmp);
    }

    /**
     * Is username exists boolean.
     * Is Username exists boolean.
     * If the email is exists, it will return true.
     *
     * @param username the username
     * @return the boolean
     * @throws SQLException the sql exception
     */
    public static boolean isUsernameExists(String username) throws SQLException {
        boolean out = true;
        String tmp = null;
        ResultSet rs = null;
        connection = getConnection();
        Statement statement = connection.createStatement();
        rs = statement.executeQuery("SELECT * FROM user  WHERE `username` = '" + username + "'");
        while (rs.next()) {
            tmp = rs.getString("username");
        }
        return !isNull(tmp);
    }

    /**
     * Get user by user id user.
     *
     * @param id the id
     * @return the user
     */
    public static User getUserByUserId(int id) {
        ResultSet rs = null;
        connection = getConnection();
        try {
            Statement statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM user  WHERE `id` = '" + id + "'");
        } catch (SQLException e) {
            log.error(e);
        }
        User user = null;
        try {
            while (rs.next()) {
                String email = rs.getString("email");
                int role = Integer.parseInt(rs.getString("role_id"));
                String username = rs.getString("username");
                String language = rs.getString("language");
                user = new User(username, email, id, role, language);
            }
        } catch (SQLException e) {
            log.error(e);
        }
        return user;
    }

    /**
     * Change role by id boolean.
     *
     * @param id   the id
     * @param role the role
     * @return the boolean
     */
    public static boolean changeRoleById(int id, UserRole role) {
        int role_id = role.getId();
        if (role_id != 2 && role_id != 3) {
            return false;
        }
        boolean out = false;
        Statement statement = null;
        Connection connection = getConnection();
        String sql = "UPDATE `restaurant`.`user` SET `role_id` = '" + role_id + "' WHERE (`id` = '" + id + "');";
        try {
            statement = connection.createStatement();
            statement.executeUpdate(sql);
            out = true;
        } catch (SQLException e) {
            log.error(e);
        }
        return out;
    }


    public static boolean changeLanguageById(int id, String language) {
        boolean out = false;
        if (language.equalsIgnoreCase("en_US") || language.equalsIgnoreCase("uk_UA")) {
            Statement statement = null;
            Connection connection = getConnection();
            String sql = "UPDATE `restaurant`.`user` SET `language` = '" + language + "' WHERE (`id` = '" + id + "');";
            try {
                statement = connection.createStatement();
                statement.executeUpdate(sql);
                out = true;
            } catch (SQLException e) {
                log.error(e);
            }
        }
        return out;
    }

    /**
     * Change role by username boolean.
     * If the change is successful successfully return the true.
     * Otherwise False
     *
     * @param username the username
     * @param role     the role
     * @return the boolean
     */
    public static boolean changeRoleByUsername(String username, UserRole role) {
        int role_id = role.getId();
        if (role_id != 2 && role_id != 3) {
            return false;
        }
        boolean out = false;
        Statement statement = null;
        Connection connection = getConnection();
        String sql = "UPDATE `restaurant`.`user` SET `role_id` = '" + role_id + "' WHERE (`username` = '" + username + "');";
        try {
            statement = connection.createStatement();
            statement.executeUpdate(sql);
            out = true;
        } catch (SQLException e) {
            log.error(e);
        }
        return out;
    }

}
