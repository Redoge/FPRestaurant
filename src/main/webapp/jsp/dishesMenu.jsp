<%@ page import="java.util.Map" %>
<%@ page import="app.redoge.restaurant.DishesMenu" %>
<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getDishIdBySorted" %>
<%@ page import="app.redoge.restaurant.Dish" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getAllMenuMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dishes Menu</title>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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
    <%if (role != null && role.equals(UserRole.User)){%>

    <div id="newOrderDiv" class="col-2 position-relative"  align="center">
        <div>
            <button class="btn spoiler-trigger btn-outline-secondary">New order:</button>
<%--            <a class="spoiler-trigger"><span>New order:</span></a>--%>
            <div class="spoiler-block">

<%--            <h3>New order:</h3>--%>
        <form action="<%=request.getContextPath() + "/user/new-orderPost"%>" method="post">
            <label for="AllMenu">Dish:</label>
            <select id = "AllMenu" class = "form-select" name="id">
                <% Map<Integer, String> dishesMap = getAllMenuMap();
                    for(int id: getAllMenuMap().keySet()){ %>
                <option value = "<%= id%>"><%=dishesMap.get(id)%></option><% } %>
            </select>
            <div class="form-group">
                <label for="count">Count:</label>
                <input type="number" class="form-control" id="count" name="count">
            </div>
            <input type="submit"  class="btn btn-outline-secondary" value="Submit">
        </form>
    </div>
        </div>
    </div>
    <%}%>
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
    $(document).on('click','.spoiler-trigger',function(e){e.preventDefault();
        $(this).toggleClass('active');
        $(this).parent().find('.spoiler-block').first().slideToggle(300);
    })

</script>
</body>
</html>
