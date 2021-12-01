<?php

class ipboardsso extends OtherModule {
    
    protected $modname      = 'IPBoard Single sing on';
    protected $description  = 'ระบบ singlie sign on ระหว่าง hostbill และ ipboard';

    public $configuration    = array(
        'IPBoard Url'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DB Hostname'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DB Name'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DB User'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'DB Password'     => array(
            'value'     => '',
            'type'      => 'input'
        )
    );
    
    
    
}
