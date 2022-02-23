package app.redoge.restaurant.DAO;

import app.redoge.restaurant.Dish;
import app.redoge.restaurant.DishesMenu;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Locale;
import java.util.Map;

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

   public static boolean rmDish(Integer id){
       boolean out = false;
       Statement statement = null;
       Connection connection = getConnection();
       System.out.println(id);
       String sql = "DELETE FROM `dishes` WHERE (`id` = '"+ id +"');";
       try {
           statement = connection.createStatement();
           statement.executeUpdate(sql);
           out = true;
       } catch (SQLException e) {
           e.printStackTrace();
           return out;
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

   public static Map<Integer, String> getAllMenuMap(){
       Map<Integer, String> out = new HashMap<>();
       ResultSet rs = null;
       Connection connection = getConnection();
       Statement statement = null;
       try {
           statement = connection.createStatement();
           rs = statement.executeQuery("SELECT * FROM dishes");
           while(rs.next()) {
               out.put(rs.getInt("id"), rs.getString("name"));
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return out;
   }

   public static String getNameDishById(int id){
       String out = "";
       ResultSet rs = null;
       Connection connection = getConnection();
       Statement statement = null;
       try {
           statement = connection.createStatement();
           rs = statement.executeQuery("SELECT * FROM dishes WHERE `id` = "+id+";");
           while(rs.next()) {
               out = rs.getString("name");
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return out;
   }

   public static double getPriceDishById(int id){
       double out = 0;
       ResultSet rs = null;
       Connection connection = getConnection();
       Statement statement = null;
       try {
           statement = connection.createStatement();
           rs = statement.executeQuery("SELECT * FROM dishes WHERE `id` = "+id+";");
           while(rs.next()) {
               out = rs.getDouble("price");
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return out;
   }

//   public static Map<Integer, Map<String, Double>> getAllMenuMapWithPrice(String category){
//       Map<String, Map<String, Double>> out = new HashMap<>();
//       ResultSet rs = null;
//       Connection connection = getConnection();
//       Statement statement = null;
//       try {
//           statement = connection.createStatement();
//           rs = statement.executeQuery("SELECT * FROM dishes ORDER BY " + category.toLowerCase(Locale.ROOT) + ";");
////           System.out.println("SELECT * FROM dishes ORDER BY " + category.toLowerCase(Locale.ROOT) );
//           while(rs.next()) {
//               Map<String, Double> tmp =  new HashMap<>();
//               tmp.put(DishesMenu.getDishesCategoryToString(rs.getInt("category_id")), rs.getDouble("price"));
//               out.put(rs.getString("name"), tmp);
//           }
//       } catch (SQLException e) {
//           e.printStackTrace();
//       }
//       return out;
//   }

   public static LinkedList<Integer> getDishIdBySortedListId(String category){
       LinkedList<Integer> out = new LinkedList<>();
       ResultSet rs = null;
       Connection connection = getConnection();
       Statement statement = null;
       try {
           statement = connection.createStatement();
           rs = statement.executeQuery("SELECT * FROM dishes ORDER BY " + category.toLowerCase(Locale.ROOT) + ";");
           System.out.println("SELECT * FROM dishes ORDER BY " + category.toLowerCase(Locale.ROOT) + ";" );
           while(rs.next()) {
               System.out.println(rs.getString("name"));
               out.add(rs.getInt("id"));
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return out;
   }

    public static Map<Integer, Dish> getDishIdBySorted(String category){
        Map<Integer, Dish> out = new HashMap<>();
        ResultSet rs = null;
        Connection connection = getConnection();
        Statement statement = null;
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM dishes ORDER BY " + category.toLowerCase(Locale.ROOT) + ";");
            System.out.println("SELECT * FROM dishes ORDER BY " + category.toLowerCase(Locale.ROOT) + ";" );
            while(rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int category_id = rs.getInt("category_id");
                double price = rs.getDouble("price");
                Dish tmp = new Dish(id, name, category_id, price);
                out.put(id, tmp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return out;
    }

    public static void main(String[] args) {
        System.out.println(getDishIdBySorted("category_id"));
    }

}
