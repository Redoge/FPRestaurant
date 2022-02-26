package app.redoge.restaurant;

/**
 * Клас для створення об'єкта 'Dish' - страва, що включає в себе : /int id/, /String name/, /int category_id/, /DishesMenu category/, /double price/.
 * @author Redoge
 * @version 1.0 10/02/20
 */

public class Dish {
        private int id;
        private String name;
        private int category_id;
        private Category category;
        private double price;
    /**
     * Конструктор, що включає всі параметри об'єкта
     * @param id- Id of the object in the database
     * @param name - The name of the object in the database
     * @param category_id Category id of the object in the database
     * @param category Category of the object in the database -> {@code DishesMenu}
     * @param price Price of the object in the database
     * @see Dish#Dish(int, String, int, double)
     * @see Dish#Dish(String, int, double)
     */
    public Dish(int id, String name, int category_id, Category category, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.category = category;
        this.price = price;
    }

    /**
     * Конструктор, що включає не всі параметри об'єкта, крім /DishesMenu category/
     * @param id- Id of the object in the database
     * @param name - The name of the object in the database
     * @param category_id Category id of the object in the database
     * @param price Price of the object in the database
     * @see Dish#Dish(int, String, int, Category, double)
     * @see Dish#Dish(String, int, double)
     */
    public Dish(int id, String name, int category_id, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = Category.getDishesCategory(category_id);
    }

    /**
     * Конструктор, що включає не всі параметри об'єкта, крім /DishesMenu category/, /int id/.
     * @param name - The name of the object in the database
     * @param category_id Category id of the object in the database
     * @param price Price of the object in the database
     * @see Dish#Dish(int, String, int, Category, double)
     * @see Dish#Dish(int, String, int, double)
     */

    public Dish( String name, int category_id, double price) {
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = Category.getDishesCategory(category_id);
    }

    /**
     * Поле id, є ідентифікатором запису в базі даних
     * @return повертає значення поля id -> {@code int}
     */

    public int getId() {
        return id;
    }
    /**
     * Поле name, є назвою страви
     * @return Object name -> {@code String}
     */
    public String getName() {
        return name;
    }

    /**
     * Поле category_id, є значенням ідентифікатора категорії страви в базі даних
     * @return повертає значення поля category_id -> {@code int}
     */

    public int getCategory_id() {
        return category_id;
    }

    /**
     * Поле category, є значенням категорії страви
     * @return повертає значення поля category  -> {@code Category}
     */

    public Category getCategory() {
        return category;
    }

    /**
     * Поле Price, є значенням ціни страви
     * @return повертає значення поля -> {@code double}
     */

    public double getPrice() {
        return price;
    }
}
