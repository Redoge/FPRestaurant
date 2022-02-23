package app.redoge.restaurant.servlets;

import app.redoge.restaurant.DAO.UserDao;
import app.redoge.restaurant.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import static app.redoge.restaurant.DAO.UserDao.*;

public class register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        final String email = request.getParameter("email");
        final String password = request.getParameter("password");
        final String username = request.getParameter("username");
        System.out.println(email + " " + username + " " + password);

        boolean validSetUser = false;
        System.out.println(1);
        if(email == null || password == null || username == null){
            response.sendRedirect(request.getContextPath() + "/login");
        }else if(email.trim().length() < 5 || password.length() < 5 || username.length() < 5 ) {
            response.sendRedirect(request.getContextPath() + "/login");
        }else if(isExistUsernameEmail(email, username)){
            request.setAttribute("info", "Login or email are busy");
            request.getRequestDispatcher("/register").forward(request, response);
        }else{
           validSetUser =  setUser(username, email, password, 3);
            if(validSetUser){
                request.getSession().setAttribute("email", email);
                request.getSession().setAttribute("role", UserRole.User);
                response.sendRedirect(request.getContextPath() + "/login");
            }else{
                request.setAttribute("info", "Unknown Error");
                request.getRequestDispatcher("/register").forward(request, response);
            }
        }






    }

    private boolean isExistUsernameEmail(String email, String username){
        try {
            if(isEmailExists(email) || isUsernameExists(username)){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }return false;
    }
}
