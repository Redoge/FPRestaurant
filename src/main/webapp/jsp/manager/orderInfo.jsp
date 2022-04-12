<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page import="app.redoge.restaurant.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getAllOrders" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getUserByUserId" %>
<%@ page import="app.redoge.restaurant.User" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getOrderById" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<%@ taglib uri="http://redoge.app" prefix="rt" %>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language" var="rb"/>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
        response.sendRedirect(request.getContextPath());
    }
%>
<html>
<head>
    <title><fmt:message key="Order_number" bundle="${rb}"/><c:out value="${param.id}"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript">
        <%@include file='/js/sort-table.js'%>
    </script>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <meta charset="utf-8">
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
                <%if (role != null && role.equals(UserRole.Manager)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage"%> "><fmt:message key="Manage"
                                                                                                           bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-menu"%>"><fmt:message
                        key="Manage_menu" bundle="${rb}"/></a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/manager/manage-orders"%>"><fmt:message
                        key="Manage_orders" bundle="${rb}"/></a>
                <%}%>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>"><fmt:message key="Cabinet"
                                                                                                    bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>"><fmt:message key="Dishes_menu"
                                                                                                      bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>"><fmt:message key="Logout"
                                                                                                 bundle="${rb}"/></a>
            </div>
        </div>
    </div>
</nav>


<c:if test="${not empty param.id and param.id.matches('[0-9]+')}">
    <%
        Order order = getOrderById(Integer.parseInt(request.getParameter("id")));
        if (order == null) {%>
    <div class="alert alert-secondary form-group" role="alert" align="center">
        <fmt:message key="Not_found" bundle="${rb}"/> №<c:out value="${param.id}"/>
    </div>
    <%
    } else { User user = getUserByUserId(order.getUser_id());%>

    <div class="card border-secondary mb-2">
        <div class="card-body text-secondary">
            <div class="card text-center">
                <div class="card-header">
                    <fmt:message key="Order_number" bundle="${rb}"/><c:out value="${param.id}"/>
                </div>
                <div class="card-body">
                    <h3><fmt:message key="Username" bundle="${rb}"/>:<strong><%=user.getUsername()%>
                    </strong></h3>
                    <h3>Email: <strong><%=user.getEmail()%>
                    </strong></h3>
                    <h3><fmt:message key="Name_of_the_dish" bundle="${rb}"/>: <strong><%=order.getName()%>
                    </strong></h3>
                    <h3><fmt:message key="Count" bundle="${rb}"/>: <strong><%=order.getCount()%>
                    </strong></h3>
                    <h3><fmt:message key="Price" bundle="${rb}"/>: <strong><%=order.getPrice()%>
                    </strong></h3>
                    <h3><fmt:message key="Address" bundle="${rb}"/>: <strong><%=order.getAddress()%>
                    </strong></h3>
                </div>
                <div class="card-footer text-muted">
                    <fmt:message key="Status" bundle="${rb}"/>: <strong><fmt:message key="<%= order.getStatus().toString() %>" bundle="${rb}"/>
                </strong>
                </div>
            </div>
        </div>
    </div>
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
                <input type="hidden" name="uri_pages" value="<%=request.getRequestURI()+"?id="+order.getOrder_id()%>">

                    <%--            <label    for="AllMenu"><fmt:message key="Order_id" bundle="${rb}"/>:</label><br>--%>
                <input class="form-control" type="hidden" name="changed_id" id="AllMenu"
                       value="<c:out value="${param.id}" />" readonly="">

                <label for="AllAtatus"><fmt:message key="New_status" bundle="${rb}"/>:</label>
                <select id="AllAtatus" name="changed_status" class="form-select">
                    <%for (Order.orderStatus orderSt : Order.orderStatus.values()) {%>
                    <option value="<%=orderSt%>"><fmt:message key="<%= orderSt.toString() %>" bundle="${rb}"/>
                                <% } %>
                </select>
                <br>
                <div align="center"><input type="submit" value="<fmt:message key="Change_order_status" bundle="${rb}"/>"
                                           class="btn btn-outline-secondary"></div>

            </form>
        </div>
    </div>
    <%}%>
</c:if>
<c:if test="${empty param.id or not param.id.matches('[0-9]+')}">
        <div class="alert alert-secondary form-group" role="alert" align="center">
            <fmt:message key="Error" bundle="${rb}"/> (GET parameter -> id)
        </div>
</c:if>

</body>
</html>
