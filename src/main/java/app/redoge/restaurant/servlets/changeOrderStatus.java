package app.redoge.restaurant.servlets;

import app.redoge.restaurant.Order;
import app.redoge.restaurant.User;
import app.redoge.restaurant.UserRole;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

import static app.redoge.restaurant.DAO.OrderDAO.changeOrderStatusById;

public class changeOrderStatus extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isGood = true;
        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }
        final String orderIdString = request.getParameter("changed_id");
        int orderId = -1;
        if (orderIdString == null || orderIdString.length() == 0) {isGood = false;}
        else{orderId = Integer.parseInt(orderIdString);}
        String newStatus =  request.getParameter("changed_status");


        if(orderId == -1 || newStatus == null || newStatus.length() == 0){
            isGood = false;
            request.setAttribute("info", "Error.");
            request.getRequestDispatcher("/manager/manage-orders").forward(request, response);
        }

        if(isGood){
            isGood = changeOrderStatusById(orderId, Order.orderStatus.getStatus(newStatus));
        }

        if(isGood){
            request.setAttribute("info", "Status changed");
            request.getRequestDispatcher("/manager/manage-orders").forward(request, response);
        }else{
            request.setAttribute("info", "Error. Try again.");
            request.getRequestDispatcher("/manager/manage-orders").forward(request, response);
        }


    }
}
