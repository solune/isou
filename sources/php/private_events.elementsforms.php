<?php

	/* * * * * * * * * *
	 *  Génération du select form "forced"
	 * * * * * * * */
	$optionForced = array();
	foreach($flags as $flag){
		$optionForced[$flag->idState] = $flag->title;
	}
	$optionForced[-1] = 'État par défaut';
	$smarty->assign('optionForced', $optionForced);

	/* * * * * * * * * *
	 *  Génération du select form "scheduled"
	 * * * * * * * */
	$optionScheduled = array('Opération non prévue (maintenance, panne, ...)', 'Opération prévue (maintenance, mise à jour, ...)','Opération régulière (arrêt quotidien, hebdomadaire, ...)','Fermeture de service');
	$smarty->assign('optionScheduled', $optionScheduled);

	/* * * * * * * * * *
	 *  Génération du select form "period"
	 * * * * * * * */
	$period = array('daily' => 'Tous les jours', 'weekly' => 'Toutes les semaines');
	$smarty->assign('period', $period);

	/* * * * * * * * * *
	 * Génération du select form "services"
	 * * * * * * * * * * */
	$sql = "SELECT S.idService, S.nameForUsers".
			" FROM services AS S".
			" WHERE S.name = 'Service final'".
			" AND S.enable = 1".
			" ORDER BY UPPER(S.nameForUsers)";
	$services = $db->query($sql);
	$optionNameForUsers = array();
	while($service = $services->fetch(PDO::FETCH_NUM)){
		$optionNameForUsers[$service[0]] = $service[1];
	}

	$smarty->assign('optionNameForUsers', $optionNameForUsers);

?>
