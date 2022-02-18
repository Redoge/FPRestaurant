<%@ page import="java.sql.*" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getConnection" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="app.redoge.restaurant.DishesMenu" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dishes Menu</title>
</head>
<body>
<h1>Dishes menu</h1>
<a href="<%=request.getContextPath()%>">Main</a>

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
<TABLE BORDER="1" width="90%" ALIGN="CENTER">
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
