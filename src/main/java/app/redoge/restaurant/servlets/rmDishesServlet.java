package app.redoge.restaurant.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static app.redoge.restaurant.DAO.DishesDAO.rmDish;

public class rmDishesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String id = request.getParameter("id");
        if(id == null) {
            response.sendRedirect(request.getContextPath()+"/manager/manage-menu");
        }
        boolean isGood = rmDish(Integer.parseInt(id));

        response.sendRedirect(request.getContextPath()+"/manager/manage-menu");

    }
}
