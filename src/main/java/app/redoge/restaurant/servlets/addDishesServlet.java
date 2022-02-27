package app.redoge.restaurant.servlets;

import app.redoge.restaurant.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import static app.redoge.restaurant.DAO.DishesDAO.isExistDishes;
import static app.redoge.restaurant.DAO.DishesDAO.setDishes;
import static app.redoge.restaurant.DAO.UserDao.*;


public class addDishesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        boolean isGood = true;
        String err = "Error";


        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }

        final String name = request.getParameter("name");
        String priceString = request.getParameter("price");
        String categoryString = request.getParameter("category");

        double price = 0;
        int category = 5;

        if (priceString == null || categoryString == null || name == null || name.length() == 0 || priceString.length() == 0) {
            isGood = false;
            err = "Error";
        } else {
            try {
                price = Double.parseDouble(priceString);
                category = Integer.parseInt(categoryString);
            } catch (NumberFormatException e) {
                err = "Error";
                isGood = false;
            }
        }


        if (isGood) {
            if (name.trim().length() < 3 || price < 1 || category < 1 || category >= 5) {
                isGood = false;
                err = "The name of the dish must be longer than 3 characters and price must be > 1";
//                request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
            } else if (isExistDishes(name)) {
                isGood = false;
                err = "The dish exists";
//                request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
            } else if (isGood) {
                isGood = setDishes(name, price, category);
                if (isGood) {
                    request.setAttribute("info", "The dish added");
                    request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
                }
            }

        }
        if (!isGood) {
            request.setAttribute("info", err);
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }
    }
}
