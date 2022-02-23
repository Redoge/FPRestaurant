<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.DishesMenu" %>
<%@ page import="java.util.Map" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getAllMenuMap" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 10:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }
    %>


    <title>Manage menu</title>
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
                <%if (role.equals(UserRole.Manager)) {%>
                <a class="nav-link " href="<%=request.getContextPath() + "/manager/manage"%> ">Manage</a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/manager/manage-menu"%>">Manage menu</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-orders"%>">Manage orders</a>
                <%} else if (role.equals(UserRole.User)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/orders"%>">My order</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/new-order"%>">New order</a>
                <%}%>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>">Dishes Menu</a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>">Logout</a>
            </div>
        </div>
    </div>
</nav>
<!--Add dish-->

<div class="container">
    <div class="row ">
        <div align="center"><h1>Add dish</h1></div>
        <form action="<%=request.getContextPath() + "/manager/manage/add-dishes"%>" method="post">
            <label for="name">Name of the dish:</label>
            <input type="text" id="name" name="name" class="form-control" placeholder="Name of the dish">

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" class="form-control" placeholder="Price of the dish">

            <label for="category">Name of dish:</label>
            <%--    <input type = "text" list = "category" name="category">--%>
            <select id="category" name="category" class="form-select">
                <% for (DishesMenu name : DishesMenu.values()) { %>
                <option value="<%= name.getId()%>"><%=name%>
                </option>
                <% } %>
            </select>
<br>
            <div align="center"> <input type="submit" value="Add" class="btn btn-outline-secondary"></div>
        </form>
    </div>
    <div class="row ">
        <hr>
        <!--Remove dish-->
        <div align="center"><h1>Remove dish</h1></div>
        <form action="<%=request.getContextPath() + "/manager/manage/rm-dishes"%>" method="post">
            <label for="AllMenu">Category:</label>
            <%--    <input type = "text" list = "AllMenu" name="id">--%>
            <select id="AllMenu" name="id" class="form-select">
                <% Map<Integer, String> dishes = getAllMenuMap();
                    for (int id : getAllMenuMap().keySet()) { %>
                <option value="<%= id%>"><%=dishes.get(id)%>
                </option>
                <% } %>
            </select>
<br>
            <div align="center"><input type="submit" value="Remove" class="btn btn-outline-secondary"></div>
        </form>
    </div>
</body>
</html>
