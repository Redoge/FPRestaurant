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

        boolean isGood = false;

        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }
        final String name = request.getParameter("name");
        String priceString = request.getParameter("price");
        String categoryString = request.getParameter("category");
        double price = 0;
        int category = 5;
        if(priceString == null || categoryString == null || name == null){
            response.sendRedirect(request.getContextPath()+"/manager/manage-menu");
            isGood = false;
        }else{
            price = Double.parseDouble(priceString);
            category = Integer.parseInt(categoryString);
        }



        System.out.println(1);
        if(name.trim().length() < 3 || price < 1 || category < 1 || category > 5 ) {
            System.out.println(3);
            response.sendRedirect(request.getContextPath()+"/manager/manage-menu");
        }else if(isExistDishes(name)){
            System.out.println(4);
            //повідомити про наявність страви
            response.sendRedirect(request.getContextPath()+"/manager/manage-menu");
        }else{
            System.out.println(5);
            isGood =  setDishes(name, price, category);


//            if(isGood){
////                request.getSession().setAttribute("email", email);
////                request.getSession().setAttribute("role", UserRole.User);
//                response.sendRedirect(request.getContextPath() + "/login");
//            }else{
                //повідомити про проблему
            response.sendRedirect(request.getContextPath()+"/manager/manage-menu");
//            }
        }

    }


}
