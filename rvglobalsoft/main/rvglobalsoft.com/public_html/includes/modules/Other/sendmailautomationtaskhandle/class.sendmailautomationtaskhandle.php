<?php

class sendmailautomationtaskhandle extends OtherModule {
    
    protected $modname      = 'Sendmail Automation Task';
    protected $description  = 'Custom automation tasks: แก้ไข bug hostbill ไม่ทำการเพิ่ม task เข้าระบบ';

    public $configuration    = array(
        'Note'     => array(
            'value'     => '',
            'type'      => 'textarea'
        )
    );
    
    
    
}
