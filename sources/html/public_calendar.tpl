<div id="content">
<a name="content"></a>

<table id="calendar-table" border="1" summary="Calendrier répertoriant toutes les intervertions">
	<caption>
	{if isset($previousWeekLink)}
		<a title="Semaine précédente" href="{$smarty.const.URL}/index.php/calendrier{$previousWeekLink}">
			<img src="{$smarty.const.URL}/images/action_back.gif" alt="précédent" width="16px" height="16px" /></a>
	{/if}
		<a href="#" name="calendrier"></a>&nbsp;Calendrier des interventions &nbsp;
		<a href="{$smarty.const.URL}/index.php/calendrier{$nextWeekLink}" title="Semaine suivante">
			<img src="{$smarty.const.URL}/images/action_forward.gif" alt="suivant" width="16px" height="16px" /></a>
	</caption>
	<thead>
	<tr id="weekday">
		<th>Lundi</th>
		<th>Mardi</th>
		<th>Mercredi</th>
		<th>Jeudi</th>
		<th>Vendredi</th>
		<th>Samedi</th>
		<th>Dimanche</th>
	</tr>
	</thead>
	<tbody>
	{section name=i loop=$calendar}
	<tr class="mday">
		{section name=j loop=$calendar[i]}
			<td {if isset($calendar[i][j]->cssClass)}class="{$calendar[i][j]->cssClass}"{/if}>
				<span id="date-{$calendar[i][j]->dateId}">{$calendar[i][j]->date}</span>
				{if isset($calendar[i][j]->events)}
				<ul class="event">
					{section name=k loop=$calendar[i][j]->events}
					{if isset($calendar[i][j]->events->flag)}
					<li>
						{$calendar[i][j]->events->flag}<a href="#{$calendar[i][j]->events[k]->stripName}">{$calendar[i][j]->events[k]->name}</a>
					</li>
					{else}
					<li class="alert-event">
						<a href="#{$calendar[i][j]->events[k]->stripName}">{$calendar[i][j]->events[k]->name}</a>
					</li>
					{/if}
					{/section}
				</ul>
				{else}
					{if isset($calendar[i][j]->cssClass) && $calendar[i][j]->cssClass === 'today'}
						<p id="no-event">Aucune intervention prévue</p>
					{/if}
				{/if}
			</td>
		{/section}
	</tr>
	{/section}
	</tbody>
</table>

{include file="public_news.tpl"}

</div>

