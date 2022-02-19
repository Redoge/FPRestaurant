<%@ page import="app.redoge.restaurant.UserRole" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 11:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <style>
        <%@include file='/css/css.css' %>
    </style>
</head>
<body>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if(role == null){
    }
    else if ((role.equals(UserRole.User)) || (role.equals(UserRole.Manager))){response.sendRedirect(request.getContextPath());}
%>

<form action="<%=request.getContextPath() + "/registerPost" %>" method="post">
    <label for="email">E-mail:</label>
    <input type="email" id="email" name="email"><br><br>

    <label for="username">Username:</label>
    <input type="text" id="username" name="username"><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password"><br><br>

    <input type="submit" value="Submit">
</form>
<a href="<%=request.getContextPath()%>">Main</a>



</body>
</html>
