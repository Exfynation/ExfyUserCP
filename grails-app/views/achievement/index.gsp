<%--
  Created by IntelliJ IDEA.
  User: ml
  Date: 10.01.16
  Time: 18:25
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:set var="breadcrumb" value="${[
            [url: createLink(controller: 'home'), name: 'Home'],
            'Errungenschaften'
    ]}" scope="request" />
    <meta name="layout" content="main">
    <title>Errungenschaften - Exfy.de User CP</title>
</head>

<body>
    <div class="list-group">
        <g:each in="${achievements}" var="entry">
            <a href="${createLink(action: 'category', id: entry.key)}" class="list-group-item">
                <div class="media">
                    <div class="media-body">
                        <g:each in="${entry.value.values.reverse()}" var="item">
                            <img style="display: inline; float: right;" data-toggle="tooltip" data-placement="top" title="${item.title}"
                                 src='${assetPath(src: "achievements/${entry.key}/${item.id}.png")}' width="64" height="64" />
                        </g:each>
                        <h4 class="media-heading">
                            ${entry.key}&nbsp;
                            <g:if test="${entry.value.info.hidden}">
                                <span class="label label-warning">Geheim</span>
                            </g:if>
                        </h4>
                        <g:if test="${session.loggedIn}">
                            <%
                                def val = ((entry.value.info.achieved / (float) entry.value.info.count) * 100).round()
                            %>
                            <p style="display: inline-block; margin-top: 10px">Erhalten: ${entry.value.info.achieved} von ${entry.value.info.count}&nbsp;</p>
                            <div class="progress" style="width: 250px; margin-top: 10px; margin-bottom: 0; height: 10px; display: inline-block;">
                                <div class="progress-bar" role="progressbar"
                                     style="width: ${val}%">
                                </div>
                            </div>
                            <p style="display: inline">&nbsp;${val}%</p>
                        </g:if>
                        <g:else>
                            Insgesamt ${entry.value.info.count}
                        </g:else>
                    </div>
                </div>
            </a>
        </g:each>
    </div>
</body>
</html>