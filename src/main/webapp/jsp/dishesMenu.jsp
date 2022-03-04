<%@ page import="java.util.Map" %>
<%@ page import="app.redoge.restaurant.enums.Category" %>
<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getDishIdBySorted" %>
<%@ page import="app.redoge.restaurant.Dish" %>
<%@ page import="static app.redoge.restaurant.DAO.DishesDAO.getAllMenuMap" %>
<%@ page import="app.redoge.restaurant.enums.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language" var="rb"/>

<html translate="no">
<head>
    <title>Dishes Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
            integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script type="text/javascript">
        <%@include file='/js/sort-table.js'%>
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>">Restaurant</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link active" href="<%=request.getContextPath()+ "/dishesMenu" %>"><fmt:message
                        key="Dishes_menu" bundle="${rb}"/></a>
                <% UserRole role = (UserRole) request.getSession().getAttribute("role");
                    if (role == null || role.equals(UserRole.Unknown)) {
                %>
                <a class="nav-link" href="<%=request.getContextPath() + "/login"%>"><fmt:message key="Login"
                                                                                                 bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/register"%>"><fmt:message key="Register"
                                                                                                    bundle="${rb}"/></a> <%} else {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/cabinet"%>"><fmt:message key="Cabinet"
                                                                                                   bundle="${rb}"/></a> <%}%>
            </div>
        </div>
    </div>
</nav>
<%
    String category = "category_id";
    Map<Integer, Dish> dishes = getDishIdBySorted(category);
%>
<hr>
<div class="container">
    <div class="row">
        <div class="col position-relative" align="center">
            <label for="input_group"><fmt:message key="Group_by" bundle="${rb}"/></label>
            <select class="form-select" aria-label="Default select example" id="input_group">
                <option value="">All</option>
                <% Category[] dishesMenuArr = Category.values();
                    for (Category dm : dishesMenuArr) {
                        if (dm.equals(Category.Unknown)) {
                            continue;
                        }%>
                <option value="<%=dm%>"><%=dm%>
                </option>
                <%}%>
            </select>
            <button class="btn btn-outline-secondary" id="" onclick="groupDishByCategory();"><fmt:message key="Grupped"
                                                                                                          bundle="${rb}"/></button>
        </div>
        <%if (role != null && role.equals(UserRole.User)) {%>

        <div id="newOrderDiv" class="col position-relative" align="center">
            <%if (request.getParameter("info") != null) {%>
            <div class="forAlert">
                <div class="alert alert-secondary form-group" role="alert">
                    <%=request.getParameter("info")%>
                </div>
            </div>
            <%}%>
            <br>
            <div>
                <button class="btn spoiler-trigger btn-outline-secondary" onclick="showModalWin()"><fmt:message key="New_order"
                                                                                       bundle="${rb}"/>:
                </button>
                <div  id="popupWin" class="modalwin">
                    <form action="<%=request.getContextPath() + "/user/new-orderPost"%>" method="post">
                        <label for="AllMenu"><fmt:message key="Name_of_the_dish" bundle="${rb}"/>:</label>
                        <select id="AllMenu" class="form-select" name="id">
                            <% Map<Integer, String> dishesMap = getAllMenuMap();
                                for (int id : dishes.keySet()) { %>
                            <option value="<%= id%>"><%=dishes.get(id).getName()%>
                            </option>
                            <% } %>
                        </select>
                        <div class="form-group">
                            <label for="count"><fmt:message key="Count" bundle="${rb}"/>:</label>
                            <input required type="number" class="form-control" id="count" name="count"
                                   placeholder="<fmt:message key="Count" bundle="${rb}"/>">
                        </div><br>
                        <input type="submit" class="btn btn-outline-secondary"
                               value="<fmt:message key="New_order" bundle="${rb}"/>">
                    </form>
                </div>
            </div>
        </div>
        <%}%>
    </div>
</div>

<div class="container">
    <div class="row">
        <TABLE cellspacing="0" width="100%" class="sort-table.js table js-sort-table" id="table_dish">
            <thead>
            <TR>
                <TH><fmt:message key="Name" bundle="${rb}"/></TH>
                <TH><fmt:message key="Category" bundle="${rb}"/></TH>
                <TH class="js-sort-number"><fmt:message key="Price" bundle="${rb}"/> (UAH)</TH>
            </TR>
            </thead>
            <% for (int id : dishes.keySet()) { %>
            <TR>
                <TD><%= dishes.get(id).getName() %>
                </td>
                <TD><%= dishes.get(id).getCategory() %>
                </TD>
                <TD><%= dishes.get(id).getPrice() %>
                </TD>
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

    $(document).on('click', '.spoiler-trigger', function (e) {
        e.preventDefault();
        $(this).toggleClass('active');
        $(this).parent().find('.spoiler-block').first().slideToggle(300);
    })

    function showModalWin() {
        var darkLayer = document.createElement('div'); // слой затемнения
        darkLayer.id = 'shadow'; // id чтобы подхватить стиль
        document.body.appendChild(darkLayer); // включаем затемнение

        var modalWin = document.getElementById('popupWin'); // находим наше "окно"
        modalWin.style.display = 'block'; // "включаем" его

        darkLayer.onclick = function () {  // при клике на слой затемнения все исчезнет
            darkLayer.parentNode.removeChild(darkLayer); // удаляем затемнение
            modalWin.style.display = 'none'; // делаем окно невидимым
            return false;
        };
    }

</script>
</body>
</html>
