package app.redoge.restaurant.servlets;

import app.redoge.restaurant.Order;
import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import static app.redoge.restaurant.DAO.OrderDAO.changeOrderStatusById;

public class ChangeOrderStatus extends HttpServlet {
    private static final Logger log = Logger.getLogger(ChangeOrderStatus.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String[] lang_param =  ((String) session.getAttribute("language")).split("_");
        Locale locale = new Locale(lang_param[0], lang_param[1]);
        ResourceBundle rb = ResourceBundle.getBundle("language", locale);

        boolean isGood = true;
        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            log.info("Access denied or role is null");
            response.sendRedirect(request.getContextPath());
        }
        final String orderIdString = request.getParameter("changed_id");
        int orderId = -1;
        if (orderIdString == null || orderIdString.length() == 0) {
            log.info("OrderId is null or empty");
            isGood = false;
        }
        else{orderId = Integer.parseInt(orderIdString);}
        String newStatus =  request.getParameter("changed_status");


        if(orderId == -1 || newStatus == null || newStatus.length() == 0){
            log.info("OrderId invalid or newStatus is null or empty");
            isGood = false;
            request.setAttribute("info",  rb.getString("Error"));
            request.getRequestDispatcher("/manager/manage-orders").forward(request, response);
        }

        if(isGood){
            log.info("Try change status in db");
            isGood = changeOrderStatusById(orderId, Order.orderStatus.getStatus(newStatus));
        }

        if(isGood){
            log.info("Added status in db");
            request.setAttribute("info", rb.getString("StatusChanged"));
            request.getRequestDispatcher("/manager/manage-orders").forward(request, response);
        }else{
            log.info("Error added status in db");
            request.setAttribute("info", rb.getString("Error"));
            request.getRequestDispatcher("/manager/manage-orders").forward(request, response);
        }


    }
}
