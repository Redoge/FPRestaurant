<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
    <body>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if(role == null){
    }
       else if ((role.equals(UserRole.User)) || (role.equals(UserRole.Manager))){response.sendRedirect(request.getContextPath());}
    %>
    <style>
        input[type=text], input[type=password], input[type=email]{
            width: 100%;
            margin: 8px 0;
            padding: 12px 20px;
            display: inline-block;
            border: 2px solid green;
            box-sizing: border-box;
        }
    </style>
    <form action="" method="post">
        <label for="email">E-mail:</label>
        <input type="email" id="email" name="email"><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>
        <input type="submit" value="Submit">
    </form>
    <hr>
    <a href="<%=request.getContextPath() + "/register"%>">Register</a><br><br>
    <a href="<%=request.getContextPath()%>">Main</a>
    </body>
</html>
