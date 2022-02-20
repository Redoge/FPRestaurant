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
        <%@include file='/css/bootstrap.css' %>
    </style>
</head>
<body>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if(role == null){
    }
    else if ((role.equals(UserRole.User)) || (role.equals(UserRole.Manager))){response.sendRedirect(request.getContextPath());}
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>">Restaurant</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link " href="<%=request.getContextPath()+ "/dishesMenu" %>">Dishes menu</a>
                <a class="nav-link " href="<%=request.getContextPath() + "/login"%>" >Login</a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/register"%>">Register</a>
            </div>
        </div>
    </div>
</nav>
<hr>
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
