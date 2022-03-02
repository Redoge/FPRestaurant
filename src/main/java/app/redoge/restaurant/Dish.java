package app.redoge.restaurant;

import app.redoge.restaurant.enums.Category;
import app.redoge.restaurant.interfaces.DishInterface;


/**
 * The type Dish.
 */
public class Dish implements DishInterface {
        private int id;
        private String name;
        private int category_id;
        private Category category;
        private double price;

    /**
     * Instantiates a new Dish (Full).
     *
     * @param id          the id: int
     * @param name        the name: String
     * @param category_id the category id: int
     * @param category    the category: Category
     * @param price       the price: double
     */
    public Dish(int id, String name, int category_id, Category category, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.category = category;
        this.price = price;
    }


    /**
     * Instantiates a new Dish (In addition to the category).
     *
     * @param id          the id: int
     * @param name        the name: String
     * @param category_id the category id: int
     * @param price       the price: double
     */
    public Dish(int id, String name, int category_id, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = Category.getDishesCategory(category_id);
    }


    /**
     * Instantiates a new Dish. (In addition to the category and id)
     *
     * @param name        the name: String
     * @param category_id the category id: int
     * @param price       the price: double
     */
    public Dish( String name, int category_id, double price) {
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = Category.getDishesCategory(category_id);
    }



    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getCategory_id() {
        return category_id;
    }

    public Category getCategory() {
        return category;
    }

    public double getPrice() {
        return price;
    }
}
