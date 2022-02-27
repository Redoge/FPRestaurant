package app.redoge.restaurant.servlets;

import app.redoge.restaurant.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static app.redoge.restaurant.DAO.DishesDAO.rmDish;

public class rmDishesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }

        final String id = request.getParameter("id");
        if(id == null) {
            request.setAttribute("info", "Error");
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }
        boolean isGood = rmDish(Integer.parseInt(id));

        if (isGood) {
            request.setAttribute("info", "Dishes remove");
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }else{
            request.setAttribute("info", "Error");
            request.getRequestDispatcher("/manager/manage-menu").forward(request, response);
        }
    }
}
