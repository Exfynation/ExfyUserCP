<%--
  Created by IntelliJ IDEA.
  User: ml
  Date: 14.01.16
  Time: 21:25
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:set var="breadcrumb" value="${[
            [url: createLink(controller: 'home'), name: 'Home'],
            [url: createLink(action: 'index'), name: 'Errungenschaften'],
            category
    ]}" scope="request" />
    <meta name="layout" content="main">
    <title>${category} - Exfy.de User CP</title>
</head>

<body>
    <div >
        <div class="list-group" id="collapse-panel">
            <g:each in="${achievements}" var="item">
                <a href="#achievement-${item.id}" class="list-group-item collapsed achievement-parent"
                   data-toggle="#achievement-${item.id}" data-achievement-id="${item.id}">
                    <div class="media">
                        <div class="media-left">
                            <img class="media-object" src="${assetPath(src: "achievements/${item.category}/${item.id}.png")}" width="64" height="64" />
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">
                                ${item.title}
                                <g:if test="${item.achieved}">
                                    <span class="label label-success pull-right" style="margin-left: 5px;">Erhalten</span>
                                </g:if>
                                <g:if test="${item.hidden}">
                                    <span class="label label-warning pull-right">Geheim</span>
                                </g:if>
                            </h4>
                            ${item.description}
                        </div>
                    </div>
                </a>
                <div id="achievement-${item.id}" class="collapse list-group-submenu">
                    <p class="list-group-item">
                        Lädt...
                    </p>
                </div>
            </g:each>
        </div>
    </div>

<script>
    $('.achievement-parent').click(function() {
        var dis = $(this);
        var id = dis.data('achievement-id');
        var targetPar = $("#achievement-" + id);
        var target = targetPar.find(".list-group-item");
        if (targetPar.hasClass("in")) {
            // hide
            targetPar.collapse('hide');
            dis.addClass('collapsed');
            return;
        }

        $.get('${createLink(action: 'show')}/' + id, function(data) {
            target.html(data);
            target.find('[data-toggle="tooltip"]').tooltip();
            targetPar.collapse('show');
            dis.removeClass('collapsed');
        });
    });
</script>
</body>
</html>