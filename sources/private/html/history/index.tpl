<main role="main">
<article id="content">

<h1 class="sr-only">Historique</h1>

<form action="{$smarty.const.URL}/index.php/historique#resultat" method="post">

	<fieldset class="form-fieldset">
		<legend class="form-legend">Services</legend>
		{html_checkboxes name="services" options=$options_services selected=$smarty.post.services|default:array()}
	</fieldset>

	<dl>
		<div class="form-information-dl-div">
			<dt class="form-topics-dt">
				<label for="event-type">Type d'interruptions</label>
			</dt>
			<dd class="form-values-dd">
				{html_options id="event-type" name="event_type" options=$options_event_types selected=$smarty.post.event_type|default:-1}
			</dd>
		</div>
		<div class="form-information-dl-div">
			<dt class="form-topics-dt">
				<label for="year">Année</label>
			</dt>
			<dd class="form-values-dd">
				{html_options id=year name="year" options=$options_years selected=$smarty.post.year|default:date('Y')}
			</dd>
		</div>
		<div class="form-information-dl-div">
			<dt class="form-topics-dt">
				<label for="month">Mois</label>
			</dt>
			<dd class="form-values-dd">
				{html_options id=month name=month options=$options_months selected=$smarty.post.month|default:-1}
			</dd>
		</div>
		<div class="form-information-dl-div">
			<dt class="form-topics-dt">
				<label for="sort">Trier par date</label>
			</dt>
			<dd class="form-values-dd">
				{html_options id=sort name=sort options=$options_sorts selected=$smarty.post.sort|default:1}
			</dd>
		</div>
		<div class="form-information-dl-div">
			<dt class="form-topics-dt">
				<label for="paging">Nombre de résultat par page</label>
			</dt>
			<dd class="form-values-dd">
				{html_options id=paging name=paging options=$options_paging selected=$smarty.post.paging|default:20}
			</dd>
		</div>
	</dl>

	<ul class="list-inline form-submit-buttons-ul">
		<li>
			<input class="btn btn-primary" type="submit" value="afficher" />
		</li>
		<li>
			<input class="btn btn-warning" type="submit" name="export" value="exporter au format csv" />
		</li>
	</ul>

</form>

{if isset($events)}
	{if !isset($events[0])}
	<p id="resultat" class="alert alert-info">Aucun résultat</p>
	{else}

	<table class="table table-bordered" id="resultat" summary="Historique des interruptions">
	<caption class="text-center">Historique des interruptions : {$count_events} {if $count_events > 1}évènements trouvés{else}évènement trouvé{/if}.</caption>
	<thead>
		<tr>
		<th>Service</th>
			<th>Date de début</th>
			<th>Date de fin</th>
			<th>Durée</th>
			<th>Durée (en minutes)</th>
			<th>Description</th>
			<th>Type d'interruption</th>
		</tr>
	</thead>
	<tbody>
		{foreach $events as $event}
		<tr>
			<td>{$event->name}</td>
			<td>{$event->begindate|date_format:'%A %e %B %Y %H:%M'}</td>
			<td>{$event->enddate|date_format:'%A %e %B %Y %H:%M'}</td>
			<td>{$event->total}</td>
			<td>{$event->total_minutes}</td>
			<td width="40%">{$event->description|default:''}</td>
			<td>
				{* TODO: update smarty and remove this hook *}
				{if $event->type === {"UniversiteRennes2\Isou\Event::TYPE_SCHEDULED"|constant}}
					Prévues
				{else}
					Non prévues
				{/if}
			</td>
		</tr>
		{/foreach}
	</tbody>
	</table>

	{if isset($pagination[1])}
	<nav>
	<ul class="pagination">
		{foreach $pagination as $page}
			<li{if $page->selected === TRUE} class="active"{/if}><a href="{$page->url}" title="{$page->title}">{$page->label}</a></li>
		{/foreach}
	</ul>
	</nav>
	{/if}

	{/if}
{/if}

</article>
</main>