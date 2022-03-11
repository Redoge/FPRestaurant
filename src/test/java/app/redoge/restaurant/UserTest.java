package app.redoge.restaurant;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * The type User test.
 */
class UserTest {

    private final User user = new User("Redoge", "mail.redoge@gmail.com", 1, 1, "en_US");

    /**
     * Gets username TEST.
     */
    @Test
    void getUsername() {
        assertEquals("Redoge", user.getUsername());
    }

    /**
     * Gets email TEST.
     */
    @Test
    void getEmail() {
        assertEquals("mail.redoge@gmail.com", user.getEmail());
    }

    /**
     * Gets id TEST.
     */
    @Test
    void getId() {
        assertEquals(1, user.getId());
    }

    /**
     * Gets role TEST.
     */
    @Test
    void getRole() {
        assertEquals(1, user.getRole());
    }
}