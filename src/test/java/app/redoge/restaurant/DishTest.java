package app.redoge.restaurant;

import app.redoge.restaurant.enums.Category;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * The type Dish test.
 */
class DishTest {

    private final int id = 1;
    private final int category_id = 4;
    private final double price = 20;
    private final String name = "Coffe";
    private final Category category = Category.Drinks;

    private final Dish dishFull = new Dish(id, name, category_id, category, price);
    private final Dish dishNotCategory = new Dish(id, name, category_id,  price);
    private final Dish dishNotCategoryNotId = new Dish(name, category_id,  price);

    /**
     * Gets id TEST.
     */
    @Test
    void getId() {
        assertEquals(1, dishFull.getId());
        assertEquals(1, dishNotCategory.getId());
        assertEquals(0, dishNotCategoryNotId.getId());

    }

    /**
     * Gets name TEST.
     */
    @Test
    void getName() {
        assertEquals("Coffe", dishFull.getName());
        assertEquals("Coffe", dishNotCategory.getName());
        assertEquals("Coffe", dishNotCategoryNotId.getName());
    }

    /**
     * Gets category id TEST.
     */
    @Test
    void getCategory_id() {
        assertEquals(4, dishFull.getCategory_id());
        assertEquals(4, dishNotCategory.getCategory_id());
        assertEquals(4, dishNotCategoryNotId.getCategory_id());
    }

    /**
     * Gets category TEST.
     */
    @Test
    void getCategory() {
        assertEquals(Category.Drinks, dishFull.getCategory());
        assertEquals(Category.Drinks, dishNotCategory.getCategory());
        assertEquals(Category.Drinks, dishNotCategoryNotId.getCategory());
    }

    /**
     * Gets price TEST.
     */
    @Test
    void getPrice() {
        assertEquals(20, dishFull.getPrice());
        assertEquals(20, dishNotCategory.getPrice());
        assertEquals(20, dishNotCategoryNotId.getPrice());
    }
}