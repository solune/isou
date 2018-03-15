<?php

if (isset($PAGE_NAME[3]) === true && ctype_digit($PAGE_NAME[3]) === true) {
    $service = get_service(array('id' => $PAGE_NAME[3], 'plugin' => PLUGIN_ISOU));
}else{
    $service = false;
}

if ($service === false) {
    $_SESSION['messages'] = array('errors' => 'Ce service n\'existe pas.');

    header('Location: '.URL.'/index.php/services/isou');
    exit(0);
}

$sql = "SELECT DISTINCT s.id, s.name, s.state".
    " FROM services s".
    " JOIN dependencies_groups_content dgc ON s.id = dgc.idservice".
    " JOIN dependencies_groups dg ON dg.id = dgc.idgroup".
    " WHERE dg.idservice = ?";
$query = $DB->prepare($sql);
$query->execute(array($service->id));
$service->dependencies = $query->fetchAll(PDO::FETCH_OBJ);

$smarty->assign('service', $service);

$SUBTEMPLATE = 'inspect.tpl';
