<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.User" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getUser" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language" var="rb"/>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown)) {
        response.sendRedirect(request.getContextPath());
    }
%>
<html>
<head>
    <title>Cabinet</title>

    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
            integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>


</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>">Restaurant</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <%if (role != null && role.equals(UserRole.Manager)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage"%> "><fmt:message key="Manage"
                                                                                                           bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-menu"%>"><fmt:message
                        key="Manage_menu" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-orders"%>"><fmt:message
                        key="Manage_orders" bundle="${rb}"/></a>
                <%} else if (role != null && role.equals(UserRole.User)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/orders"%>"><fmt:message key="My_orders"
                                                                                                       bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/new-order"%>"><fmt:message
                        key="New_order" bundle="${rb}"/></a>
                <%}%>
                <a class="nav-link active" href="<%=request.getContextPath() + "/cabinet"%>"><fmt:message key="Cabinet"
                                                                                                          bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>"><fmt:message key="Dishes_menu"
                                                                                                      bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>"><fmt:message key="Logout"
                                                                                                 bundle="${rb}"/></a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col">
            <div align="center"><h3><fmt:message key="Change_language" bundle="${rb}"/></h3></div>
            <form action="<%=request.getContextPath() + "/changeLanguage"%>" method="post">
                <select name="language" class="form-select">
                    <option value="en">English</option>
                    <option value="uk_UA">Ukraine</option>
                </select>
                <br>
                <div align="center"><input type="submit" value="<fmt:message key="Change_language" bundle="${rb}"/>"
                                           class="btn btn-outline-secondary"></div>
            </form>
        </div>
    </div>
</div>

</br></br>
${sessionScope.email}
</br></br>
${sessionScope.role}
<br><br>


</body>
</html>
