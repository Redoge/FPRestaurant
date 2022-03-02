package app.redoge.restaurant.interfaces;

import app.redoge.restaurant.Order;

/**
 * The interface Order interface.
 * He described the most important methods of the object of the Order
 * @author Redoge
 * @version 1.0
 */
public interface OrderInterface {
    /**
     * Gets Price.
     * @return the Price: double
     */
    double getPrice();

    /**
     * Sets order id.
     * @param order_id the order id
     */

    void setOrder_id (int order_id );

    /**
     * Gets dishes id.
     * @return the dishes id: int
     */
    int getDishes_id();

    /**
     * Gets count.
     * @return the count: int
     */
    int getCount();

    /**
     * Gets user id.
     * @return the user id: int
     */
    int getUser_id();

    /**
     * Gets order id.
     * @return the order id: int
     */
    int getOrder_id();

    /**
     * Gets name.
     * @return the name: String
     */
    String getName();

    /**
     * Gets status.
     * @return the status: Order.orderStatus
     */
    Order.orderStatus getStatus();

    @Override
    String toString();

}
