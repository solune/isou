			<form id="form-edit" action="{$smarty.const.URL}/index.php/evenements" method="post">
			<fieldset>
			<legend>Modifier un évènement</legend>
				<p>
					<label for="name" class="label">Service :</label>
					{html_options id=name name=name options=$optionNameForUsers selected=$currentEdit->idService}
				</p>
				<p>
					<label for="beginDateUpd" class="label">
						Date de début
						<span class="required" title="champs obligatoire">*</span>
						<a href="#formatDate3" class="help" title="lire l'aide pour le champs date de début">?</a>
					</label>
					<input type="text" name="beginDate" id="beginDateUpd" title="Format : Jour/Mois/Annee H:M" maxlength="16" value="{$currentEdit->beginDate|date_format:'%d/%m/%Y %H:%M'}" />
				</p>
				<p>
					<label for="endDateUpd" class="label">
						Date de fin
						<span class="required" title="champs obligatoire">*</span>
						<a href="#formatDate3" class="help" title="lire l'aide pour le champs date de début">?</a>
					</label>
					<input type="text" name="endDate" id="endDateUpd" title="Format : Jour Mois Annee H:M" maxlength="16" value="{$currentEdit->endDate|date_format:'%d/%m/%Y %H:%M'}" />
				</p>
				<p>
					<label for="descriptionUpd" class="label">Raison de l'interruption</label>
					<textarea id="description" name="descriptionUpd" cols="40" rows="6">{$smarty.post.descriptionUpd|default:$currentEdit->description}</textarea>
				</p>
				<p class="info-date-format">
					<a name="formatDate3"></a>
					Le format de date demandé est de type "DD/MM/YYYY hh:mm".<br />
					Exemple :<br />
					13/09/2010 14:30 pour le lundi 13 septembre 2010 à 14 heures et 30 minutes.<br /><br />
					<a class="quickaccess-form" href="#form-edit" title="revenir au formulaire">Revenir au formulaire.</a>
				</p>
				<p>
					<input class="hidden" type="hidden" name="idEvent" value="{$currentEdit->idEvent}" />
					<input class="hidden" type="hidden" name="idEventDescription" value="{$currentEdit->idEventDescription}" />
					<input class="hidden" type="hidden" name="scheduled" value="{$currentEdit->isScheduled}" />
					<input type="submit" name="modify" value="Enregistrer" />
					<input type="submit" name="cancel" value="Annuler" />
				</p>
			</fieldset>
			</form>
