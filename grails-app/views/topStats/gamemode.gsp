<%--
  Created by IntelliJ IDEA.
  User: ml
  Date: 23.01.16
  Time: 23:38
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:set var="breadcrumb" value="${[
            [url: createLink(controller: 'home'), name: 'Home'],
            [url: createLink(controller: 'topStats'), name: 'Statistiken'],
            gamemode
    ]}" scope="request" />
    <title>${gamemode} Top 10 - Exfy.de User CP</title>
    <meta name="layout" content="main">
</head>

<body>
<div class="list-group" id="collapse-panel">
    <g:each in="${stats}" var="item">
        <%
            def htmlName = item.stat.replace('.', '_')
        %>
        <a href="#stat-${htmlName}" class="list-group-item collapsed achievement-parent"
           data-toggle="#stat-${htmlName}" data-stat-id="${item.stat}">
            <div class="media">
                <div class="media-body">
                    <h4 class="media-heading">
                        ${item.localization}
                    </h4>
                    <g:if test="${session.loggedIn}">
                        <g:if test="${item.score != null}">
                            Dein Wert: <g:formatStatistic score="${item.score}" type="${item.type}" /><br />
                            Dein Rang: ${item.rank + 1}
                        </g:if>
                        <g:else>
                            Kein Wert vorhanden.
                        </g:else>
                    </g:if>
                </div>
            </div>
        </a>
        <div id="stat-${htmlName}" class="collapse list-group-submenu">
            <p class="list-group-item">
                Lädt...
            </p>
        </div>
    </g:each>
</div>
<script>
    $('.achievement-parent').click(function() {
        var dis = $(this);
        var id = dis.data('stat-id');
        var targetPar = $("#stat-" + id.replace('.', '_'));
        var target = targetPar.find(".list-group-item");
        if (targetPar.hasClass("in")) {
            // hide
            targetPar.collapse('hide');
            dis.addClass('collapsed');
            return;
        }

        $.get('${createLink(action: 'show')}/${gamemode}/' + encodeURIComponent(id), function(data) {
            target.html(data);
            target.find('[data-toggle="tooltip"]').tooltip();
            targetPar.collapse('show');
            dis.removeClass('collapsed');
        });
    });
</script>
</body>
</html>