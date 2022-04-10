<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page import="app.redoge.restaurant.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getAllOrders" %>
<%@ page import="static app.redoge.restaurant.Order.orderStatus.getStatus" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getUserByUserId" %>
<%@ page import="app.redoge.restaurant.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language" var="rb"/>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
        response.sendRedirect(request.getContextPath());
    }
    ArrayList<Order> orders = getAllOrders();
%>
<html translate="no">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        <%@include file='/css/jquery.dataTables.min.css' %>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
            integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script type="text/javascript">
        <%@include file='/js/jquery.dataTables.min.js'%>
        <%@include file='/js/sort-table.js'%>
    </script>
    <title><fmt:message key="Manage_orders" bundle="${rb}"/></title>

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
                <a class="nav-link " href="<%=request.getContextPath() + "/manager/manage-menu"%>"><fmt:message
                        key="Manage_menu" bundle="${rb}"/></a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/manager/manage-orders"%>"><fmt:message
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
                    <%if (language.equalsIgnoreCase("en_US")) {%>
                    <input type="hidden" name="language" value="uk_UA"/>
                    <button type="submit" class="nav-link btn" href="#">UKR</button>
                    <%} else {%>
                    <input type="hidden" name="language" value="en_US"/>
                    <button type="submit" class="nav-link btn" href="#">ENG</button>
                    <%}%>
                </form>
            </div>
            <%--Language--%>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row ">
        <%if (request.getParameter("info") != null) {%>
        <div class="forAlert">
            <div class="alert alert-secondary form-group" role="alert">
                <%=request.getParameter("info")%>
            </div>
        </div>
        <%}%>
        <form action="<%=request.getContextPath() + "/manager/changeOrderStatus"%>" method="post">
            <label for="AllMenu"><fmt:message key="Order_id" bundle="${rb}"/>:</label><br>
            <input class="form-control" type="number" name="changed_id" id="AllMenu">
            <%--            <select  id="AllMenu" name="changed_id" class="form-select">--%>
            <%--                <%for (Order order : orders) {%>--%>
            <%--                <option value="<%=order.getOrder_id()%>"><%=order.getOrder_id()%>--%>
            <%--                        <% } %>--%>
            <%--            </select>--%>
            <label for="AllAtatus"><fmt:message key="New_status" bundle="${rb}"/>:</label>
            <%--    <input type = "text" list = "AllAtatus" name="changed_status">--%>
            <select id="AllAtatus" name="changed_status" class="form-select">
                <%for (Order.orderStatus order : Order.orderStatus.values()) {%>
                <option value="<%=order%>">
                    <fmt:message key="<%= order.toString() %>" bundle="${rb}"/>
                        <% } %>
            </select>
            <br>
            <div align="center"><input type="submit" value="<fmt:message key="Change_order_status" bundle="${rb}"/>"
                                       class="btn btn-outline-secondary"></div>

        </form>
    </div>

<%--    <div class="col position-relative" align="center">--%>
<%--        <label for="input_group"><fmt:message key="Group_by" bundle="${rb}"/></label>--%>
<%--        <select class="form-select" aria-label="Default select example" id="input_group">--%>
<%--            <option value="">All</option>--%>
<%--            <% Order.orderStatus[] dishesMenuArr = Order.orderStatus.values();--%>
<%--                for (Order.orderStatus dm : dishesMenuArr) {%>--%>
<%--            <option value="<%=dm%>"><%=dm%>--%>
<%--            </option>--%>
<%--            <%}%>--%>
<%--        </select>--%>
<%--        <button class="btn btn-outline-secondary" id="" onclick="groupDishByCategory();"><fmt:message key="Grupped"--%>
<%--                                                                                                      bundle="${rb}"/></button>--%>
<%--    </div>--%>


    <div class="row">
        <TABLE cellspacing="0" width="100%" class="sort-table.js table js-sort-table" id="table_dish">
            <thead>
            <TR>
                <TH><fmt:message key="Name_of_the_dish" bundle="${rb}"/></TH>
                <TH class="js-sort-number"><fmt:message key="Count" bundle="${rb}"/></TH>
                <TH class="js-sort-number"><fmt:message key="Price" bundle="${rb}"/> (UAH)</TH>
                <th class="js-sort-number"><fmt:message key="Order_id" bundle="${rb}"/></th>
                <th><fmt:message key="Status" bundle="${rb}"/></th>
                <th><fmt:message key="Username" bundle="${rb}"/></th>
                <th>Email:</th>
                <th><fmt:message key="More" bundle="${rb}"/>:</th>
            </TR>
            <thead>
            <tbody>
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
                <TD><fmt:message key="<%= order.getStatus().toString() %>" bundle="${rb}"/>
                </TD>
                <TD><%= user.getUsername()%>
                </TD>
                <TD><%= user.getEmail()%>
                </TD>
                <TD><a href="<%=request.getContextPath() + "/manager/order-info?id="+order.getOrder_id()%>">
                    <button class="btn btn-outline-secondary"><fmt:message key="More" bundle="${rb}"/></button>
                </a>
                </TD>
            </TR>

                <% } %>
            </tbody>
        </TABLE>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#table_dish").DataTable();
    });
    function groupDishByCategory() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("input_group");
        filter = input.value.toUpperCase();
        table = document.getElementById("table_dish");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[4];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }


</script>

</body>
</html>
