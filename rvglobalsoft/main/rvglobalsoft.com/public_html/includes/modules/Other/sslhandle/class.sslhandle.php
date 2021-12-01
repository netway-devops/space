<?php

class sslhandle extends OtherModule {
    
    protected $modname      = 'SSL Handle';
    protected $description  = 'ส่วนจัดการเพิ่มเติมเกี่ยวกับ SSL';

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
    
    
}
