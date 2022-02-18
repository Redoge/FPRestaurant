<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.Order" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getUser" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getOrdersByUserId" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 8:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order</title>
</head>
<body>
<%  UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)){
response.sendRedirect(request.getContextPath());}
%>
<h1>My orders</h1>
<a href="<%=request.getContextPath()%>">Main</a>





        <%
            List<Order> orders = getOrdersByUserId((int)request.getSession().getAttribute("user_id"));

        %>

<TABLE BORDER="1" width="90%" ALIGN="CENTER">
    <TR>
        <TH>Name of dish</TH>
        <TH>Count</TH>
        <TH>Price (UAH)</TH>
        <th>Status</th>
        <th>Order id</th>

    </TR>
    <% for(Order order: orders){ %>
    <TR>
        <TD> <%= order.getName() %></td>
        <TD> <%= order.getCount() %></TD>
        <TD> <%= order.getPrice() %> </TD>
        <TD> <%= order.getStatus() %></TD>
        <TD> <%= order.getOrder_id() %></TD>
    </TR>
    <% } %>



</TABLE>
</body>
</html>
