package app.redoge.restaurant;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * The type Order test.
 */
class OrderTest {

    private final Order orderNotFull = new Order(1, 2, 3);
    private final Order order = new Order(1,2,3,4, "Dish", Order.orderStatus.COOK, 50);

    /**
     * Gets price TEST.
     */
    @Test
    void getPrice() {
        assertEquals(50*2, order.getPrice());
    }

    /**
     * Gets dishes id TEST.
     */
    @Test
    void getDishes_id() {
        assertEquals(1, order.getDishes_id());
    }

    /**
     * Gets count TEST.
     */
    @Test
    void getCount() {
        assertEquals(2, order.getCount());
    }

    /**
     * Gets user id TEST.
     */
    @Test
    void getUser_id() {
        assertEquals(3, order.getUser_id());
    }

    /**
     * Gets order id TEST.
     */
    @Test
    void getOrder_id() {
        assertEquals(4, order.getOrder_id());
    }

    /**
     * Gets name TEST.
     */
    @Test
    void getName() {
        assertEquals("Dish", order.getName());
    }

    /**
     * Gets status TEST.
     */
    @Test
    void getStatus() {
        assertEquals(Order.orderStatus.COOK, order.getStatus());
    }

    /**
     * Sets order id TEST.
     */
    @Test
    void setOrder_id() {
        order.setOrder_id(5);
        assertEquals(5, order.getOrder_id());
    }

    /**
     * Get status enum TEST.
     */
    @Test
    void getStatusEnum(){
        assertEquals(Order.orderStatus.NEW, Order.orderStatus.getStatus("NEW"));
        assertEquals(Order.orderStatus.COOK, Order.orderStatus.getStatus("COOK"));
        assertEquals(Order.orderStatus.DELIVERY, Order.orderStatus.getStatus("DELIVERY"));
        assertEquals(Order.orderStatus.DONE, Order.orderStatus.getStatus("Done"));
    }


    /**
     * Test to string TEST.
     */
    @Test
    void testToString() {
        assertEquals("4 Dish 2 3 1 COOK", order.toString());
    }
}