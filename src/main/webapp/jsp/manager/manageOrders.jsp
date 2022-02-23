<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getAllOrders" %>
<%@ page import="static app.redoge.restaurant.Order.orderStatus.getStatus" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getUserByUserId" %>
<%@ page import="app.redoge.restaurant.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
            response.sendRedirect(request.getContextPath());
        }
        ArrayList<Order> orders = getAllOrders();
        String info = (String) request.getAttribute("info");
        if (info == null) {
            info = "";
        }
    %>
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

    <title>Manage orders</title>

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
                <a class="nav-link " href="<%=request.getContextPath() + "/manager/manage-menu"%>">Manage menu</a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/manager/manage-orders"%>">Manage
                    orders</a>
                <%}%>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>">Dishes Menu</a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row ">
        <form action="<%=request.getContextPath() + "/manager/changeOrderStatus"%>" method="post">
            <label for="AllMenu">Order id:</label><br>
            <%--    <input type = "text" list = "AllMenu" name="changed_id">--%>
            <select id="AllMenu" name="changed_id" class="form-select">
                <%for (Order order : orders) {%>
                <option value="<%=order.getOrder_id()%>"><%=order.getOrder_id()%>
                        <% } %>
            </select>
            <label for="AllAtatus">New Status:</label>
            <%--    <input type = "text" list = "AllAtatus" name="changed_status">--%>
            <select id="AllAtatus" name="changed_status" class="form-select">
                <%for (Order.orderStatus order : Order.orderStatus.values()) {%>
                <option value="<%=order%>"><%=order%>
                        <% } %>
            </select>
            <br>
            <div align="center"><input type="submit" value="Change order status" class="btn btn-outline-secondary"></div>

        </form>
    </div>
    <div class="row">
        <TABLE BORDER="1" width="90%" ALIGN="CENTER" class="table">
            <TR>
                <TH>Name of dish</TH>
                <TH>Count</TH>
                <TH>Price (UAH)</TH>
                <th>Order id</th>
                <th>Status</th>
                <th>Username</th>
                <th>Email:</th>
            </TR>
                <% for(Order order: orders){
        User user = getUserByUserId(order.getUser_id());%>
            <TR>
                <TD><%= order.getName() %>
                </td>
                <TD><%= order.getCount() %>
                </TD>
                <TD><%= order.getPrice() %>
                </TD>
                <TD><%= order.getOrder_id() %>
                </TD>
                <TD><%= order.getStatus() %>
                </TD>
                <TD><%= user.getUsername()%>
                </TD>
                <TD><%= user.getEmail()%>
                </TD>
            </TR>
                <% } %>
    </div>
</div>


</body>
</html>
