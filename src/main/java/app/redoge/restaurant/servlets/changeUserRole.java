package app.redoge.restaurant.servlets;

import app.redoge.restaurant.enums.UserRole;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static app.redoge.restaurant.DAO.UserDao.changeRoleById;
import static app.redoge.restaurant.DAO.UserDao.getUserByUserId;

public class changeUserRole extends HttpServlet {
    private static final Logger log = Logger.getLogger(changeUserRole.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isGood = true;
        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            log.info("Access denied or role is null");
            response.sendRedirect(request.getContextPath());
        }
        final String newRoleStringId = request.getParameter("newRole");
        final String userStringId = request.getParameter("userId");
        int newRoleId = -1;
        int userId = -1;
        if (newRoleStringId == null || newRoleStringId.length() == 0 || userStringId == null || userStringId.length() == 0) {
            log.info("Invalid parameter");
            isGood = false;
        }
        if (isGood) {
            try {
                userId = Integer.parseInt(userStringId);
                newRoleId = Integer.parseInt(newRoleStringId);
            } catch (NumberFormatException e) {
                log.error(e);
                isGood = false;
            }
        }
        if(getUserByUserId(userId)==null){
            log.info("User by id not found" + userId);
            isGood = false;
        }
        if (newRoleId != 2 && newRoleId != 3) {
            log.info("Invalid new role id" + newRoleId);
            isGood = false;
        }
        if(isGood) {
            log.info("Try changed user role");
            isGood = changeRoleById(userId, UserRole.getUserRole(newRoleId));
        }
        if (isGood) {
            log.info("Role changed: userId - " + userStringId + " newRoleId - "+ newRoleStringId);
            request.setAttribute("info", "Changed");
            request.getRequestDispatcher("/manager/manage").forward(request, response);
        } else {
            log.info("Error role changed: userId - " + userStringId + " newRoleId - "+ newRoleStringId);
            request.setAttribute("info", "Error");
            request.getRequestDispatcher("/manager/manage").forward(request, response);
        }


    }

}
