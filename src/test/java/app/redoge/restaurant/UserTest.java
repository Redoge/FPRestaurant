package app.redoge.restaurant;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserTest {

    User user = new User("Redoge", "mail.redoge@gmail.com", 1, 1);

    @Test
    void getUsername() {
        assertEquals("Redoge", user.getUsername());
    }

    @Test
    void getEmail() {
        assertEquals("mail.redoge@gmail.com", user.getEmail());
    }

    @Test
    void getId() {
        assertEquals(1, user.getId());
    }

    @Test
    void getRole() {
        assertEquals(1, user.getRole());
    }
}