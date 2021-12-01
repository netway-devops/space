<?php

class ticketcustomfieldremovehandle extends OtherModule {
    
    protected $modname      = 'Ticket customfield removeable';
    protected $description  = 'สามารถตั้ง cron ไปลบ custom field ใน ticket  ที่ close แล้ว';

    public $configuration    = array(
        'Note'     => array(
            'value'     => '',
            'type'      => 'textarea'
        )
    );
    
    
    
}
