package app.redoge.restaurant;

import org.junit.jupiter.api.Test;

import static app.redoge.restaurant.DishesMenu.getDishesCategory;
import static org.junit.jupiter.api.Assertions.*;

class UserRoleTest {

    @Test
    void getId() {
        assertEquals(1, UserRole.Admin.getId());
        assertEquals(2, UserRole.Manager.getId());
        assertEquals(3, UserRole.User.getId());
        assertEquals(4, UserRole.Unknown.getId());
    }

    @Test
    void getUserRole() {
        assertEquals(UserRole.Admin, UserRole.getUserRole(1));
        assertEquals(UserRole.Manager,UserRole.getUserRole(2));
        assertEquals(UserRole.User, UserRole.getUserRole(3));
        assertEquals(UserRole.Unknown, UserRole.getUserRole(4));
    }
}