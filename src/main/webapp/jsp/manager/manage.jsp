<%@ page import="app.redoge.restaurant.UserRole" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 5:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage</title>
</head>
<body>
<%  UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)){
        response.sendRedirect(request.getContextPath());}
%>
    <a href="<%=request.getContextPath()%>">Main</a>
</body>
</html>
