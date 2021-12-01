<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class eventhookhandle_model {

    private static  $instance;
    private $db;
     
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
    
    private function __construct () 
    {
        $this->db       = hbm_db();
        
    }
    

    
    
}
