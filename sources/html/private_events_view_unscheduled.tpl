	{if count($unscheduled) === 0}
	<p class="pform1">Aucune interruption rencontrée</p>
	{else}
	<ul class="form">
	{foreach name=i item=event from=$unscheduled}
	{if isset($event->edit)}
		<li id="selected">{include file="private_events_edit.tpl"}</li>
	{else}
		<li class="{$event->classCss}">
			<p class="pform1">Service <span class="bold">{$event->nameForUsers}</span>
				interrompu
				{if $event->endDate === NULL}
					depuis le {$event->beginDate|date_format:"%d %B %Y %H:%M"}
				{else}
					du {$event->beginDate|date_format:"%d %B %Y %H:%M"} au {$event->endDate|date_format:"%d %B %Y %H:%M"}
				{/if}
				<a href="{$smarty.const.URL}/index.php/evenements?modify={$event->idEvent}#U{$smarty.foreach.i.index}" name="U{$smarty.foreach.i.index+1}" title="modifier"><img src="{$smarty.const.URL}/images/edit.png" alt="modifier" width="16px" height="16px" /></a>
				<a href="{$smarty.const.URL}/index.php/evenements?delete={$event->idEvent}" title="supprimer"><img src="{$smarty.const.URL}/images/drop.png" alt="supprimer" width="16px" height="16px" /></a>
			</p>
			{* <!-- description --> *}
			{if !empty($event->description)}
				<p class="pform2">Raison : {$event->description|nl2br}</p>
			{/if}
		</li>
	{/if}
	{/foreach}
	</ul>
	<p>
		<a href="#menu" title="Retourner au menu de la page">
			<img src="{$smarty.const.URL}/images/page_up.gif" alt="remonter" />
		</a>
	</p>
	{/if}
