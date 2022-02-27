package app.redoge.restaurant.servlets;

import app.redoge.restaurant.Order;
import app.redoge.restaurant.User;
import app.redoge.restaurant.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import static app.redoge.restaurant.DAO.OrderDAO.newOrder;
import static app.redoge.restaurant.DAO.UserDao.getUser;

public class NewOrder extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final UserRole role = (UserRole) req.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)) {
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
            err = "Error";
            isGood = false;
        } else {
            try {
                dishId = Integer.parseInt(dishIdString);
                count = Integer.parseInt(countString);
            } catch (NumberFormatException e) {
                isGood = false;
                err = "Error. Please enter the number!";
            }
        }
        String email = (String) req.getSession().getAttribute("email");
        User user = null;
        try {
            user = getUser(email);
        } catch (SQLException e) {
            isGood = false;
            e.printStackTrace();
        }
        if (user == null) {
            err = "Error";
            isGood = false;
        }

        if (isGood) {
            order = new Order(dishId, count, user.getId());
        }
        System.out.println(order);
        if (isGood) {
            isGood = newOrder(order);
        }
        if (!isGood) {
            if (err.length() == 0) {
                err = "Error";
            }
            req.setAttribute("info", err);
            req.getRequestDispatcher("/user/new-order").forward(req, resp);
        } else {
            req.setAttribute("info", "Order accepted");
            req.getRequestDispatcher("/user/orders").forward(req, resp);
        }


    }
}
