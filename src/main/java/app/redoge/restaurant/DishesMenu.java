package app.redoge.restaurant;

public enum DishesMenu{
    Salad(1), MainDishes(2), Desserts(3), Drinks(4), Unknown(5);
    int id;
    DishesMenu(int id) {
        this.id = id;
    }

    public static DishesMenu getDishesCategory(int role){
        if (role == 1) return Salad;
        if (role == 2) return MainDishes;
        if (role == 3) return Desserts;
        if(role == 4) return Drinks;
        else return Unknown;
    }

    public static String getDishesCategoryToString(int role){
       return getDishesCategory(role).toString();
    }

    public  int getId() {
        return id;
    }
}