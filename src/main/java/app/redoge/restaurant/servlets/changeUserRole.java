package app.redoge.restaurant.servlets;

import app.redoge.restaurant.User;
import app.redoge.restaurant.UserRole;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static app.redoge.restaurant.DAO.UserDao.changeRoleById;
import static app.redoge.restaurant.DAO.UserDao.getUserByUserId;

public class changeUserRole extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isGood = true;
        final UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }
        final String newRoleStringId = request.getParameter("newRole");
        final String userStringId = request.getParameter("userId");
        int newRoleId = -1;
        int userId = -1;
        if (newRoleStringId == null || newRoleStringId.length() == 0 || userStringId == null || userStringId.length() == 0) {
            isGood = false;
        }
        if (isGood) {
            try {
                userId = Integer.parseInt(userStringId);
                newRoleId = Integer.parseInt(newRoleStringId);
            } catch (NumberFormatException e) {
                //*******
                isGood = false;
            }
        }
        if(getUserByUserId(userId)==null){
            isGood = false;
        }
        if (newRoleId != 2 && newRoleId != 3) {
            isGood = false;
        }
        if(isGood) {
            isGood = changeRoleById(userId, UserRole.getUserRole(newRoleId));
        }
        if (isGood) {
            request.setAttribute("info", "Changed");
            request.getRequestDispatcher("/manager/manage").forward(request, response);
        } else {
            request.setAttribute("info", "Error");
            request.getRequestDispatcher("/manager/manage").forward(request, response);
        }


    }

}
