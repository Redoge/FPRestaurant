<%@ page import="app.redoge.restaurant.UserRole" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%  UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.Manager)){
            response.sendRedirect(request.getContextPath());}
    %>

    <title>New order</title>
</head>
<body>
<h1>New order</h1>
<a href="<%=request.getContextPath()%>">Main</a>
</body>
</html>
