package app.redoge.restaurant;

import app.redoge.restaurant.interfaces.UserInterface;

/**
 * The type User.
 */
public class User implements UserInterface {

    private String username;
    private String email;
    private int id;
    private int role;
    private String language;

    /**
     * Instantiates a new User.
     *
     * @param username the username: String
     * @param email    the email: String
     * @param id       the id: int
     * @param role     the role: int
     */
    public User(String username, String email, int id, int role, String language) {
        this.username = username;
        this.email = email;
        this.id = id;
        this.role = role;
        this.language = language;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public int getId() {
        return id;
    }

    public int getRole() {
        return role;
    }

    public String getLanguage() {
        return language;
    }


}
