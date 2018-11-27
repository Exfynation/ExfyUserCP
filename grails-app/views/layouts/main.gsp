<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><g:layoutTitle default="Exfy.de User CP"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="theme-color" content="#283b46">
        <asset:stylesheet src="application.css"/>        
        <asset:javascript src="application.js"/>
        <g:layoutHead/>
    </head>
    <body>
        <div class="container" id="pageHeader">
            <nav class="navbar navbar-inverse navbar-fixed-top" style="position: absolute; border-radius: 8px 8px 0 0;"> 
                <div class="container" style="border-radius: 8px 8px 0 0;">
                    <div class="navbar-header">
                        <button id="toggleButton" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar" id="bar1"></span>
                            <span class="icon-bar" id="bar2"></span>
                            <span class="icon-bar" id="bar3"></span>
                            </button>
                        <a class="navbar-brand" href="/">Exfy.de User CP
                            <g:if test="${session.loggedIn}">
                                <img id="head-toggle" src="https://cravatar.eu/avatar/${session.uuid}/32.png" width="32" height="32" class="img-rounded mobile" />&nbsp;
                            </g:if>
                        </a>
                     </div>
                    <div id="navbar" class="collapse navbar-collapse">
                        <ul class="nav navbar-nav">
                            <li ${controllerName.equals('home') ? raw('class="active"') : ''}>
                                <a href="/">Home</a>
                            </li>
                            <li ${controllerName.equals('achievement') ? raw('class="active"') : ''}>
                                <g:link controller="achievement">Errungenschaften</g:link>
                            </li>
                            <li ${controllerName.equals('stats') || controllerName.equals('topStats') ? raw('class=active') : ''}>
                                <g:link controller="topStats">Statistiken</g:link>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <g:if test="${session.loggedIn}">
                                <li class="mobile"><a href="http://exfy.de">Zurück zum Forum</a></li>
                                <li class="mobile"><a href="/tempAuth/logout" data-no-instant>Vom temporärem Login      ausloggen</a></li>
                            </g:if>
                            <g:else>
                               <li><a href="http://exfy.de">Zurück zum Forum</a></li>
                            </g:else>
                            <g:if test="${session.loggedIn}">
                                <li class="dropdown desktop">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <img src="https://cravatar.eu/avatar/${session.uuid}/32.png" width="32" height="32" class="img-rounded" />&nbsp;
                                        ${session.user}&nbsp;<span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a href="http://exfy.de">Zurück zum Forum</a></li>
                                        <g:if test="${session.type == 'temp'}">
                                            <li><a href="${createLink(controller: 'tempAuth', action: 'logout')}" data-no-instant>Vom temporärem Login      ausloggen</a></li>
                                        </g:if>
                                    </ul>
                                </li>                           
                           </g:if>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        <div class="container" style="padding-top: 60px; border-radius: 8px;">
            <ol class="breadcrumb">
                <g:each in="${breadcrumb}" var="entry">
                    <g:if test="${entry instanceof java.util.Map}">
                        <li><a href="${entry.url}">${entry.name}</a></li>
                    </g:if>
                    <g:else>
                        <li class="active">${entry}</li>
                    </g:else>
                </g:each>
            </ol>
            <g:if test="${request.getAttribute("showVerifyWarning")}">
                <div class="alert alert-info" role="alert">
                    <strong>Nicht verifiziert!</strong>
                    Du bist zwar im Forum angemeldet, aber dein Account wurde nicht verifiziert! <br />
                    Um in diesem Panel deine Einstellungen vewalten zu können, musst du deinen Forenaccount verifizierien!
                </div>
            </g:if>
            <g:if test="${flash.message != null}">
                <g:if test="${flash.message.type == "success"}">
                    <p class="success">${flash.message.message}</p>
                </g:if> 
                <g:else>
                    <p class="error">${flash.message.message}</p>
                </g:else>
            </g:if>
            <g:layoutBody/>
        </div>
        <script data-no-instant>InstantClick.init();</script>
    </body>
</html>
