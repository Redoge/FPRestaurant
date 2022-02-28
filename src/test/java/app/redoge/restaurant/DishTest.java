package app.redoge.restaurant;

import app.redoge.restaurant.enums.Category;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class DishTest {

    int id = 1;
    int category_id = 4;
    double price = 20;
    String name = "Coffe";
    Category category = Category.Drinks;

    Dish dishFull = new Dish(id, name, category_id, category, price);
    Dish dishNotCategory = new Dish(id, name, category_id,  price);
    Dish dishNotCategoryNotId = new Dish(name, category_id,  price);

    @Test
    void getId() {
        assertEquals(1, dishFull.getId());
        assertEquals(1, dishNotCategory.getId());
        assertEquals(0, dishNotCategoryNotId.getId());

    }

    @Test
    void getName() {
        assertEquals("Coffe", dishFull.getName());
        assertEquals("Coffe", dishNotCategory.getName());
        assertEquals("Coffe", dishNotCategoryNotId.getName());
    }

    @Test
    void getCategory_id() {
        assertEquals(4, dishFull.getCategory_id());
        assertEquals(4, dishNotCategory.getCategory_id());
        assertEquals(4, dishNotCategoryNotId.getCategory_id());
    }

    @Test
    void getCategory() {
        assertEquals(Category.Drinks, dishFull.getCategory());
        assertEquals(Category.Drinks, dishNotCategory.getCategory());
        assertEquals(Category.Drinks, dishNotCategoryNotId.getCategory());
    }

    @Test
    void getPrice() {
        assertEquals(20, dishFull.getPrice());
        assertEquals(20, dishNotCategory.getPrice());
        assertEquals(20, dishNotCategoryNotId.getPrice());
    }
}