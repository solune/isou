<?php

	/* * * * * * * * * * * *
	 * Affichage des interruptions prévues
	 * * * * * * * * * * * */
	$sql = "SELECT E.idEvent, E.beginDate, E.endDate, EI.period, EI.idEventDescription, D.description, EI.isScheduled, S.idService, S.name, S.nameForUsers, S.state, S.readonly".
			" FROM events E, events_isou EI, services S, events_description D".
			" WHERE S.idService = EI.idService".
			" AND EI.idEventDescription = D.idEventDescription".
			" AND EI.idEvent = E.idEvent".
			" AND E.typeEvent = 0".
			" AND (E.beginDate BETWEEN :0 AND :1".
			" OR E.endDate BETWEEN :2 AND :3".
			" OR E.endDate IS NULL)".
			" AND S.name = 'Service final'".
			" AND S.enable = 1".
			" AND EI.isScheduled = 1".
			" ORDER BY E.beginDate DESC";

	$events = $db->prepare($sql);
	$events->execute(array(TIMESTAMP_OF_72H_BEFORE_TODAY, TIMESTAMP_OF_LAST_CALENDAR_DAY, TIMESTAMP_OF_72H_BEFORE_TODAY, TIMESTAMP_OF_LAST_CALENDAR_DAY));
	$scheduled = array();

	while($event = $events->fetchObject()){

		if((isset($_GET['modify']) && $_GET['modify'] == $event->idEvent) ||
			(isset($_POST['idEvent']) && $_POST['idEvent'] == $event->idEvent)){
			$event->edit = TRUE;
			$currentEdit = $event;
		}

		$scheduled[] = $event;
	}

?>

