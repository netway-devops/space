<?php

class zendeskintegratehandle extends OtherModule {
    
    protected $modname      = 'Zendesk Integrate handle';
    protected $description  = 'ส่วนการสร้างข้อมูลเชื่อมโยงระหว่าง hostbill และ zendesk';
    
    protected $info         = array();
    
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
