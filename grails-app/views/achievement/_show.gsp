<p>Zuletzt erhalten:</p>
<g:each in="${players}" var="player">
    <img style="display: inline-block;" data-toggle="tooltip" data-placement="top"
         title="${player.name}<br />erhalten: <g:prettyTime date="${player.achieved_at}" />"
         src="http://cravatar.eu/avatar/${player.uuid}/32.png" width="32" height="32" data-html="true" />
</g:each>
<g:if test="${players.isEmpty()}">
    <p class="text-muted">Niemandem.</p>
</g:if>