package app.redoge.restaurant.servlets;

import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Locale;
import java.util.ResourceBundle;

import static app.redoge.restaurant.DAO.DishesDAO.isExistDishes;
import static app.redoge.restaurant.DAO.DishesDAO.setDishes;


public class AddDishes extends HttpServlet {
    private static final Logger log = Logger.getLogger(AddDishes.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String[] lang_param =  ((String) session.getAttribute("language")).split("_");
        Locale locale = new Locale(lang_param[0], lang_param[1]);
        ResourceBundle rb = ResourceBundle.getBundle("language", locale);

        boolean isGood = true;
        String err = rb.getString("Error");


        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            log.info("Access denied or role is null");
            response.sendRedirect(request.getContextPath());
        }

        final String name = request.getParameter("name");
        String priceString = request.getParameter("price");
        String categoryString = request.getParameter("category");

        double price = 0;
        int category = 5;

        if (priceString == null || categoryString == null || name == null || name.length() == 0 || priceString.length() == 0) {
            log.info("Parameter is null or empty");
            isGood = false;
            err = rb.getString("Error");
        } else {
            try {
                price = Double.parseDouble(priceString);
                category = Integer.parseInt(categoryString);
            } catch (NumberFormatException e) {
                log.error(e);
                err = rb.getString("Error");
                isGood = false;
            }
        }


        if (isGood) {
            if (name.trim().length() < 3 || price < 1 || category < 1 || category >= 5) {
                isGood = false;
                err = rb.getString("ErrMustBeLonger3");
            } else if (isExistDishes(name)) {
                isGood = false;
                err = rb.getString("TheDishExists");
            } else if (isGood) {
                isGood = setDishes(name, price, category);
                if (isGood) {
                    log.info("Dish added: " + name);
                    response.sendRedirect(request.getContextPath() +"/manager/manage-menu?info=" +
                            new String(rb.getString("TheDishAdded").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
                }
            }

        }
        if (!isGood) {
            log.info("Dish not added: " + name);
            response.sendRedirect(request.getContextPath() +"/manager/manage-menu?info=" +
                    new String(err.getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
        }
    }
}
