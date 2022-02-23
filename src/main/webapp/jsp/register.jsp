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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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
                <a class="nav-link " href="<%=request.getContextPath() + "/login"%>" >Login</a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/register"%>">Register</a>
            </div>
        </div>
    </div>
</nav>
<hr>
<%--<form action="<%=request.getContextPath() + "/registerPost" %>" method="post">--%>
<%--    <label for="email">E-mail:</label>--%>
<%--    <input class="form-control" type="email" id="email" name="email"><br><br>--%>

<%--    <label for="username">Username:</label>--%>
<%--    <input class="form-control" type="text" id="username" name="username"><br><br>--%>

<%--    <label for="password">Password:</label>--%>
<%--    <input class="form-control" type="password" id="password" name="password"><br><br>--%>

<%--    <input class="btn btn-outline-secondary" type="submit" value="Register">--%>
<%--</form>--%>

<div>

    <form action="<%=request.getContextPath() + "/registerPost" %>" method="post">

        <div class="container">
            <div class="row" >
                <%if(info.length() != 0){%>
                <div class="forAlert">
                    <div class="alert alert-secondary form-group"  role="alert">
                        <%=info%>
                    </div></div><%}%>
                <div class="form-group">
                    <label for="email">E-mail:</label>
                    <input class="form-control" type="email" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input class="form-control" type="text" id="username" name="username">
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input class="form-control" type="password" id="password" name="password">
                </div>
                <div class="form-group" align="center">
                    <br>
                    <input  class="btn btn-outline-secondary" type="submit" value="Register">
                </div>
            </div>
        </div>
    </form>
</div>


</body>
</html>
