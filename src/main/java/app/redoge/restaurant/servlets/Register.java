package app.redoge.restaurant.servlets;

import app.redoge.restaurant.DAO.UserDao;
import app.redoge.restaurant.User;
import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Locale;
import java.util.ResourceBundle;

import static app.redoge.restaurant.DAO.UserDao.*;

public class Register extends HttpServlet {
    private static final Logger log = Logger.getLogger(Register.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String[] lang_param =  ((String) session.getAttribute("language")).split("_");
        Locale locale = new Locale(lang_param[0], lang_param[1]);
        ResourceBundle rb = ResourceBundle.getBundle("language", locale);

        final String email = request.getParameter("email");
        final String password = request.getParameter("password");
        final String username = request.getParameter("username");

        boolean validSetUser = true;
        if(email == null || password == null || username == null){
            log.info("Parameter is null or empty");
            request.setAttribute("info", rb.getString("FillInAllTheFields"));
            validSetUser = false;
            request.getRequestDispatcher("/register").forward(request, response);
        }else if(email.trim().length() < 5 || password.length() < 5 || username.length() < 5 ) {
            log.info("Invalid parameter");
            validSetUser = false;
            request.setAttribute("info", rb.getString("NameAndPasswordMustBeLongerThan5Characters"));
            request.getRequestDispatcher("/register").forward(request, response);
        }else if(isExistUsernameEmail(email, username)){
            log.info("Username or email exist");
            validSetUser = false;
            request.setAttribute("info", rb.getString("LoginOrEmailAreBusy"));
            request.getRequestDispatcher("/register").forward(request, response);
        }else{
            validSetUser = setUser(username, email, password, 3);
            if(validSetUser){
                log.info("Register is done " + email);
                request.getSession().setAttribute("email", email);
                request.getSession().setAttribute("role", UserRole.User);
                User user = null;
                try {
                    user = UserDao.getUser(email);
                    request.getSession().setAttribute("user_id", user.getId());
                    response.sendRedirect(request.getContextPath() + "/login");
                } catch (SQLException e) {
                    log.error(e);
                    request.setAttribute("info", rb.getString("Error"));
                    request.getRequestDispatcher("/register").forward(request, response);
                }
            }else{
                log.info("Register error");
                request.setAttribute("info", rb.getString("Error"));
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
