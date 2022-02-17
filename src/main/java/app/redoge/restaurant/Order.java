package app.redoge.restaurant;

public class Order {
    int dishes_id;
    int count;
    int user_id;
    int order_id = -1;
    String name = "";
    orderStatus status;


    public Order(int dishes_id, int count, int user_id) {
        this.dishes_id = dishes_id;
        this.count = count;
        this.user_id = user_id;
        this.status = orderStatus.NEW;
    }
    public Order(int dishes_id, int count, int user_id,
                 int order_id, String name, orderStatus status) {
        this.dishes_id = dishes_id;
        this.count = count;
        this.user_id = user_id;
        this.status = status;
        this.name = name;
        this.order_id = order_id;
    }

    public void setOrder_id (int order_id ) {
        this.dishes_id = order_id;
    }

    public int getDishes_id() {
        return dishes_id;
    }

    public int getCount() {
        return count;
    }

    public int getUser_id() {
        return user_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public String getName() {
        return name;
    }

    public orderStatus getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "" + order_id + " " + name + " " + count + " " + user_id + " " +
        dishes_id + " " + status;
    }

    public enum orderStatus{
        NEW, COOK, DELIVERY, DONE;

        public static orderStatus getStatus(String str){
            if(str.equalsIgnoreCase("NEW")) return NEW;
            if(str.equalsIgnoreCase("COOK")) return COOK;
            if(str.equalsIgnoreCase("DELIVERY")) return DELIVERY;
            else return DONE;
        }

    }

}
