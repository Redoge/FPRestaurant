package app.redoge.restaurant.servlets;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static app.redoge.restaurant.DAO.UserDao.changeLanguageById;

public class ChangeLanguage extends HttpServlet {
    private static final Logger log = Logger.getLogger(ChangeLanguage.class);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final HttpSession session = req.getSession();
        final String languageSession = (String) session.getAttribute("language");
        String path = req.getParameter("path");
        if(path == null || path.length() == 0){path = "/cabinet";}
        final String language = req.getParameter("language");
        if (!(req.getSession().getAttribute("language") == null)) {
            if (!(req.getSession().getAttribute("user_id") == null)) {
                changeLanguageById((Integer) req.getSession().getAttribute("user_id"), language);
                session.setAttribute("language", language);
                log.info("Change language and added to db-> " + language);
            } else {
                session.setAttribute("language", language);
                log.info("Change language and not added to db-> " + language);
            }
        }resp.sendRedirect(req.getContextPath() + path);
    }
}
