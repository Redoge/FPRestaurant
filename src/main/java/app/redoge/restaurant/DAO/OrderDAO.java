package app.redoge.restaurant.DAO;

import app.redoge.restaurant.Order;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static app.redoge.restaurant.DAO.DishesDAO.getNameDishById;
import static app.redoge.restaurant.DAO.DishesDAO.getPriceDishById;
import static app.redoge.restaurant.DAO.UserDao.getConnection;

public class OrderDAO {


    public static boolean newOrder(Order order){
        boolean out = false;
        Statement statement = null;
        ResultSet rs = null;
        Connection connection = getConnection();
        String dish = getNameDishById(order.getDishes_id());
        double price = getPriceDishById(order.getDishes_id());
        System.out.println(order);
        String sql = "INSERT `order`(`count`, `user_id`, `dishes_id`, `status`, `dish`, `price`) VALUE"+
                "("+order.getCount()+","+order.getUser_id()+", "+
                order.getDishes_id()+", '"+ order.getStatus()+"','"+dish+"',"+price+")";
        System.out.println(sql);
        try {
            statement = connection.createStatement();
            statement.executeUpdate(sql);
            out = true;
        } catch (SQLException e) {
            out = false;
            e.printStackTrace();
        }
        if (out) {


            try {
                int id = 0;
                statement = connection.createStatement();
                rs = statement.executeQuery("SELECT * FROM `order`");
                System.out.println(rs);
                while (rs.next()) {
                    id = rs.getInt("id");
                }
                order.setOrder_id(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }

        return out;
    }

    public static Order getOrder(int id){
        Order order = null;
        ResultSet rs = null;
        Connection connection = getConnection();
        Statement statement = null;
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM `order` WHERE `id` = "+id+";");
            while(rs.next()) {
                String name = rs.getString("dish");
                int dishes_id = rs.getInt("dishes_id");
                int count = rs.getInt("count");
                int user_id = rs.getInt("user_id");
                int order_id = rs.getInt("id");
                double price = rs.getDouble("price");
                Order.orderStatus status = Order.orderStatus.getStatus(rs.getString("status"));
                order = new Order(dishes_id, count, user_id,order_id, name, status, price);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public static List<Order> getOrdersByUserId(int id){
        ArrayList<Order> orders = new ArrayList<>();
        ResultSet rs = null;
        Connection connection = getConnection();
        Statement statement = null;
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM `order` WHERE `user_id` = "+id+";");
            while(rs.next()) {
                String name = rs.getString("dish");
                int dishes_id = rs.getInt("dishes_id");
                int count = rs.getInt("count");
                int user_id = rs.getInt("user_id");
                int order_id = rs.getInt("id");
                double price = rs.getDouble("price");
                Order.orderStatus status = Order.orderStatus.getStatus(rs.getString("status"));
                orders.add(new Order(dishes_id, count, user_id,order_id, name, status, price));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
          return orders;
    }

    public static void main(String[] args) {

        List<Order> orders = getOrdersByUserId(2);
        for(Order order: orders){
            System.out.println(order.getName());
        }
    }

}
