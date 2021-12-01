<?php

class simplefraud extends HostBill_FroudProtection {
    
    protected $modname      = 'Simple Fraud';
    protected $description  = 'ระบบป้องกัน fraud';
    protected $version      = '1.0';
    
    // Configuration
    protected $configuration = array(
        'autofraudbyip'    => array(
            'value'     => '1',
            'type'      => 'check',
            'description'   => 'Fraud check'
            )
        );
    
    protected $lang         = array(
                'english'   => array(
                    'autofraudbyip' => 'Enable fraud check'
                )
            );
    
    
    public function isFroudFromIP ($ip)
    {
        return true;
    }
    
}

