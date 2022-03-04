<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language"  var="rb"/>

<html translate="no">
<head>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
        if(role == null){
        }
        else if ((role.equals(UserRole.User)) || (role.equals(UserRole.Manager))){response.sendRedirect(request.getContextPath());}
    %>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
    <body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%=request.getContextPath()%>">Restaurant</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link " href="<%=request.getContextPath()+ "/dishesMenu" %>"><fmt:message key="Dishes_menu" bundle="${rb}"/></a>
                    <a class="nav-link active" href="<%=request.getContextPath() + "/login"%>" ><fmt:message key="Login" bundle="${rb}"/></a>
                    <a class="nav-link" href="<%=request.getContextPath() + "/register"%>"><fmt:message key="Register" bundle="${rb}"/></a>
                </div>
            </div>
        </div>
    </nav>
    <hr>

    <div>

        <form action="" method="post">

        <div class="container">
        <div class="row" >
            <%if(request.getParameter("info") != null){%>
            <div class="forAlert">
                <div class="alert alert-secondary form-group" role="alert">
                    <%=request.getParameter("info")%>
                </div>
            </div><%}%>
            <div class="form-group">
                <label for="email">E-mail:</label>
                <input required  pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" type="email" class="form-control" id="email" name="email" placeholder="Email">
            </div>
            <div class="form-group">
                <label for="password"><fmt:message key="Password" bundle="${rb}"/>:</label>
                <input required  type="password" class="form-control" id="password" name="password"  placeholder="Password">
<%--                <input required pattern="^.{5,20}$" type="password" class="form-control" id="password" name="password"  placeholder="Password">--%>
            </div>
            <div class="form-group" align="center">
                <br>
                <input  class="btn btn-outline-secondary" type="submit" value="<fmt:message key="Login" bundle="${rb}"/>">
            </div>
        </div>
    </div>
        </form>
    </div>

   </body>
</html>
