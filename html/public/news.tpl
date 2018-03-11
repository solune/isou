<main role="main">
<article id="content">

<h1 class="sr-only">Actualité</h1>

<p class="well">Liste des interruptions passées ou à venir dans un délai de 48h.</p>

{if count($categories) === 0}
	<p class="alert alert-info">Aucun évènement à signaler</p>
{else}
<aside id="isou-news-legend-aside">
	<h1 id="isou-news-legend-h1">Légende</h1>
	<dl id="isou-news-legend-dl">
	{foreach $STATES as $STATE}
		<div>
			<dt class="isou-news-legend-dt">{$STATE}</dt>
			<dd class="isou-news-legend-dd">{$STATE->title}</dd>
		</div>
	{/foreach}
	</dl>
</aside>

{foreach $categories as $category}
	<h2 class="isou-news-categories">{$category->name}</h2>

	<ul class="services-ul">
	{foreach $category->services as $service}
		<li class="services-li" id="service-{$service->id}">
			{$STATES[$service->state]}&nbsp;
			{if $service->url === NULL}
			<span class="state-{$service->state}">{$service->name}</span>
			{else}
			<a class="state-{$service->state}" href="{$service->url}" title="Accéder à la page du service {$service->name}">{$service->name}</a>
			{/if}

			{* <!-- affichage des interruptions --> *}
			<ul class="services-events-ul">
			{foreach $service->events as $event}
				{* <!-- affichage des messages du type "le service a été arrêté..." --> *}
				<li class="services-event-li">

					<p class="events-date-p">
					{if !empty($event->period) || $event->state === "UniversiteRennes2\Isou\State::CLOSED|constant"}
						<span class="events-maintenance-span">{$event}</span>
					{else}
						{if $event->startdate->getTimestamp() > $smarty.const.TIME}
						<span class="events-futur-span">{$event}</span>
						{elseif $event->enddate !== NULL && $event->enddate->getTimestamp() < $smarty.const.TIME}
						<span class="events-past-span">{$event}</span>
						{else}
						<span class="events-now-span">{$event}</span>
						{/if}
					{/if}
					</p>

					{if !empty($event->description)}
					{* <!-- affichage d'une description de l'interruption ; ex: mise à jour en version 2.x" --> *}
					<p class="events-description-p">{$event->description}</p>
					{/if}
				</li>
			{/foreach}
			</ul>
		</li>
	{/foreach}
	</ul>

	<p class="sr-only escape"><a class="quickaccess-page-up-a" href="#top">retourner en haut de la page</a></p>
{/foreach}
{/if}

</article>
</main>
