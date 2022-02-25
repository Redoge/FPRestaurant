package app.redoge.restaurant;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class DishesMenuTest {

    int category_id = 4;

    @Test
    void getDishesCategory() {
        assertEquals(DishesMenu.Drinks,
                DishesMenu.getDishesCategory(category_id));
        assertEquals(DishesMenu.Unknown, DishesMenu.getDishesCategory(category_id+5));
    }

    @Test
    void getDishesCategoryToString() {
        assertEquals("Drinks",
                DishesMenu.getDishesCategoryToString(category_id));
    }

    @Test
    void getId() {
        assertEquals(4, DishesMenu.Drinks.getId());
    }
}