package app.redoge.restaurant;

import app.redoge.restaurant.enums.Category;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class DishesMenuTest {

    int category_id = 4;

    @Test
    void getDishesCategory() {
        assertEquals(Category.Drinks,
                Category.getDishesCategory(category_id));
        assertEquals(Category.Unknown, Category.getDishesCategory(category_id+5));
    }

    @Test
    void getDishesCategoryToString() {
        assertEquals("Drinks",
                Category.getDishesCategoryToString(category_id));
    }

    @Test
    void getId() {
        assertEquals(4, Category.Drinks.getId());
    }
}