package app.redoge.restaurant;

public enum UserRole {
    Admin(1), Manager(2), User(3), Unknown(4);
    int id;
    UserRole(int id) {
        this.id = id;
    }

    public static UserRole getUserRole(int role){
        if (role == 1) return Admin;
        if (role == 2) return Manager;
        if (role == 3) return User;
        else return Unknown;
    }
}
