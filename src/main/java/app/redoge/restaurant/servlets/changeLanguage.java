package app.redoge.restaurant.servlets;

import app.redoge.restaurant.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class changeLanguage extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final HttpSession session = req.getSession();
        final String languageSession = (String) session.getAttribute("language");

        final String language = req.getParameter("language");

        if(language.equalsIgnoreCase("en")){
            session.setAttribute("language", "en");
        }else if(language.equalsIgnoreCase("uk_UA")){
            session.setAttribute("language", "uk_UA");
        }

        resp.sendRedirect(req.getContextPath()+"/cabinet");

    }
}
