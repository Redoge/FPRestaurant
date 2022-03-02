package app.redoge.restaurant.DAO;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * The type Dishes dao test.
 */
class DishesDAOTest {

    /**
     * Sets dishes TEST.
     */
    @Test
    void setDishes() {
        assertFalse(DishesDAO.setDishes("Name", 50., 10));
        assertTrue(DishesDAO.setDishes("Coffe", 50., 4));
    }

    /**
     * Rm dish TEST.
     */
    @Test
    void rmDish() {
        assertTrue(DishesDAO.rmDish(10));
    }

    /**
     * Is exist dishes TEST.
     */
    @Test
    void isExistDishes() {
        assertTrue(DishesDAO.isExistDishes("Брауні"));
        assertFalse(DishesDAO.isExistDishes("Брауні2"));
    }

    /**
     * Gets name dish by id TEST.
     */
    @Test
    void getNameDishById() {
        assertEquals("Брауні", DishesDAO.getNameDishById(8));
    }

    /**
     * Gets price dish by id TEST.
     */
    @Test
    void getPriceDishById() {
        assertEquals(115, DishesDAO.getPriceDishById(8));
    }

}