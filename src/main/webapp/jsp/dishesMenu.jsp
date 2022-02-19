<%@ page import="java.sql.*" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getConnection" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="app.redoge.restaurant.DishesMenu" %>
<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dishes Menu</title>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
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
<%--                <a class="nav-link " aria-current="page" href="<%=request.getContextPath()%>">Main</a>--%>
                <a class="nav-link active" href="<%=request.getContextPath()+ "/dishesMenu" %>">Dishes menu</a>
                <% UserRole role = (UserRole) request.getSession().getAttribute("role");
                    if (role == null || role.equals(UserRole.Unknown)){
                %>
                <a class="nav-link" href="<%=request.getContextPath() + "/login"%>" >Login</a> <%} else{%>
                <a class="nav-link" href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>   <%}%>
            </div>
        </div>
    </div>
</nav>





<%
    ResultSet resultset =null;
    Map<String, Map<String, Double>> dishes= new HashMap<>();
    try {
    Connection connection = getConnection();
    Statement statement = connection.createStatement() ;
    resultset = statement.executeQuery("select * from dishes");
        while(resultset.next()){
            Map<String, Double> tmp = new HashMap<>();
            tmp.put(DishesMenu.getDishesCategory(resultset.getInt("category_id")).toString(), resultset.getDouble("price"));
            dishes.put(resultset.getString("name"), tmp);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<TABLE BORDER="1" width="90%" ALIGN="CENTER" class="table table-hover">
    <TR>
        <TH>Name</TH>
        <TH>Category</TH>
        <TH>Price (UAH)</TH>

    </TR>
    <% for(String name: dishes.keySet()){ %>
    <TR>
        <TD> <%= name %></td>
        <TD> <%= dishes.get(name).keySet().toArray()[0] %></TD>
        <TD> <%= dishes.get(name).values().toArray()[0] %></TD>
    </TR>
    <% } %>



</TABLE>
</body>
</html>
