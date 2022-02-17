<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.DishesMenu" %><%--
  Created by IntelliJ IDEA.
  User: danyl
  Date: 2/16/2022
  Time: 10:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%  UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)){
            response.sendRedirect(request.getContextPath());}
    %>


    <title>Manage menu</title>
</head>
<body>
<h1>Manage menu</h1>
<a href="<%=request.getContextPath()%>">Main</a>

<style>
    input[type=text], input[type=password],  input[type=number]{
        align-content: center;
        width: 50%;
        margin: 8px 0;
        padding: 12px 20px;
        display: inline-block;
        border: 2px solid green;
        box-sizing: border-box;
    }
</style>


<form action="<%=request.getContextPath() + "/manager/manage/add-dishes"%>" method="post">
    <label for="name">Name of the dish:</label><br>
    <input type="text" id="name" name="name"><br><br>

    <label for="price">Price:</label><br>
    <input type="number" id="price" name="price"><br><br>

    <label for="category">Category:</label><br>
    <input type = "text" list = "category" name="category">
    <datalist id = "category">
            <% for(DishesMenu name: DishesMenu.values()){ %>
        <option value = "<%= name.getId()%>"><%=name%></option> <% } %>
    </datalist>
    <br>

    <input type="submit"  value="Submit">

</form>

</body>
</html>
