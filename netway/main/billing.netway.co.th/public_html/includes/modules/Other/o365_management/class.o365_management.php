<?php
include_once(APPDIR . "libs/azureapi/AzureApi.php");
class o365_management extends OtherModule {
    protected $modname      = 'Microsoft 365 Management';
    protected $description  = 'บริหาร, จัดการ Product Microsoft 365 Product';

    protected $info         = array(
        'extras_menu'      => true
    );

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function before_displayadminheader($details)
    {
        //$script     = '../includes/modules/Other/netway_reseller/templates/js/script.js';
        //this will be rendered in adminarea head tag:
        //echo '<script type="text/javascript" src="'. $script .'"></script>';
    }
}