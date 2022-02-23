<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.Order" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getOrdersByUserId" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order</title>
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
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)) {
        response.sendRedirect(request.getContextPath());
    }
    List<Order> orders = getOrdersByUserId((int) request.getSession().getAttribute("user_id"));
%>
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
                <a class="nav-link active" href="<%=request.getContextPath() + "/user/orders"%>">My order</a>
                <a class="nav-link " href="<%=request.getContextPath() + "/user/new-order"%>">New order</a>
                <%}%>
                <a class="nav-link active" href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>">Dishes Menu</a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>">Logout</a>
            </div>
        </div>
    </div>
</nav>
<div align="center"><h1>My orders</h1></div>
<div class="container">
    <div class="row">
        <TABLE BORDER="1" width="90%" ALIGN="CENTER" class="table">
            <TR>
                <TH>Name of dish</TH>
                <TH>Count</TH>
                <TH>Price (UAH)</TH>
                <th>Status</th>
                <th>Order id</th>

            </TR>
            <% for (Order order : orders) { %>
            <TR>
                <TD><%= order.getName() %>
                </td>
                <TD><%= order.getCount() %>
                </TD>
                <TD><%= order.getPrice() %>
                </TD>
                <TD><%= order.getStatus() %>
                </TD>
                <TD><%= order.getOrder_id() %>
                </TD>
            </TR>
            <% } %>
        </TABLE>
    </div>
</div>
</body>
</html>
