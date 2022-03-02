package app.redoge.restaurant;

import app.redoge.restaurant.enums.Category;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * The type Dishes menu test.
 */
class DishesMenuTest {

    private final int category_id = 4;

    /**
     * Gets dishes category TEST.
     */
    @Test
    void getDishesCategory() {
        assertEquals(Category.Drinks,
                Category.getDishesCategory(category_id));
        assertEquals(Category.Unknown, Category.getDishesCategory(category_id+5));
    }

    /**
     * Gets dishes category to string TEST.
     */
    @Test
    void getDishesCategoryToString() {
        assertEquals("Drinks",
                Category.getDishesCategoryToString(category_id));
    }

    /**
     * Gets id TEST.
     */
    @Test
    void getId() {
        assertEquals(4, Category.Drinks.getId());
    }
}