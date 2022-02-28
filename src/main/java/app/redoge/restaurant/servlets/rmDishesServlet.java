package app.redoge.restaurant.servlets;

import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static app.redoge.restaurant.DAO.DishesDAO.rmDish;

public class rmDishesServlet extends HttpServlet {
    private static final Logger log = Logger.getLogger(rmDishesServlet.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserRole role = (UserRole) request.getSession().getAttribute("role");
        boolean isGood = true;
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            log.info("Access denied or role empty");
            response.sendRedirect(request.getContextPath());
        }

        final String id = request.getParameter("id");
        if(id == null) {
            log.info("Paramater is null or empty");
            isGood = false;
            request.setAttribute("info", "Error");
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }
        if(isGood) {
            log.info("Try remove dishes: " + id);
            isGood = rmDish(Integer.parseInt(id));
        }
        if (isGood) {
            log.info("Dishes removed: " + id );
            request.setAttribute("info", "Dishes remove");
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }else{
            log.info("Error removing");
            request.setAttribute("info", "Error");
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }
    }
}
