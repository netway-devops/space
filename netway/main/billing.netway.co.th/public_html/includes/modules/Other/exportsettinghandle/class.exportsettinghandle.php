<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class exportsettinghandle extends OtherModule implements Observer {
    
    protected $modname      = 'Export hostbill setting';
    protected $description  = '
    *** NETWAY ***<br />
    - ระบบจะ export setting ไปไว้ที่ /home/managene/hostbill_settings
    ';
    protected $info         = array(
        'extras_menu'     => true
    );

    public $configuration    = array();
    
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

    public function install ()
    {
        return true;
    }
    
}

