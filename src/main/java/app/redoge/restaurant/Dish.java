package app.redoge.restaurant;

public class Dish {
        private int id;
        private String name;
        private int category_id;
        private DishesMenu category;
        private double price;

    public Dish(int id, String name, int category_id, DishesMenu category, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.category = category;
        this.price = price;
    }
    public Dish(int id, String name, int category_id, double price) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = DishesMenu.getDishesCategory(category_id);
    }

    public Dish( String name, int category_id, double price) {
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.category = DishesMenu.getDishesCategory(category_id);
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

    public DishesMenu getCategory() {
        return category;
    }

    public double getPrice() {
        return price;
    }
}
