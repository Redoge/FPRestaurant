package app.redoge.restaurant.interfaces;

import app.redoge.restaurant.Order;

public interface OrderInterface {
    void setOrder_id (int order_id );

    int getDishes_id();

    int getCount();

    int getUser_id();

    int getOrder_id();

    String getName();

    Order.orderStatus getStatus();

    @Override
    String toString();

}
