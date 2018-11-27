<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:set var="breadcrumb" value="${['Home']}" scope="request"/>
    <meta name="layout" content="main">
    <title>Startseite - Exfy.de User CP</title>
</head>

<body>

<div class="jumbotron">
    <h1>Hallo, <g:if test="${session.loggedIn}">${session.user}</g:if><g:else>Unbekannter</g:else>!</h1>

    <p class="lead">Hier kannst du all deine Spieleinstellungen ansehen und verwalten.</p>
</div>

<div class="body-content">

    <g:if test="${!session.loggedIn}"><p
            class="info">Diese Seite verwendet Cookies. Durch die Nutzung unserer Seite erklären Sie sich damit einverstanden, dass wir Cookies setzen. <a
                href="${createLink(controller: 'cookies')}">Weitere Informationen</a></p></g:if>

    <div class="row">
        <div class="col-lg-4">
            <h2>Errungenschaften</h2>

            <p>In deiner Karriere als Superheld bekommst du oft tolle Titel verliehen. Schau sie dir jetzt online an!</p>

            <p><a class="btn btn-info" href="${createLink(controller: 'achievement')}">Errungenschaften</a></p>
        </div>

        <div class="col-lg-4">
            <h2>Statistiken</h2>

            <p>Bist du schon in den Top 10? Nein? Dann schau schnell in die Statistiken und fordere die Elite zum Duell heraus!</p>

            <p><a class="btn btn-info" href="${createLink(controller: 'topStats')}">Statistiken</a></p>
        </div>

        <div class="col-lg-4">
            <h2>Einstellungen</h2>

            <p>Veränderst du noch die Einstellungen oder spielst du schon? Jetzt auch online ver&aumlnderbar!</p>

            <p><a class="btn btn-danger">Bald Verfügbar! :)</a></p>
        </div>
    </div>

    <footer class="page-footer font-small blue pt-4 mt-4" style="
    text-align: center;
    margin-top: 35px;
    margin-bottom: 15px;
    ">
        <p style="
        margin-bottom: 0px;
        ">Dieser Service wird vom Exfynation Netzwerk betrieben.</p>
        <a href="https://exfy.de/web/index.php/LegalNotice/" target="_blank" style="
        color: #333333;
        ">Impressum</a></footer>
</div>
</body>
</html>