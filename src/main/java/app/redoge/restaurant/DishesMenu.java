package app.redoge.restaurant;

public enum DishesMenu{
    Salad(1), MainDishes(2), desserts(3), Drinks(4), Unknown(5);
    int id;
    DishesMenu(int id) {
        this.id = id;
    }

    public static DishesMenu getDishesCategory(int role){
        if (role == 1) return Salad;
        if (role == 2) return MainDishes;
        if (role == 3) return desserts;
        else if(role == 4) return Drinks;
        else return Unknown;
    }

    public int getId() {
        return id;
    }
}
