package app.redoge.restaurant.filter;

import app.redoge.restaurant.UserRole;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class charsetFilter implements Filter {
    // кодировка
    private String encoding;

    public void init(FilterConfig config) throws ServletException {
        // читаем из конфигурации
        encoding = config.getInitParameter("requestEncoding");

        // если не установлена — устанавливаем UTF-8
        if (encoding == null) encoding = "UTF-8";
    }

    public void doFilter(ServletRequest request,
                         ServletResponse response, FilterChain next)
            throws IOException, ServletException {

        request.setCharacterEncoding(encoding);


        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        String language = (String) session.getAttribute("language");
        if(language == null || language.length() == 0){
            session.setAttribute("language", "en");
        }

        next.doFilter(request, response);
    }

    public void destroy() {
    }
}