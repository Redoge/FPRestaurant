<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Restaurant</title>
</head>
<body>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown)){
%>
<a href="<%=request.getContextPath() + "/login"%>">Login</a> <%} else{%>
<a href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>   <%}%>
<a href="<%=request.getContextPath()%>">Main</a>
<a href="<%=request.getContextPath() + "/dishesMenu"%>">Menu</a>

<br><br>
        <h1>RESTAURANT</h1>
</body>
</html>
