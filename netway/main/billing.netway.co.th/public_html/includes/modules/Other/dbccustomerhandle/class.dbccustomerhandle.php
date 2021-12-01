<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class dbccustomerhandle extends OtherModule {
    
    protected $modname      = 'DBC Customer Handle';
    protected $description  = '***NETWAY*** Sync ข้อมูล customer จาก DBC มาที่ Hostbill 
    <ul>
    <li> ดู company id จาก dbc <a href="?cmd=dbcproducthandle&action=listCompany" target="_blank">here</a> </li>
    </ul>
    ';
    
    protected $info         = array(
        'extras_menu'       => true
    );
    
    public $configuration    = array(
        'DBC_API_URL'       => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DBC_API_USER'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DBC_API_PASSWORD'  => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DBC_COMPANY_ID'  => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DBC_WEB_URL'  => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DBC_WEB_SERVICE_URL'       => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DBC_COMPANY_NAME'       => array(
            'value'     => '',
            'type'      => 'input',
            'description'      => 'เช่น NETWAY-LIVE-TEST-PRAEW'
        ),
    );
    
    //react on event: before_displayuserfooter
    public function before_displayadminheader($details) {
        $script_location    = '../includes/modules/Other/dbccustomerhandle/templates/js/script.js';
        //this will be rendered in adminarea head tag:
        //echo '<script type="text/javascript" src="'.$script_location.'"></script>';
    }
    
    
    private static  $instance;
     
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    
}
