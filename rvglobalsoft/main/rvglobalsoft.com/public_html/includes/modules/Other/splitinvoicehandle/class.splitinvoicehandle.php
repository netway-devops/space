<?php

class splitinvoicehandle extends OtherModule {
    
    protected $modname      = 'Split Invoice Handle';
    protected $description  = 'แยก invoice ให้ลูกค้าที่ตั้ง config split invoice ไว้';

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
