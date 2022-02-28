package app.redoge.restaurant;

import app.redoge.restaurant.interfaces.UserInterface;

public class User implements UserInterface {

    String username;
    String email;
    int id;
    int role;

    public User(String username, String email, int id, int role) {
        this.username = username;
        this.email = email;
        this.id = id;
        this.role = role;
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


}
