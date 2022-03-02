package app.redoge.restaurant.enums;

/**
 * The enum User role.
 */
public enum UserRole {
    /**
     * Admin user role.
     */
    Admin(1),
    /**
     * Manager user role.
     */
    Manager(2),
    /**
     * User user role.
     */
    User(3),
    /**
     * Unknown user role.
     */
    Unknown(4);
    private int id;
    UserRole(int id) {
        this.id = id;
    }

    /**
     * Gets id.
     *
     * @return the id
     */
    public int getId() {
        return this.id;
    }

    /**
     * Get user role user role.
     *
     * @param role the role
     * @return the user role
     */
    public static UserRole getUserRole(int role){
        if (role == 1) return Admin;
        if (role == 2) return Manager;
        if (role == 3) return User;
        else return Unknown;
    }
}
