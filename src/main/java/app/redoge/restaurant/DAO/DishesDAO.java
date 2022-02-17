package app.redoge.restaurant.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static app.redoge.restaurant.DAO.UserDao.getConnection;
import static java.util.Objects.isNull;

public class DishesDAO {

   public static boolean setDishes(String name, double price, int category){
       if(name == null || price == 0|| category < 1 || category > 5  || name.length() < 3) return false;

       boolean out = false;
       Statement statement = null;
       Connection connection = getConnection();
       String sql = "INSERT dishes(name, category_id, price) VALUES"+
               "('"+name+"', "+category+", '"+price+"')";
       try {
           statement = connection.createStatement();
           statement.executeUpdate(sql);
           out = true;
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return out;
    }


   public static boolean isExistDishes(String name){
       String tmp = null;
       ResultSet rs = null;
       Connection connection = getConnection();
       Statement statement = null;
       try {
           statement = connection.createStatement();
           rs = statement.executeQuery("SELECT * FROM dishes  WHERE `name` = '"+name+"'");
           while(rs.next()) {
               tmp = rs.getString("name");
           }
       } catch (SQLException e) {
           e.printStackTrace();
           return true;
       }

       return !isNull(tmp);
   }

}
