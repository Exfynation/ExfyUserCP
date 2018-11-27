<p>Top 10:</p>
<g:each in="${top}" var="entry">
    <img style="display: inline;" data-toggle="tooltip" data-placement="top"
         title="Platz ${entry.rank + 1}<br />
         ${entry.name}<br />
         ${info.localization}: <g:formatStatistic score="${entry.score}" type="${info.type}" />"
         src="http://cravatar.eu/avatar/${entry.uuid}/32.png" width="32" height="32" data-html="true" />
</g:each>
<g:if test="${top.isEmpty()}">
    <p class="text-muted">Momentan keine Einträge - Eventuell werden die Top 10 gerade neu berechnet.</p>
</g:if>