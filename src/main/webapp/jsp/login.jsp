<%@ page import="app.redoge.restaurant.enums.UserRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String language = (String) session.getAttribute("language");%>
<fmt:setLocale value="<%=language%>"/>
<fmt:setBundle basename="language" var="rb"/>
<%@ taglib uri="http://redoge.app" prefix="rt" %>
<html translate="no">
<head>
    <% UserRole role = (UserRole) request.getSession().getAttribute("role");
        if (role == null) {
        } else if ((role.equals(UserRole.User)) || (role.equals(UserRole.Manager))) {
            response.sendRedirect(request.getContextPath());
        }
    %>
    <title><fmt:message key="Login" bundle="${rb}"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        <%@include file='/css/css.css' %>
        <%@include file='/css/bootstrap.css' %>
    </style>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link " href="<%=request.getContextPath()+ "/dishesMenu" %>"><fmt:message key="Dishes_menu"
                                                                                                       bundle="${rb}"/></a>
                <a class="nav-link active" href="<%=request.getContextPath() + "/login"%>"><fmt:message key="Login"
                                                                                                        bundle="${rb}"/></a>
                <a class="nav-link" href="<%=request.getContextPath() + "/register"%>"><fmt:message key="Register"
                                                                                                    bundle="${rb}"/></a>
            </div>
            <%--Language--%>
            <div class="navbar-nav ms-auto mb-2 mb-lg-0">
                <form method="post" action="<%=request.getContextPath() + "/changeLanguage"%>">
                    <input type="hidden" name="path" value="<%=request.getServletPath()%>">
                    <%if (language.equalsIgnoreCase("en_US")){%>
                    <input type="hidden" name="language" value="uk_UA"/>
                    <button type="submit" class="nav-link btn" href="#">UKR</button>
                    <%}else{%>
                    <input type="hidden" name="language" value="en_US"/>
                    <button type="submit" class="nav-link btn" href="#">ENG</button>
                    <%}%>
                </form>
            </div>
            <%--Language--%>
        </div>
    </div>
</nav>
<hr>

<div>
    <div class="container">
        <form action="" method="post">


            <div class="row">
                <%if (request.getParameter("info") != null) {%>
                <div class="forAlert">
                    <div class="alert alert-secondary form-group" role="alert">
                        <%=request.getParameter("info")%>
                    </div>
                </div>
                <%}%>
                <div class="form-group">
                    <label for="email">E-mail / username:</label>
                    <input required type="text"
                           class="form-control" id="email" name="email" placeholder="E-mail / username">
                </div>
                <div class="form-group">
                    <label for="password"><fmt:message key="Password" bundle="${rb}"/>:</label>
                    <input required type="password" class="form-control" id="password" name="password"
                           placeholder="Password">
                    <%--                <input required pattern="^.{5,20}$" type="password" class="form-control" id="password" name="password"  placeholder="Password">--%>
                </div>
                <div class="form-group" align="center">
                    <br>
                    <div class="form-captcha">
                        <div class="g-recaptcha" hidden="true"
                             data-sitekey="6LcBDLweAAAAAEM78RQL_kwXWtadCiVI1BZQW5rx"></div>
                    </div>
                    <br>
                    <button class="btn btn-outline-secondary" type="submit"><fmt:message key="Login"
                                                                                         bundle="${rb}"/></button>


                </div>
            </div>
        </form>
    </div>
</div>


<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
        async defer>
</script>
<script type="text/javascript">
    var onloadCallback = function () {
        reCaptcha('.form-captcha');
    };

    function reCaptcha(selector) {
        var $wg = $(selector);
        $wg.each(function () {
            var id = randomString(10),
                $form = $(this).closest('form');
            console.log("dT");
            console.log('id', id);
            $form.find('button[type="submit"]').prop('disabled', true);
            $(this).append($('<div class="g-recaptcha lololo" id="' + id + '"></div>'));
            grecaptcha.render(id, {
                sitekey: $(this).find('.g-recaptcha').data('sitekey') || '',
                callback: function (response) {
                    if (!!response) {
                        console.log("dF");
                        $form.find('button[type="submit"]').prop('disabled', false);
                    }
                }
            });
        });
        console.log("End")
    };

    function randomString(length) {
        var chars = '0123456789abcdefghijklmnopqrstuvwxyz'.split('');
        // var result = ;
        console.log(length);
        var result = Math.floor(Math.random() * 1000000000).toString();
        console.log("result: " + result);
        return result;
    }

    var reCaptchaOnLoadCallback = function () {
        reCaptcha('.form-captcha');
    }

</script>
</body>
</html>
