package app.redoge.restaurant.interfaces;

import app.redoge.restaurant.enums.Category;

/**
 * The interface Dish.
 * He described the most important methods of the object of the dish
 * @author Redoge
 * @version 1.0
 */
public interface DishInterface {
    /**
     * Gets id.
     * @return the id: int
     */
    int getId();

    /**
     * Gets name.
     * @return the name: String
     */
    String getName();

    /**
     * Gets category id.
     * @return the category id: int
     */
    int getCategory_id();

    /**
     * Gets category.
     * @return the category: Category
     */
    Category getCategory();

    /**
     * Gets price.
     * @return the price: double
     */
    double getPrice();
}
