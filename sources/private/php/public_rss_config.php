<?php

$title = NAME.' - Configuration Flux RSS';
$script = '<script type="text/javascript" src="'.URL.'/js/jquery-min.js"></script>
			<script type="text/javascript" src="'.URL.'/js/jquery_rss_config.js"></script>';
$css = '<link rel="stylesheet" type="text/css" href="'.URL.'/css/rss_config.css" media="screen" />';

$sql = "SELECT C.idCategory, C.name, S.nameForUsers, S.rssKey".
		" FROM categories C, services S".
		" WHERE C.idCategory = S.idCategory".
		" AND S.rssKey IS NOT NULL".
		" ORDER BY C.position, S.nameForUsers";

$services = $db->query($sql);
$serviceItems = array();
$categoryItems = array();
$key = 0;

while($service = $services->fetch()){
	if(count($categoryItems) == 0 || $categoryItems[count($categoryItems)-1][0] != $service[0]){ // add category
		$categoryItems[count($categoryItems)] = array($service[0], $service[1]);
	}
	$serviceItems[count($serviceItems)] = array($service[0], $service[2], $service[3]);
	if(isset($_POST['key_'.$service[3]])){
		$key += pow(2, $service[3]);
	}
}

if(isset($_POST['generer'])){
	($key == 0)?$urlKey = URL.'/rss.php':$urlKey = URL.'/rss.php?key='.strtoupper(dechex($key));
	$urlKey = 'Vous pouvez consulter les actualités des services sélectionnés précédemment en utilisant ce lien RSS : '.
		'<a href="'.$urlKey.'" title="lien vers le flux RSS">'.$urlKey.'</a>';
}else{
	$urlKey = '';
}

$smarty->assign('categoryItems', $categoryItems);
$smarty->assign('serviceItems', $serviceItems);
$smarty->assign('URL', URL);
$smarty->assign('urlKey', $urlKey);

?>