<?php

class rdns_vps extends OtherModule {
    
    protected $modname = 'rDNS for VPS';
    protected $filename = 'class.netway_common.php';
    protected $description = 'Plugin for management rDNS for VPS.';
    
    public $configuration = array(
        'Connect plugin rDNS for vps' => array(
            'value' => '1',
            'type' => 'check',
            'description' => 'Config check connect rDNS for vps.'
        )
    );
    
    
    
}