package app.redoge.restaurant.servlets;

import app.redoge.restaurant.Order;
import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
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
        String uri_page = request.getParameter("uri_pages");
        int orderId = -1;
        if (orderIdString == null || orderIdString.length() == 0) {
            log.info("OrderId is null or empty: " + orderIdString);
            isGood = false;
        }
        else{orderId = Integer.parseInt(orderIdString);}
        String newStatus =  request.getParameter("changed_status");

        if(uri_page == null || uri_page.length() == 0) {
            if (orderId == -1 || newStatus == null || newStatus.length() == 0) {
                log.info("OrderId invalid(" + orderId + ") or newStatus is null or empty " + newStatus);
                isGood = false;
                response.sendRedirect(request.getContextPath() +"/manager/manage-orders" + "?info=" +
                        new String(rb.getString("Error").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
            }

            if (isGood) {
                log.info("Try change status in db");
                isGood = changeOrderStatusById(orderId, Order.orderStatus.getStatus(newStatus));
                if (!isGood) {
                    log.info("Error added status in db");
                    response.sendRedirect(request.getContextPath() +"/manager/manage-orders" + "?info=" +
                            new String(rb.getString("Error").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
                }
            }

            if (isGood) {
                log.info("Added status in db");
                response.sendRedirect(request.getContextPath() +"/manager/manage-orders" + "?info=" +
                        new String(rb.getString("StatusChanged").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
            }
        }else{
            if (orderId == -1 || newStatus == null || newStatus.length() == 0) {
                log.info("OrderId invalid(" + orderId + ") or newStatus is null or empty " + newStatus);
                isGood = false;
                response.sendRedirect(uri_page + "&info=" +
                        new String(rb.getString("Error").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
            }

            if (isGood) {
                log.info("Try change status in db");
                isGood = changeOrderStatusById(orderId, Order.orderStatus.getStatus(newStatus));
                if (!isGood) {
                    log.info("Error added status in db");
                    response.sendRedirect(uri_page + "&info=" +
                            new String(rb.getString("Error").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
                }
            }

            if (isGood) {
                log.info("Added status in db");
                response.sendRedirect(uri_page + "&info=" +
                        new String(rb.getString("StatusChanged").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
            }
        }

    }
}
