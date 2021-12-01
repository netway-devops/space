<?php

class netway_reseller extends OtherModule implements Observer {
    
    protected $version      = '1.2';
    
    protected $modname      = 'Netway Reseller Program';
    protected $description  = '***NETWAY*** ระบบ Reseller สำหรับบริการของ Netway';
    
    public $configuration   = array(
        'Message'       => array(
            'value'     => '',
            'type'      => 'textarea',
            'description'   => 'ข้อความที่จะแจ้งให้ Reseller ทราบว่า module นี้มีการ update อะไรบ้างเพิ่มเติมจาก version ก่อนหน้า'
        ),
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
    
    //react on event: before_displayuserfooter
    public function before_displayadminheader($details)
    {
        //$script     = '../includes/modules/Other/netway_reseller/templates/js/script.js';
        //this will be rendered in adminarea head tag:
        //echo '<script type="text/javascript" src="'. $script .'"></script>';
    }
    
}
