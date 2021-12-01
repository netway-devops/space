<?php
// Depending on HostBill application.
if (!defined('HBF_APPNAME')) {
    exit;
}

class customadminuihandle extends OtherModule implements Observer
{

    protected $modname      = 'Custom Admin UI';
    protected $description  = '***NETWAY*** ใช้ load js/customAdminUi.js ที่ header ของ admin';

    protected $info         = array();

    public $configuration    = array();

    public function before_displayadminheader($details)
    {
        $script_location    = BILLING_URL . '/7944web/templates/default/js/customAdminUi.css';
        echo '<link rel="stylesheet" href="' . $script_location . '" media="all">';

        $script_location_purify    = BILLING_URL . '/vendor/netway/js/node_modules/dompurify/dist/purify.min.js';
        echo '<script type="text/javascript" src="' . $script_location_purify . '"></script>';

        $script_location_axios    = BILLING_URL . '/vendor/netway/js/node_modules//axios/dist/axios.min.js';
        echo '<script src="' . $script_location_axios . '"></script>';


        $script_location    = BILLING_URL . '/7944web/templates/default/js/customAdminUi.js';
        echo '<script type="text/javascript" src="' . $script_location . '"></script>';
    }

    private static  $instance;

    public static function singleton()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function __clone()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
}
