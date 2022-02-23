<%@ page import="app.redoge.restaurant.UserRole" %>
<%@ page import="app.redoge.restaurant.User" %>
<%@ page import="java.util.List" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getAllUser" %>
<%--<%@ page import="app.redoge.restaurant.Order" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage</title>
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

</head>
<body>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
        response.sendRedirect(request.getContextPath());
    }
    List<User> userList = getAllUser();
    String info = (String) request.getAttribute("info");
    if (info == null) {
        info = "";
    }

%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>">Restaurant</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <%if (role.equals(UserRole.Manager)) {%>
                <a class="nav-link active" href="<%=request.getContextPath() + "/manager/manage"%> ">Manage</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-menu"%>">Manage menu</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-orders"%>">Manage orders</a>
                <%} else if (role.equals(UserRole.User)) {%>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/orders"%>">My order</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/user/new-order"%>">New order</a>
                <%}%>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>">Cabinet</a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>">Dishes Menu</a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>">Logout</a>
            </div>
        </div>
    </div>
</nav>


<div class="container">
    <div class="row ">
        <%if (info.length() != 0) {%>
        <div class="forAlert">
            <div class="alert alert-secondary form-group" role="alert">
                <%=info%>
            </div>
        </div>
        <%}%>
        <form action="<%=request.getContextPath() + "/manager/manage/changeRole"%>" method="post">
            <label for="AllMenu">New role:</label><br>
            <%--    <input type = "text" list = "AllMenu" name="changed_id">--%>
            <select id="AllMenu" name="newRole" class="form-select">
                <%
                    for (UserRole userRoleForm : UserRole.values()) {
                        if (userRoleForm.getId() != 2 && userRoleForm.getId() != 3) {
                            continue;
                        }
                %>
                <option value="<%=userRoleForm.getId()%>"><%=userRoleForm%>
                        <% } %>
            </select>
            <label for="userId">User id:</label>
            <input id="userId" type="number" list="userIdList" name="userId" class="form-select" list="userIdList">
            <datalist id="userIdList" >
                <%for (User userForm : userList) {%>
                <option value="<%=userForm.getId()%>"><%=userForm.getUsername()%>
                        <% } %>
            </datalist>
            <br>
            <div align="center"><input type="submit" value="Change order status" class="btn btn-outline-secondary">
            </div>

        </form>
    </div>
    <div class="row">
        <TABLE BORDER="1" width="90%" ALIGN="CENTER" class="table">
            <TR>
                <TH>Id</TH>
                <TH>Username</TH>
                <TH>Email</TH>
                <th>Role</th>
            </TR>
                <% for(User user: userList){%>
            <TR>
                <TD><%= user.getId() %>
                </td>
                <TD><%= user.getUsername() %>
                </TD>
                <TD><%= user.getEmail() %>
                </TD>
                <TD><%= UserRole.getUserRole(user.getRole()) %>
                </TD>
            </TR>
                <% } %>
    </div>
</div>


</body>
</html>
