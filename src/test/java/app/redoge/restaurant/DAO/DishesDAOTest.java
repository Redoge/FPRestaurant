package app.redoge.restaurant.DAO;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class DishesDAOTest {

    @Test
    void setDishes() {
        assertFalse(DishesDAO.setDishes("Name", 50., 10));
        assertTrue(DishesDAO.setDishes("Coffe", 50., 4));
    }

    @Test
    void rmDish() {
        assertTrue(DishesDAO.rmDish(10));
    }

    @Test
    void isExistDishes() {
        assertTrue(DishesDAO.isExistDishes("Брауні"));
        assertFalse(DishesDAO.isExistDishes("Брауні2"));
    }

//    @Test
//    void getAllMenuMap() {
//
//    }

    @Test
    void getNameDishById() {
        assertEquals("Брауні", DishesDAO.getNameDishById(8));
    }

    @Test
    void getPriceDishById() {
        assertEquals(115, DishesDAO.getPriceDishById(8));
    }

//    @Test
//    void getDishIdBySorted() {
//    }
}