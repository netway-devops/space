<?php

class manualccprocessinghandle extends OtherModule {
    
    protected $modname      = 'Manual CC Processing handle';
    protected $description  = 'ส่วนจัดการ Manual CC Processing เสริมเนื่องจากของ hostbill ช้า';
    
    protected $info         = array(
        'payment_menu'      => true
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
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
}

