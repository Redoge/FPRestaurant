package app.redoge.restaurant.interfaces;

import app.redoge.restaurant.enums.Category;

public interface DishInterface {
    int getId();

    String getName();

    int getCategory_id();

    Category getCategory();

    double getPrice();
}
