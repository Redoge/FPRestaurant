<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
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
        String info = (String) request.getAttribute("info");
       if (info == null){info = "";}

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
                    <a class="nav-link active" href="<%=request.getContextPath() + "/login"%>" >Login</a>
                    <a class="nav-link" href="<%=request.getContextPath() + "/register"%>">Register</a>
                </div>
            </div>
        </div>
    </nav>
    <hr>

    <div >
        <form action="" method="post">
        <div class="container">
        <div class="row">
            <div class="col">
                <input  type="email" id="email" name="email">
                <label for="email">E-mail:</label>
            </div>
            <div class="col">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
            </div>
            <div class="col">
                <input type="submit" value="Submit">
            </div>
        </div>
    </div>
        </form>
    </div>

   </body>
</html>
