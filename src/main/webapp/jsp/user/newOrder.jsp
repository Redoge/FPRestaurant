<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page import="java.util.Map" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getAllMenuMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<%@ taglib uri="http://redoge.app" prefix="rt" %>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language"  var="rb"/>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)) {
        response.sendRedirect(request.getContextPath());
    }
%>
<html translate="no">
<head>

    <title><fmt:message key="New_order" bundle="${rb}"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
        <a class="navbar-brand" href="<%=request.getContextPath()%>"><rt:projectName/></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <%if (role != null && role.equals(UserRole.User)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/orders"%>"><fmt:message key="My_orders" bundle="${rb}"/></a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/user/new-order"%>"><fmt:message key="New_order" bundle="${rb}"/></a>
                <%}%>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>"><fmt:message key="Cabinet" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>"><fmt:message key="Dishes_menu" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>"><fmt:message key="Logout" bundle="${rb}"/></a>
            </div>
            <%--Language--%>
            <div class="navbar-nav ms-auto mb-2 mb-lg-0">
                <form method="post" action="<%=request.getContextPath() + "/changeLanguage"%>">
                    <input type="hidden" name="path" value="<%=request.getServletPath()%>">
                    <%if (language.equalsIgnoreCase("en_US")){%>
                    <input type="hidden" name="language" value="uk_UA"/>
                    <button type="submit" class="nav-link btn" href="#">UKR</button>
                    <%}else{%>
                    <input type="hidden" name="language" value="en_US"/>
                    <button type="submit" class="nav-link btn" href="#">ENG</button>
                    <%}%>
                </form>
            </div>
            <%--Language--%>
        </div>
    </div>
</nav>
<div align="center"><h1><fmt:message key="New_order" bundle="${rb}"/></h1></div>

<div class="container">
    <div class="row">
        <%if(request.getParameter("info") != null){%>
        <div class="forAlert">
            <div class="alert alert-secondary form-group" role="alert">
                <%=request.getParameter("info")%>
            </div>
        </div><%}%>
        <form action="<%=request.getContextPath() + "/user/new-orderPost"%>" method="post">
            <label for="AllMenu"><fmt:message key="Name_of_the_dish" bundle="${rb}"/>:</label><br>
            <%--    <input type = "text" list = "AllMenu" >--%>
            <select id="AllMenu" name="id" class="form-select">
                <% Map<Integer, String> dishes = getAllMenuMap();
                    for (int id : getAllMenuMap().keySet()) { %>
                <option value="<%= id%>"><%=dishes.get(id)%>
                </option>
                <% } %>
            </select>

            <label for="count"><fmt:message key="Count" bundle="${rb}"/>:</label>
            <input required type="number" id="count" name="count" class="form-control" placeholder="<fmt:message key="Count" bundle="${rb}"/>">

            <label for="address"><fmt:message key="Address" bundle="${rb}"/>:</label>
            <input required type="text" id="address" name="address" class="form-control" placeholder="<fmt:message key="Address" bundle="${rb}"/>"><br>

            <div align="center"><input type="submit" value="<fmt:message key="New_order" bundle="${rb}"/>" class="btn btn-outline-secondary"></div>
        </form>
    </div>
</div>


</body>
</html>
