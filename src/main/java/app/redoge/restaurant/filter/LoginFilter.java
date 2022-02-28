package app.redoge.restaurant.filter;


import app.redoge.restaurant.DAO.UserDao;
import app.redoge.restaurant.User;
import app.redoge.restaurant.UserRole;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import org.apache.log4j.Logger;


import static java.util.Objects.nonNull;

public class LoginFilter implements Filter {
    private static final Logger log = Logger.getLogger(String.valueOf(LoginFilter.class));
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
//        System.out.println(password);
//        System.out.println(email);
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
        }else{
            moveToMenu(req, resp, UserRole.Unknown);
        }

    }

    private void moveToMenu(HttpServletRequest req, HttpServletResponse resp, UserRole role) throws ServletException, IOException {
        if (role.equals(UserRole.Manager) || role.equals(UserRole.User)){
            log.info("User loggined " + req.getParameter("email"));
            req.setAttribute("info", "Login successful");
            resp.sendRedirect("./cabinet");
        } else if (req.getParameter("email") == null && req.getParameter("password") == null){
            log.info("User not loggined, email or passw is null");
            req.getRequestDispatcher("/login").forward(req, resp);
        }else{
            log.info("User not loggined. Invalid email or password");
            req.setAttribute("info", "Invalid email or password");
            req.getRequestDispatcher("/login").forward(req, resp);
        }
    }

    @Override
    public void destroy() {

    }
}
