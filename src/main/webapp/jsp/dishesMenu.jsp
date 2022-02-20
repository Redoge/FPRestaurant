<%@ page import="java.util.Map" %>
<%@ page import="app.redoge.restaurant.DishesMenu" %>
<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getDishIdBySorted" %>
<%@ page import="app.redoge.restaurant.Dish" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dishes Menu</title>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script type="text/javascript">
        <%@include file='/js/sort-table.js'%>
    </script>
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
                <a class="nav-link active" href="<%=request.getContextPath()+ "/dishesMenu" %>">Dishes menu</a>
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
<%
    String category = "category_id";
    Map<Integer, Dish> dishes = getDishIdBySorted(category);
%>
<hr>
<div class="row">
    <div class="col-2 position-relative start-50" align="center">
        <label for="input_group" >Group by:</label>
        <select class="form-select" aria-label="Default select example" id="input_group" >
            <option value = "">All</option>
            <% DishesMenu[] dishesMenuArr = DishesMenu.values(); for(DishesMenu dm: dishesMenuArr){ if(dm.equals(DishesMenu.Unknown)){continue;}%>
               <option value = "<%=dm%>"><%=dm%></option>
            <%}%>
        </select>
        <button class="btn btn-outline-secondary" id=""  onclick="groupDishByCategory();">Grupped</button>
    </div>
</div>
<div class="container">
    <div class="row">
        <TABLE cellspacing="0"   width="100%"  class="sort-table.js table js-sort-table" id="table_dish">
            <thead>
                <TR>
                    <TH>Name</TH>
                    <TH>Category</TH>
                    <TH class="js-sort-number">Price (UAH)</TH>
                </TR>
            </thead>
            <% for(int id: dishes.keySet()){ %>
            <TR>
                <TD> <%= dishes.get(id).getName() %></td>
                <TD> <%= dishes.get(id).getCategory() %></TD>
                <TD> <%= dishes.get(id).getPrice() %></TD>
            </TR>
            <% } %>
        </TABLE>
    </div>
</div>

<script>
    function groupDishByCategory() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("input_group");
        filter = input.value.toUpperCase();
        table = document.getElementById("table_dish");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>
</body>
</html>
