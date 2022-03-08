<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language"  var="rb"/>

<html>
<head>
    <title><fmt:message key="Restaurant" bundle="${rb}"/></title>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Restaurant</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>">Main</a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/dishesMenu" %>">Dishes menu</a>
                <% UserRole role = (UserRole) request.getSession().getAttribute("role");
                    if (role == null || role.equals(UserRole.Unknown)){
                %>
                <a class="nav-link" href="<%=request.getContextPath() + "/login"%>" >Login</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/register"%>">Register</a> <%} else{%>
                <a class="nav-link" href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>   <%}%>
            </div>
        </div>
    </div>
</nav>




<br><br>
        <h1>RESTAURANT</h1>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>
