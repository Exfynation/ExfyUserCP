<%--
  Created by IntelliJ IDEA.
  User: ml
  Date: 05.01.16
  Time: 18:53
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <g:set var="breadcrumb" value="${[
            [url: createLink(controller: 'home'), name: 'Home'],
            '404'
    ]}" scope="request" />   
    <meta name="layout" content="main">
    <title>Error - Exfy.de User CP</title>
</head>

<body>
<div class="jumbotron">
    <h1>Seite wurde nicht gefunden!</h1>
    <p class="lead">Die Seite, nach der du gesucht hast, existiert leider nicht. Tut uns leid :(</p>
</div>
</body>
</html>