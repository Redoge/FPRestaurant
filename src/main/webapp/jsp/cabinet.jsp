<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cabinet</title>
</head>
<body>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown)){response.sendRedirect(request.getContextPath());
%>
<%} else if(role.equals(UserRole.Manager)){%>
<a href="./manager/manage">Manage</a> <br><br>
<a href="./manager/manage-menu">Manage menu</a> <br><br>
<a href="./manager/manage-orders">Manage orders</a> <br><br><%}else if(role.equals(UserRole.User)){%><br><br>
<a href="./user/orders">My order</a><br><br>
<a href="./user/new-order">New order</a><br><br>
<%}%>
<a href="./dishesMenu">Dishes Menu</a><br><br>

<a href="<%=request.getContextPath()%>">Main</a>
</br></br>
${sessionScope.email}
</br></br>
${sessionScope.role}
<br><br>
<a href="./logout">Logout</a><br><br>
<a href="<%=request.getContextPath()+ "/logout"%>">Logout</a>


</body>
</html>
