<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page import="app.redoge.restaurant.enums.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getDishIdBySorted" %>
<%@ page import="app.redoge.restaurant.Dish" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language" var="rb"/>
<html translate="no">
<head>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }
         %>


    <title><fmt:message key="Manage_menu" bundle="${rb}"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript">
        <%@include file='/js/sort-table.js'%>
    </script>
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
                <a class="nav-link " href="<%=request.getContextPath() + "/manager/manage"%> "><fmt:message key="Manage"
                                                                                                            bundle="${rb}"/></a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/manager/manage-menu"%>"><fmt:message
                        key="Manage_menu" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-orders"%>"><fmt:message
                        key="Manage_orders" bundle="${rb}"/></a>
                <%} %>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>"><fmt:message key="Cabinet"
                                                                                                    bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>"><fmt:message key="Dishes_menu"
                                                                                                      bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>"><fmt:message key="Logout"
                                                                                                 bundle="${rb}"/></a>
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
<!--Add dish-->

<div class="container">
    <div class="row ">
        <%if(request.getParameter("info") != null){%>
        <div class="forAlert">
            <div class="alert alert-secondary form-group" role="alert">
                <%=request.getParameter("info")%>
            </div>
        </div><%}%>
        <div align="center"><h1><fmt:message key="Add_dish" bundle="${rb}"/></h1></div>
        <form action="<%=request.getContextPath() + "/manager/manage/add-dishes"%>" method="post">
            <label for="name"><fmt:message key="Name_of_the_dish" bundle="${rb}"/>:</label>
            <input required type="text" id="name" name="name" class="form-control" placeholder="<fmt:message key="Name_of_the_dish" bundle="${rb}"/>">

            <label for="price"><fmt:message key="Price" bundle="${rb}"/>:</label>
            <input required type="number" id="price" name="price" class="form-control" placeholder="<fmt:message key="Price" bundle="${rb}"/>">

            <label for="category"><fmt:message key="Category" bundle="${rb}"/></label>
            <%--    <input type = "text" list = "category" name="category">--%>
            <select id="category" name="category" class="form-select">
                <% for (Category name : Category.values()) { if(name.equals(Category.Unknown)){continue;}%>
                <option value="<%= name.getId()%>"><%=name%>
                </option>
                <% } %>
            </select>
            <br>
            <div align="center"><input type="submit" value="<fmt:message key="Add" bundle="${rb}"/>"
                                       class="btn btn-outline-secondary"></div>
        </form>
    </div>
    <div class="row ">
        <hr>
        <!--Remove dish-->
        <%
            String category = "category_id";
            Map<Integer, Dish> dishes = getDishIdBySorted(category);
        %>
        <div align="center"><h1><fmt:message key="Remove_dish" bundle="${rb}"/></h1></div>
        <form action="<%=request.getContextPath() + "/manager/manage/rm-dishes"%>" method="post">
            <label for="AllMenu"><fmt:message key="Name_of_the_dish" bundle="${rb}"/>:</label>
            <%--    <input type = "text" list = "AllMenu" name="id">--%>
            <select required id="AllMenu" name="id" class="form-select">
                <%for (int id : dishes.keySet()) { %>
                <option value="<%= id%>"><%=dishes.get(id).getName()%>
                </option>
                <% } %>
            </select>
            <br>
            <div align="center"><input type="submit" value="<fmt:message key="Remove" bundle="${rb}"/>"
                                       class="btn btn-outline-secondary"></div>
        </form>
    </div>
</div>
</body>
</html>
