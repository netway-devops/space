<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class internalcontrolhandle extends OtherModule {
    
    protected $modname      = 'Internal Control Handle';
    protected $description  = 'ระบบตรวจสอบการทำงานของ hostbill ให้มีประสิทธิภาพลูงสุด';
    
    protected $info         = array(
        'extras_menu'       => true
    );
    
    public $configuration    = array(
        'ZENDESK_BRAND_ID'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'ZENDESK_FORM_ID'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'ZENDESK_API_URL'       => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'ZENDESK_API_USER'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'ZENDESK_API_TOKEN'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'FROM_DOMAIN'   => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DEV_EMAIL'   => array(
            'value'     => '',
            'type'      => 'textarea',
            'description'   => 'ไม่ต้องสร้าง ticket กรณีที่เกิด error จาก dev คั่นด้วย , กรณีมีหลายอีเมล์'
        ),
        'ZENDESK_ERROR_VIEW_ID'   => array(
            'value'     => '',
            'type'      => 'input'
        ),
    );
    
    //react on event: before_displayuserfooter
    public function before_displayadminheader($details) {
        //$script_location    = '../includes/modules/Other/servicecataloghandle/templates/js/script.js';
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
