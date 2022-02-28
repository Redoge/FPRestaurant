package app.redoge.restaurant.servlets;

import app.redoge.restaurant.Order;
import app.redoge.restaurant.User;
import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import static app.redoge.restaurant.DAO.OrderDAO.newOrder;
import static app.redoge.restaurant.DAO.UserDao.getUser;

public class NewOrder extends HttpServlet {
    private static final Logger log = Logger.getLogger(NewOrder.class);
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final UserRole role = (UserRole) req.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)) {
            log.info("Access denied or role is null");
            resp.sendRedirect(req.getContextPath());
        }

        boolean isGood = true;
        String err = "";
        Order order = null;

        String dishIdString = req.getParameter("id");
        String countString = req.getParameter("count");
        int dishId = 0;
        int count = 0;
        if (dishIdString == null || countString == null || countString.length() < 1 || dishIdString.length() < 1) {
            log.info("Parameter is null or empty");
            err = "Error";
            isGood = false;
        } else {
            try {
                dishId = Integer.parseInt(dishIdString);
                count = Integer.parseInt(countString);
            } catch (NumberFormatException e) {
                log.error(e);
                isGood = false;
                err = "Error. Please enter the number!";
            }
        }
        String email = (String) req.getSession().getAttribute("email");
        User user = null;
        try {
            user = getUser(email);
        } catch (SQLException e) {
            log.info(e);
            isGood = false;
            e.printStackTrace();
        }
        if (user == null) {
            log.info("User not found");
            err = "Error";
            isGood = false;
        }

        if (isGood) {
            order = new Order(dishId, count, user.getId());
        }
        if (isGood) {
            log.info("Try make new order and try added to db");
            isGood = newOrder(order);
        }
        if (!isGood) {
            if (err.length() == 0) {
                err = "Error";
            }
            log.info("Error added new order");
            req.setAttribute("info", err);
            req.getRequestDispatcher("/user/new-order").forward(req, resp);
        } else {
            log.info("Added new order");
            req.setAttribute("info", "Order accepted");
            req.getRequestDispatcher("/user/orders").forward(req, resp);
        }


    }
}
