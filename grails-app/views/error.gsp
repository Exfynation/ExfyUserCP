<!doctype html>
<html>
    <head>
    <g:set var="breadcrumb" value="${[
                [url: createLink(controller: 'home'), name: 'Home'],
                'Error'
                ]}" scope="request" />   
        <title>Error - Exfy.de User CP</title>
        <meta name="layout" content="main">
        <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
    </head>
    <body>
        <g:if env="development">
            <g:if test="${Throwable.isInstance(exception)}">
                <g:renderException exception="${exception}" />
            </g:if>
            <g:elseif test="${request.getAttribute('javax.servlet.error.exception')}">
                <g:renderException exception="${request.getAttribute('javax.servlet.error.exception')}" />
            </g:elseif>
            <g:else>
                <ul class="errors">
                    <li>An error has occurred</li>
                    <li>Exception: ${exception}</li>
                    <li>Message: ${message}</li>
                    <li>Path: ${path}</li>
                </ul>
            </g:else>
        </g:if>
        <g:else>
            <div class="jumbotron">
                <h1>Das Krümelmonster hat zugeschlagen!</h1>
                <p class="lead">Deine Anfrage konnte leider auf Grund eines Errors nicht verarbeitet werden. Tut uns leid :(</p>
            </div>
        </g:else>
    </body>
</html>
