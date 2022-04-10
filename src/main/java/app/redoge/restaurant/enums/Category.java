package app.redoge.restaurant.enums;

/**
 * The enum Category.
 */
public enum Category {
    /**
     * Salad category.
     */
    Salad(1),
    /**
     * Main dishes category.
     */
    MainDishes(2),
    /**
     * Desserts category.
     */
    Desserts(3),
    /**
     * Drinks category.
     */
    Drinks(4),
    /**
     * Unknown category.
     */
    Unknown(5);
    /**
     * The Id.
     */
    int id;
    Category(int id) {
        this.id = id;
    }

    /**
     * Get dishes Category.
     *
     * @param role the role
     * @return the category
     */
    public static Category getDishesCategory(int role){
        if (role == 1) return Salad;
        if (role == 2) return MainDishes;
        if (role == 3) return Desserts;
        if(role == 4) return Drinks;
        else return Unknown;
    }

    public static int getDishesCategoryIdByNames(String role){
        if(role == null) return 0;
        if (role.equalsIgnoreCase("salad")) return 1;
        if (role.equalsIgnoreCase("maindishes")) return 2;
        if (role.equalsIgnoreCase("desserts")) return 3;
        if(role.equalsIgnoreCase("drinks")) return 4;
        else return 0;
    }

    /**
     * Get dishes category to String.
     *
     * @param role the role
     * @return the string
     */
    public static String getDishesCategoryToString(int role){
       return getDishesCategory(role).toString();
    }

    /**
     * Gets id.
     *
     * @return the id
     */
    public  int getId() {
        return id;
    }
}