<?php
/**
 * This file is part of isou project.
 *
 * @author  Université Rennes 2 - DSI <dsi-contact@univ-rennes2.fr>
 * @license The Unlicense <http://unlicense.org>
 */

declare(strict_types=1);

namespace UniversiteRennes2\Isou;

/**
 * Classe décrivant un état de service.
 */
class State {
    const OK = '0';
    const GREEN = '0';

    const WARNING = '1';
    const ORANGE = '1';

    const CRITICAL = '2';
    const RED = '2';

    const UNKNOWN = '3';
    const BLUE = '3';

    const CLOSED = '4';
    const WHITE = '4';

    /**
     * Identifiant de l'objet.
     *
     * @var integer
     */
    public $id;

    /**
     * Nom de l'objet.
     *
     * @var string
     */
    public $name;

    /**
     * Titre de l'objet.
     *
     * @var string
     */
    public $title;

    /**
     * Texte alternatif.
     *
     * @var string
     */
    public $alternate_text;

    /**
     * Nom de l'image représentant un état.
     *
     * @var string
     */
    public $image;

    /**
     * Liste des états de services.
     *
     * @var string[]
     */
    public static $STATES = array(
        self::OK => 'Fonctionne',
        self::WARNING => 'Instable',
        self::CRITICAL => 'Indisponible',
        self::UNKNOWN => 'Indéterminé',
        self::CLOSED => 'Fermé',
    );

    /**
     * Constructeur de la classe.
     *
     * @return void
     */
    public function __construct() {
        if (isset($this->id) === false) {
            // Instance manuelle.
            $this->id = '0';
            $this->name = '';
            $this->title = '';
            $this->alternate_text = '';
            $this->image = '';
        }
    }

    /**
     * Représentation textuelle de la classe.
     *
     * @return string
     */
    public function __tostring() {
        return $this->get_flag_html_renderer();
    }

    /**
     * Retourne le code HTML permettant d'afficher l'image de l'état.
     *
     * @return string
     */
    public function get_flag_html_renderer() {
        global $CFG;

        return '<img src="'.URL.'/themes/'.$CFG['theme'].'/images/'.$this->image.'" alt="'.$this->alternate_text.'" width="16px" height="16px" />';
    }

    /**
     * Récupère un objet en base de données en fonction des options passées en paramètre.
     *
     * @param array $options Tableau d'options.
     *
     * @throws \Exception Lève une exception lorsqu'une option n'est pas valide.
     *
     * @return State|false
     */
    public static function get_record(array $options = array()) {
        if (isset($options['id']) === false) {
            throw new \Exception(__METHOD__.': le paramètre $options[\'id\'] est requis.');
        }

        $options['fetch_one'] = true;

        return self::get_records($options);
    }

    /**
     * Récupère un tableau d'objets en base de données en fonction des options passées en paramètre.
     *
     * Liste des options disponibles :
     *   id => int
     *
     * @param array $options Tableau d'options.
     *
     * @throws \Exception Lève une exception lorsqu'une option n'est pas valide.
     *
     * @return State[]|State|false
     */
    public static function get_records(array $options = array()) {
        global $DB;

        $conditions = array();
        $parameters = array();

        // Parcourt les options.
        if (isset($options['id']) === true) {
            if (ctype_digit($options['id']) === true) {
                $conditions[] = 's.id = :id';
                $parameters[':id'] = $options['id'];
            } else {
                throw new \Exception(__METHOD__.': l\'option \'id\' doit être un entier. Valeur donnée : '.var_export($options['id'], $return = true));
            }

            unset($options['id']);
        }

        // Construit le WHERE.
        if (isset($conditions[0]) === true) {
            $sql_conditions = ' WHERE '.implode(' AND ', $conditions);
        } else {
            $sql_conditions = '';
        }

        // Vérifie si toutes les options ont été utilisées.
        foreach ($options as $key => $option) {
            if (in_array($key, array('fetch_column', 'fetch_one'), $strict = true) === true) {
                continue;
            }

            throw new \Exception(__METHOD__.': l\'option \''.$key.'\' n\'a pas été utilisée. Valeur donnée : '.var_export($option, $return = true));
        }

        // Construit la requête.
        $sql = 'SELECT s.id, s.name, s.title, s.alternate_text, s.image'.
           ' FROM states s'.
            $sql_conditions;
        $query = $DB->prepare($sql);
        $query->execute($parameters);

        $query->setFetchMode(\PDO::FETCH_CLASS, 'UniversiteRennes2\Isou\State');

        if (isset($options['fetch_one']) === true) {
            return $query->fetch();
        }

        return $query->fetchAll();
    }
}
