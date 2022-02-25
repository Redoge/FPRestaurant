package app.redoge.restaurant;

/**
 * A class to create a 'Dish' object for easier data handling
 * @author Redoge
 * @version 1.0 10/02/20
 */

public class Dish {
        private int id;
        private String name;
        private int category_id;
        private DishesMenu category;
        private double price;
    /**
     * Constructor
     * @param id- Id of the object in the database
     * @param name - The name of the object in the database
     * @param category_id Category id of the object in the database
     * @param category Category of the object in the database -> {@code DishesMenu}
     * @param price Price of the object in the database
     * @see Dish#Dish(int, String, int, double)
     * @see Dish#Dish(String, int, double)
     */
    public Dish(int id, String name, int category_id, DishesMenu category, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.category = category;
        this.price = price;
    }

    /**
     * Constructor
     * @param id- Id of the object in the database
     * @param name - The name of the object in the database
     * @param category_id Category id of the object in the database
     * @param price Price of the object in the database
     * @see Dish#Dish(int, String, int, DishesMenu, double)
     * @see Dish#Dish(String, int, double)
     */
    public Dish(int id, String name, int category_id, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = DishesMenu.getDishesCategory(category_id);
    }

    /**
     * Constructor
     * @param name - The name of the object in the database
     * @param category_id Category id of the object in the database
     * @param price Price of the object in the database
     * @see Dish#Dish(int, String, int, DishesMenu, double)
     * @see Dish#Dish(int, String, int, double)
     */

    public Dish( String name, int category_id, double price) {
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = DishesMenu.getDishesCategory(category_id);
    }

    /**
     *Method of obtaining the object ID
     * @return Dish id in the database -> {@code int}
     */

    public int getId() {
        return id;
    }
    /**
     * Method of obtaining the name of the object
     * @return Object name -> {@code String}
     */
    public String getName() {
        return name;
    }

    /**
     * Method of obtaining the category id of the object
     * @return Object category id -> {@code int}
     */

    public int getCategory_id() {
        return category_id;
    }

    /**
     * Method of obtaining the category of the object
     * @return Object category  -> {@code DishesMenu}
     */

    public DishesMenu getCategory() {
        return category;
    }

    /**
     * Method of obtaining the price of the object
     * @return Object price -> {@code double}
     */

    public double getPrice() {
        return price;
    }
}
