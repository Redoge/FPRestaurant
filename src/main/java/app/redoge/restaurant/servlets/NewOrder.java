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
        boolean isGood = false;

        String dishIdString = req.getParameter("id");
        String countString = req.getParameter("count");
        int dishId = 0;
        int count = 0;
        if(dishIdString == null || countString == null) {
            //ERROR
            resp.sendRedirect(req.getContextPath()+"/user/new-order");
            isGood = false;
        }else{
            dishId = Integer.parseInt(dishIdString);
            count = Integer.parseInt(countString);
        }
        String  email = (String) req.getSession().getAttribute("email");
        User user = null;
        try {
            user = getUser(email);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if(user == null){
            //ERROR
            resp.sendRedirect(req.getContextPath()+"/user/new-order");
            isGood = false;
        }
        Order order = new Order(dishId, count, user.getId());
        System.out.println(23);
        isGood = newOrder(order);

        if (isGood == false){
            System.out.println(24);
            resp.sendRedirect(req.getContextPath()+"/user/new-order");
            isGood = false;
        }else{
            System.out.println(25);
            resp.sendRedirect(req.getContextPath()+"/user/new-order");
        }


    }
}
