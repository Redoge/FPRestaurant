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

import static app.redoge.restaurant.DAO.DishesDAO.rmDish;

public class RemoveDishes extends HttpServlet {
    private static final Logger log = Logger.getLogger(RemoveDishes.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String[] lang_param =  ((String) session.getAttribute("language")).split("_");
        Locale locale = new Locale(lang_param[0], lang_param[1]);
        ResourceBundle rb = ResourceBundle.getBundle("language", locale);

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
            response.sendRedirect(request.getContextPath() +"/manager/manage-menu?info=" +
                    new String(rb.getString("Error").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
        }
        if(isGood) {
            log.info("Try remove dishes: " + id);
            isGood = rmDish(Integer.parseInt(id));
        }
        if (isGood) {
            log.info("Dishes removed: " + id );
            response.sendRedirect(request.getContextPath() +"/manager/manage-menu?info=" +
                    new String(rb.getString("DishesRemove").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
        }else{
            log.info("Error removing");
            response.sendRedirect(request.getContextPath() +"/manager/manage-menu?info=" +
                    new String(rb.getString("Error").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
        }
    }
}
