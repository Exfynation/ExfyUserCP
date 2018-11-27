<%--
  Created by IntelliJ IDEA.
  User: ml
  Date: 23.01.16
  Time: 15:09
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:set var="breadcrumb" value="${[
            [url: createLink(controller: 'home'), name: 'Home'],
            'Statistiken'
    ]}" scope="request" />
    <title>Statistiken - Exfy.de User CP</title>
    <meta name="layout" content="main">
</head>

<body>
    <div class="list-group">
        <g:each in="${stats}" var="entry">
            <a href="${createLink(controller: 'topStats', action: 'gamemode', id: entry.key)}" class="list-group-item">
                <div class="media">
                    <div class="media-body">
                        <g:each in="${entry.value.stats.reverse()}" var="item">
                            <img style="display: inline; float: right;" data-toggle="tooltip" data-placement="top"
                                 title="Platz ${item.rank + 1}<br />
                                 ${item.name}<br />
                                 ${entry.value.info.localization}:&nbsp;
                                 <g:formatStatistic score="${item.score}" type="${entry.value.info.type}" />"
                                 data-html="true"
                                 src='http://cravatar.eu/avatar/${item.uuid}/64.png' width="64" height="64" />
                        </g:each>
                        <h4 class="media-heading">
                            ${entry.key}&nbsp;
                        </h4>
                        <g:if test="${session.loggedIn}">
                            <g:if test="${entry.value.rank != null}">
                                <p style="display: inline-block; margin-bottom: 0px">
                                    Dein Rang: ${entry.value.rank.rank + 1}<br />
                                    ${entry.value.info.localization}: <g:formatStatistic score="${entry.value.rank.score}" type="${entry.value.info.type}" />
                                </p>
                            </g:if>
                            <g:else>
                                <p style="display: inline-block; margin-top: 10px">Keine Einträge über Dich vorhanden.</p>
                            </g:else>
                        </g:if>
                    </div>
                </div>
            </a>
        </g:each>
    </div>
</body>
</html>