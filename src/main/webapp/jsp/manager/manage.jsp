<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page import="app.redoge.restaurant.User" %>
<%@ page import="java.util.List" %>
<%@ page import="static app.redoge.restaurant.DAO.UserDao.getAllUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language"  var="rb"/>
<% UserRole role = (UserRole) request.getSession().getAttribute("role");
    if (role == null || role.equals(UserRole.Unknown) || role.equals(UserRole.User)) {
        response.sendRedirect(request.getContextPath());
    }
    List<User> userList = getAllUser();
%>
<html translate="no">
<head>
    <title><fmt:message key="Manage" bundle="${rb}"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript">
        <%@include file='/js/sort-table.js'%>
    </script>
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <meta charset="utf-8">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
            integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

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
                <%if(role != null && role.equals(UserRole.Manager)){%>
                <a class="nav-link active"  href="<%=request.getContextPath() + "/manager/manage"%> "><fmt:message key="Manage" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-menu"%>"><fmt:message key="Manage_menu" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/manager/manage-orders"%>"><fmt:message key="Manage_orders" bundle="${rb}"/></a>
                <%}%>
                <a class="nav-link " href="<%=request.getContextPath() + "/cabinet"%>"><fmt:message key="Cabinet" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/dishesMenu"%>"><fmt:message key="Dishes_menu" bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath()+ "/logout"%>"><fmt:message key="Logout" bundle="${rb}"/></a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row ">
        <%if(request.getParameter("info") != null){%>
        <div class="forAlert">
            <div class="alert alert-secondary form-group" role="alert">
                <%=request.getParameter("info")%>
            </div>
        </div><%}%>

        <form action="<%=request.getContextPath() + "/manager/manage/changeRole"%>" method="post">
            <label for="AllMenu"><fmt:message key="New_role" bundle="${rb}"/></label><br>
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
            <label for="userId"><fmt:message key="User_id" bundle="${rb}"/>:</label>
            <input required id="userId" type="number" list="userIdList" name="userId" class="form-select" list="userIdList" placeholder="ID">
            <datalist id="userIdList" >
                <%for (User userForm : userList) {%>
                <option value="<%=userForm.getId()%>"><%=userForm.getUsername()%>
                        <% } %>
            </datalist>
            <br>
            <div align="center"><input type="submit" value="<fmt:message key="Change_user_role" bundle="${rb}"/>" class="btn btn-outline-secondary">
            </div>

        </form>
    </div>
    <div class="row">
        <TABLE cellspacing="0" width="100%" class="sort-table.js table js-sort-table" id="table_dish">
            <TR>
                <TH class="js-sort-number">Id</TH>
                <TH><fmt:message key="Username" bundle="${rb}"/></TH>
                <TH>Email</TH>
                <th><fmt:message key="Role" bundle="${rb}"/></th>
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
