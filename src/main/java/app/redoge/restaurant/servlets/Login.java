package app.redoge.restaurant.servlets;


import app.redoge.restaurant.DAO.UserDao;
import app.redoge.restaurant.User;
import app.redoge.restaurant.enums.UserRole;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Locale;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;


import static app.redoge.restaurant.DAO.UserDao.isTruePasswordByUsername;
import static java.util.Objects.nonNull;

public class Login implements Filter {
    private static final Logger log = Logger.getLogger(String.valueOf(Login.class));
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain)
            throws IOException, ServletException {


        final HttpServletRequest req = (HttpServletRequest) servletRequest;
        final HttpServletResponse resp = (HttpServletResponse) servletResponse;

        final String email = servletRequest.getParameter("email");
        final String password = servletRequest.getParameter("password");

        final HttpSession session = req.getSession();

        if(nonNull(session.getAttribute("email")) || nonNull(session.getAttribute("user_id"))){
            final UserRole role = (UserRole) session.getAttribute("role");
            filterChain.doFilter(req,resp);
        }else if(UserDao.isTruePassword(password, email)){
            try {
                User user = UserDao.getUser(email);
                UserRole role = UserRole.getUserRole(user.getRole());
                req.getSession().setAttribute("email", email);
                req.getSession().setAttribute("role", role);
                req.getSession().setAttribute("user_id", user.getId());

                moveToMenu(req, resp, role);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if(isTruePasswordByUsername(password, email)){
            try {
                User user = UserDao.getUserByUsername(email);
                UserRole role = UserRole.getUserRole(user.getRole());
                req.getSession().setAttribute("email", user.getEmail());
                req.getSession().setAttribute("role", role);
                req.getSession().setAttribute("user_id", user.getId());

                moveToMenu(req, resp, role);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else{
            moveToMenu(req, resp, UserRole.Unknown);
        }

    }

    private void moveToMenu(HttpServletRequest req, HttpServletResponse resp, UserRole role) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String[] lang_param =  ((String) session.getAttribute("language")).split("_");
        Locale locale = new Locale(lang_param[0], lang_param[1]);
        ResourceBundle rb = ResourceBundle.getBundle("language", locale);



        if (role.equals(UserRole.Manager) || role.equals(UserRole.User)){
            log.info("User loggined " + req.getParameter("email"));
            resp.sendRedirect(req.getContextPath() + "/cabinet");
        } else if (req.getParameter("email") == null && req.getParameter("password") == null){
            log.info("User not loggined, email or passw is null");
            req.getRequestDispatcher("/login").forward(req,resp);
//            resp.sendRedirect(req.getContextPath() +"/login");
        }else{
            log.info("User not loggined. Invalid email or password");
            resp.sendRedirect(req.getContextPath() +"/login?info=" +
                    new String(rb.getString("InvalidEmailOrPassword").getBytes(StandardCharsets.UTF_8), "ISO-8859-1"));
        }
    }

    @Override
    public void destroy() {

    }
}
