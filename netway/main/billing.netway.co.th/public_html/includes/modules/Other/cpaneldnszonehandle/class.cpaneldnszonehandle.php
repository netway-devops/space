<?php

class cpaneldnszonehandle extends OtherModule {
    
    protected $modname      = 'cPanel DNS Zone จัดการเพิ่มเติม';
    protected $description  = '***NETWAY*** สามารถ delate zone ก่อน create account etc.';
    
    protected $info         = array(
        'extras_menu'       => true
        );
    
    public $configuration    = array(
        'DNS Server1 IP'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DNS Server1 WHM Username'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DNS Server1 WHM Hash'     => array(
            'value'     => '',
            'type'      => 'textarea'
        ),
        'DNS Server2 IP'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DNS Server2 WHM Username'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DNS Server2 WHM Hash'     => array(
            'value'     => '',
            'type'      => 'textarea'
        ),
        'DNS Server3 IP'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'IP Park'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DNS Server3 WHM Username'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DNS Server3 WHM Hash'     => array(
            'value'     => '',
            'type'      => 'textarea'
        ),
    );
    
    
    
}
