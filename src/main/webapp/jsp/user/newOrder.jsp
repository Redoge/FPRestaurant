<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="java.util.Map" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getAllMenuMap" %><%--
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

</head>
<body>
<h1>New order</h1>
<a href="<%=request.getContextPath()%>">Main</a>
<h1>Make order</h1>
<form action="<%=request.getContextPath() + "/user/new-orderPost"%>" method="post">
    <label for="AllMenu">Category:</label><br>
    <input type = "text" list = "AllMenu" name="id">
    <datalist id = "AllMenu">
        <% Map<Integer, String> dishes = getAllMenuMap();
            for(int id: getAllMenuMap().keySet()){ %>
        <option value = "<%= id%>"><%=dishes.get(id)%></option><% } %>
    </datalist>
    <br><br>

    <label for="count">Price:</label><br>
    <input type="number" id="count" name="count"><br><br>
    <input type="submit"  value="Submit">
</form>




</body>
</html>
