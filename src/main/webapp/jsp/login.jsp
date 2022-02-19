<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>s
</head>
    <body>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if(role == null){
    }
       else if ((role.equals(UserRole.User)) || (role.equals(UserRole.Manager))){response.sendRedirect(request.getContextPath());}
        String info = (String) request.getAttribute("info");
       if (info == null){info = "";}

    %>
    <h3><%=info%></h3>
    <div >
    <form action="" method="post">
        <div class="form-floating mb-3">
            <input class="form-control" type="email" id="email" name="email">
            <label for="email">E-mail:</label>
        </div>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>
        <input type="submit" value="Submit">
    </form>
    </div>
    <hr>

    <a href="<%=request.getContextPath() + "/register"%>">Register</a><br><br>
    <a href="<%=request.getContextPath()%>">Main</a>

<%--        <script type="text/javascript">--%>
<%--            <%@include file='/js/bootstrapjs.js' %>--%>
<%--        </script>--%>
   </body>
</html>
