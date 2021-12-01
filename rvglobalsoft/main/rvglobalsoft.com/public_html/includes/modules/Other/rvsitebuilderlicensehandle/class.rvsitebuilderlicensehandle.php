<?php

class rvsitebuilderlicensehandle extends OtherModule {
    
    protected $modname      = 'RVSitebuilder license handle';
    protected $description  = 'จัดการ action เพิ่มเติมเกี่ยวกับ RVSitebuilder License';

    public $configuration    = array(
        'Note'     => array(
            'value'     => '',
            'type'      => 'textarea'
        )
    );
    
    
    
}
