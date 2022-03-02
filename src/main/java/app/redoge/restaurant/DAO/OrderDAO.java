package app.redoge.restaurant.DAO;

import app.redoge.restaurant.Order;
import org.apache.log4j.Logger;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import static app.redoge.restaurant.DAO.ConnectDB.getConnection;
import static app.redoge.restaurant.DAO.DishesDAO.getNameDishById;
import static app.redoge.restaurant.DAO.DishesDAO.getPriceDishById;


/**
 * The type Order dao.
 */
public class OrderDAO {
    private static final Logger log = Logger.getLogger(OrderDAO.class);

    /**
     * New order boolean.
     * If the addition is successful, the return is true.
     * If the addition is not successful, it is not true to return
     *
     * @param order the order
     * @return the boolean
     */
    public static boolean newOrder(Order order){
        boolean out = false;
        Statement statement = null;
        ResultSet rs = null;
        Connection connection = getConnection();
        String dish = getNameDishById(order.getDishes_id());
        double price = getPriceDishById(order.getDishes_id());
        String sql = "INSERT `order`(`count`, `user_id`, `dishes_id`, `status`, `dish`, `price`) VALUE"+
                "("+order.getCount()+","+order.getUser_id()+", "+
                order.getDishes_id()+", '"+ order.getStatus()+"','"+dish+"',"+price+")";
        try {
            statement = connection.createStatement();
            statement.executeUpdate(sql);
            out = true;
        } catch (SQLException e) {
            log.error(e);
        }
        if (out) {
            try {
                int id = 0;
                statement = connection.createStatement();
                rs = statement.executeQuery("SELECT * FROM `order`");
                while (rs.next()) {
                    id = rs.getInt("id");
                }
                order.setOrder_id(id);
            } catch (SQLException e) {
                log.error(e);
            }

        }
        log.info("Make new order");
        return out;
    }

    /**
     * Get order by id: Return Order.
     *
     * @param id the id
     * @return the order
     */
    public static Order getOrderById(int id){
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
            log.error(e);
        }
        return order;
    }

    /**
     * Get orders by user id: Return List<Order>.
     *
     * @param id the id
     * @return the list
     */
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
            log.error(e);
        }
          return orders;
    }

    /**
     * Get all orders array: Return List<Order>.
     *
     * @return the array list
     */
    public static ArrayList<Order> getAllOrders(){
        ArrayList<Order> orders = new ArrayList<>();
        ResultSet rs = null;
        Connection connection = getConnection();
        Statement statement = null;
        try {
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM `order`");
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
            log.error(e);
        }
        return orders;
    }

    /**
     * Change order status by id boolean.
     * If the change is successful successfully return the true.
     * Otherwise False
     * @param id        the id
     * @param newStatus the new status
     * @return the boolean
     */
    public static boolean changeOrderStatusById(int id,
                                            Order.orderStatus newStatus){
        boolean out = false;
        Statement statement = null;
        ResultSet rs = null;
        Connection connection = getConnection();
        String sql = "UPDATE `order` SET `status` ='" + newStatus + "' WHERE (`id` = '" + id + "');";
        try {
            statement = connection.createStatement();
            statement.executeUpdate(sql);
            out = true;
        } catch (SQLException e) {
            log.error(e);
        }
        log.info("Changed order status");
        return out;
    }

}
