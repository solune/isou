<?php

require __DIR__.'/config.php';
require PRIVATE_PATH.'/libs/upgrade.php';

$db_file_path = substr(DB_PATH, 7);
if (is_file($db_file_path) === false) {
    // Installation.
    try {
        initialize_phinx();
    } catch (Exception $exception) {
        echo 'Echec lors de l\'installation !'.PHP_EOL;
        echo $exception->getMessage().PHP_EOL;
        exit(1);
    }

    require PRIVATE_PATH.'/php/common/database.php';

    // Installe les plugins.
    echo PHP_EOL;
    upgrade_plugins();

    echo PHP_EOL;
    echo 'Installation terminée.'.PHP_EOL;
    exit(0);
}

require PRIVATE_PATH.'/php/common/database.php';

// Charge la configuration.
require PRIVATE_PATH.'/libs/configuration.php';
$CFG = get_configurations();

if (isset($CFG['version']) === false) {
    $CFG['version'] = '';
}

if (has_new_version() === false && upgrade_plugins($check_only = true) === false) {
    echo 'Aucune mise à jour à effectuer.'.PHP_EOL;
    exit(0);
}

// Avertissement avant la mise à jour.
echo 'Vous vous apprêtez à faire une mise à jour d\'Isou.'.PHP_EOL.PHP_EOL;
echo '   - Avant de lancer la procédure, il est fortement recommandé de faire une sauvegarde du fichier "'.$db_file_path.'"'.PHP_EOL.PHP_EOL;
echo 'Souhaitez-vous lancer la mise à jour ? (o/n)'.PHP_EOL;
$response = trim(fgets(STDIN));
if (in_array($response, array('o', 'y', 'O', 'Y'), true) === false) {
    exit(0);
}

echo PHP_EOL;

try {
    switch ($CFG['version']) {
        case '':
        case '0.9.0':
            upgrade_090_to_095();
            // Pas de break. On enchaine sur l'upgrade de la version 0.9.0 à 0.9.5.
        case '0.9.5':
            upgrade_095_to_096();
            // Pas de break. On enchaine sur l'upgrade de la version 0.9.5 à 0.9.6.
        case '0.9.6':
            upgrade_096_to_0100();
            // Pas de break. On enchaine sur l'upgrade de la version 0.9.6 à 0.10.0.
        case '0.10.0':
        case '2012-02-16.1':
            upgrade_0100_to_0110();
            // Pas de break. On enchaine sur l'upgrade de la version 0.10.0 à 0.11.0.
        case '0.11.0':
        case '2012-03-16.1':
            upgrade_0110_to_100();
            // Pas de break. On enchaine sur l'upgrade de la version 0.11.0 à 1.0.0.
        case '1.0.0':
        case '2013-00-00.1':
            upgrade_100_to_200();
            // Pas de break. On enchaine sur l'upgrade de la version 1.0.0 à 2.0.0.
        default:
            // Finally, upgrade plugins.
            echo PHP_EOL;
            upgrade_plugins();
    }
} catch (Exception $exception) {
    echo 'Echec lors de la mise à jour !'.PHP_EOL;
    echo $exception->getMessage().PHP_EOL;
    exit(1);
}

// Mets à jour la date de dernière mise à jour et le numéro de version d'isou.
$update = array();
$update['last_update'] = strftime('%FT%T');
$update['version'] = CURRENT_VERSION;

foreach ($update as $key => $value) {
    $sql = "UPDATE configuration SET value = :value WHERE key = :key";
    $query = $DB->prepare($sql);
    $query->execute(array(':value' => $value, ':key' => $key));
}

echo PHP_EOL;
echo 'Mise à jour terminée.'.PHP_EOL;
