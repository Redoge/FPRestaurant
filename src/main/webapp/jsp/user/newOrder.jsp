<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="java.util.Map" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getAllMenuMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)) {
            response.sendRedirect(request.getContextPath());
        }
    %>
    <title>New order</title>
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
                <%if (role.equals(UserRole.User)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/orders"%>">My order</a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/user/new-order"%>">New order</a>
                <%}%>
                <a class="nav-link active" href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>">Dishes Menu</a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>">Logout</a>
            </div>
        </div>
    </div>
</nav>
<div align="center"><h1>Make order</h1></div>

<div class="container">
    <div class="row">
        <form action="<%=request.getContextPath() + "/user/new-orderPost"%>" method="post">
            <label for="AllMenu">Category:</label><br>
            <%--    <input type = "text" list = "AllMenu" >--%>
            <select id="AllMenu" name="id" class="form-select">
                <% Map<Integer, String> dishes = getAllMenuMap();
                    for (int id : getAllMenuMap().keySet()) { %>
                <option value="<%= id%>"><%=dishes.get(id)%>
                </option>
                <% } %>
            </select>

            <label for="count">Price:</label>
            <input type="number" id="count" name="count" class="form-control"><br>
            <div align="center"><input type="submit" value="Submit" class="btn btn-outline-secondary"></div>
        </form>
    </div>
</div>


</body>
</html>
