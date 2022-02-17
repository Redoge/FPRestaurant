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
<a href="login">Login</a> <%} else{%>
<a href="cabinet">Cabinet</a>   <%}%>





<br><br>
        <h1>RESTAURANT</h1>
<a href="<%=request.getContextPath()%>">Main</a>
</body>
</html>
