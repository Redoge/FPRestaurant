package app.redoge.restaurant.filter;

import app.redoge.restaurant.servlets.ChangeUserRole;
import org.apache.log4j.Logger;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * The type Charset filter.
 */
public class CharsetFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {

    }

    public void doFilter(ServletRequest request,
                         ServletResponse response, FilterChain next)
            throws IOException, ServletException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        String language = (String) session.getAttribute("language");
        if(language == null || language.length() == 0){
            session.setAttribute("language", "en_US");
        }

        next.doFilter(request, response);
    }

    public void destroy() {
    }
}