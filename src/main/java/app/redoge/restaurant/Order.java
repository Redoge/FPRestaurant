package app.redoge.restaurant;

import app.redoge.restaurant.interfaces.OrderInterface;

/**
 * The type Order.
 */
public class Order implements OrderInterface {

    private int dishes_id;
    private int count;
    private int user_id;
    private int order_id = -1;
    private String name = "";
    private orderStatus status;
    private double price;


    /**
     * Instantiates a new Order.
     *
     * @param dishes_id the dishes id: int
     * @param count     the count: int
     * @param user_id   the user id:int
     */
    public Order(int dishes_id, int count, int user_id) {
        this.dishes_id = dishes_id;
        this.count = count;
        this.user_id = user_id;
        this.status = orderStatus.NEW;
    }


    /**
     * Instantiates a new Order.
     *
     * @param dishes_id the dishes id: int
     * @param count     the count: int
     * @param user_id   the user id: int
     * @param order_id  the order id: int
     * @param name      the name: String
     * @param status    the status: orderStatus
     * @param price     the price: double
     */
    public Order(int dishes_id, int count, int user_id,
                 int order_id, String name, orderStatus status, double price) {
        this.dishes_id = dishes_id;
        this.count = count;
        this.user_id = user_id;
        this.status = status;
        this.name = name;
        this.order_id = order_id;
        this.price = price*count;
    }


    public double getPrice() {
        return price;
    }

    public void setOrder_id (int order_id ) {
        this.order_id = order_id;
    }

    public int getDishes_id() {
        return dishes_id;
    }

    public int getCount() {
        return count;
    }

    public int getUser_id() {
        return user_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public String getName() {
        return name;
    }

    public orderStatus getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "" + order_id + " " + name + " " + count + " " + user_id + " " +
        dishes_id + " " + status;
    }

    /**
     * The enum Order status.
     */
    public enum orderStatus{
        /**
         * New order status.
         */
        NEW,
        /**
         * Cook order status.
         */
        COOK,
        /**
         * Delivery order status.
         */
        DELIVERY,
        /**
         * Done order status.
         */
        DONE;

        /**
         * Get status order status.
         *
         * @param str the str
         * @return the order status
         */
        public static orderStatus getStatus(String str){
            if(str.equalsIgnoreCase("NEW")) return NEW;
            if(str.equalsIgnoreCase("COOK")) return COOK;
            if(str.equalsIgnoreCase("DELIVERY")) return DELIVERY;
            else return DONE;
        }

    }


}
