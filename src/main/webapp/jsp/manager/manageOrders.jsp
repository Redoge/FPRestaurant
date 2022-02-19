<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static app.redoge.restaurant.DAO.OrderDAO.getAllOrders" %>
<%@ page import="static app.redoge.restaurant.Order.orderStatus.getStatus" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 10:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%  UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)){
            response.sendRedirect(request.getContextPath());}

        ArrayList<Order> orders = getAllOrders();
        String info = (String) request.getAttribute("info");
        if (info == null){info = "";}
    %>

    <title>Manage orders</title>

</head>
<body>
<h1>Manage orders</h1>
<a href="<%=request.getContextPath()%>">Main</a>
<h3><%=info%></h3>
<form action="<%=request.getContextPath() + "/manager/changeOrderStatus"%>" method="post">
    <label for="AllMenu">Order id:</label><br>
    <input type = "text" list = "AllMenu" name="changed_id">
    <datalist id = "AllMenu">
        <%for(Order order: orders){%>
        <option value = "<%=order.getOrder_id()%>"><% } %>
    </datalist>
    <br><br>
    <label for="AllAtatus">New Status:</label><br>
    <input type = "text" list = "AllAtatus" name="changed_status">
    <datalist id = "AllAtatus">
        <%for(Order.orderStatus order: Order.orderStatus.values()){%>
        <option value = "<%=order%>"><% } %>
    </datalist>
    <br><br>
    <input type="submit"  value="Submit">
</form>


<TABLE BORDER="1" width="90%" ALIGN="CENTER">
    <TR>
        <TH>Name of dish</TH>
        <TH>Count</TH>
        <TH>Price (UAH)</TH>
        <th>Order id</th>
        <th>Status</th>
    </TR>
        <% for(Order order: orders){ %>
    <TR>
        <TD> <%= order.getName() %></td>
        <TD> <%= order.getCount() %></TD>
        <TD> <%= order.getPrice() %> </TD>
        <TD> <%= order.getOrder_id() %></TD>
        <TD> <%= order.getStatus() %></TD>
    </TR>
        <% } %>




</body>
</html>
