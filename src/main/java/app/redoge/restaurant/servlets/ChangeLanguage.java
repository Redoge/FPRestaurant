package app.redoge.restaurant.servlets;

import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ChangeLanguage extends HttpServlet {
    private static final Logger log = Logger.getLogger(ChangeLanguage.class);
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final HttpSession session = req.getSession();
        final String languageSession = (String) session.getAttribute("language");

        final String language = req.getParameter("language");

        if(language.equalsIgnoreCase("en_US")){
            session.setAttribute("language", "en_US");
        }else if(language.equalsIgnoreCase("uk_UA")){
            session.setAttribute("language", "uk_UA");
        }
        log.info("Change language -> " + language);
        resp.sendRedirect(req.getContextPath()+"/cabinet");

    }
}
