package app.redoge.restaurant;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class OrderTest {

    Order orderNotFull = new Order(1, 2, 3);
    Order order = new Order(1,2,3,4, "Dish", Order.orderStatus.COOK, 50);

    @Test
    void getPrice() {
        assertEquals(50*2, order.getPrice());
    }

    @Test
    void getDishes_id() {
        assertEquals(1, order.getDishes_id());
    }

    @Test
    void getCount() {
        assertEquals(2, order.getCount());
    }

    @Test
    void getUser_id() {
        assertEquals(3, order.getUser_id());
    }

    @Test
    void getOrder_id() {
        assertEquals(4, order.getOrder_id());
    }

    @Test
    void getName() {
        assertEquals("Dish", order.getName());
    }

    @Test
    void getStatus() {
        assertEquals(Order.orderStatus.COOK, order.getStatus());
    }

    @Test
    void setOrder_id() {
        order.setOrder_id(5);
        assertEquals(5, order.getOrder_id());
    }
    @Test
    void getStatusEnum(){
        assertEquals(Order.orderStatus.NEW, Order.orderStatus.getStatus("NEW"));
        assertEquals(Order.orderStatus.COOK, Order.orderStatus.getStatus("COOK"));
        assertEquals(Order.orderStatus.DELIVERY, Order.orderStatus.getStatus("DELIVERY"));
        assertEquals(Order.orderStatus.DONE, Order.orderStatus.getStatus("Done"));
    }


    @Test
    void testToString() {
        assertEquals("4 Dish 2 3 1 COOK", order.toString());
    }
}