<main role="main">
<article id="content">

<table id="list" class="table table-condensed" summary="Journal des perturbations et interruptions de services Rennes 2">
	<caption class="text-center">Journal des services monitorés</caption>
	<thead>
		<tr class="header">
			<th id="lth2">État</th>
			<th id="lth1">Service</th>
			<th id="lth4">Début</th>
			<th id="lth5">Fin</th>
			<th id="lth3">Raison</th>
		</tr>
	</thead>
	{foreach $days as $day}
	<tbody>
		<tr class="header">
			<th colspan="5" class="thdate active">{$day->date|date_format:"%A %e %B"}</th>
		</tr>
		{if !isset($day->events[0])}
		<tr><td colspan="5" class="info">Aucun évènement</td></tr>
		{else}
		{foreach $day->events as $event}
			<tr>
				<td>{$STATES[$event->state]}</td>
				<td>{$event->service}</td>
				<td>{$event->begindate|date_format:"%a %e %b %Hh%M"}</td>
				{if $event->enddate === null}
				<td>en cours</td>
				{else}
				<td>{$event->enddate|date_format:"%a %e %b %Hh%M"}</td>
				{/if}
				<td>{$event->description|nl2br}</td>
			</tr>
		{/foreach}
		{/if}
	</tbody>
	{/foreach}
</table>

</article>
</main>
