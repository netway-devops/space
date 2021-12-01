<?php

class paypalhandle extends OtherModule {
    
    protected $modname      = 'Paypal Handle';
    protected $description  = 'จัดการข้อมูลเพิ่มเติมในการเชื่อมต่อกับ paypal';

    protected $info         = array(
        'extras_menu'       => true
    );
    
    public $configuration    = array(
        'PAYPAL_API_URL'        => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'PAYPAL_ACCOUNT'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'PAYPAL_CLIENT_ID'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'PAYPAL_CLIENT_SECRET'  => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'PAYPAL_ACCOUNT_2'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'PAYPAL_CLIENT_ID_2'      => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'PAYPAL_CLIENT_SECRET_2'  => array(
            'value'     => '',
            'type'      => 'input'
        ),
    );
    
}
