<?php

class authorizationhandle extends OtherModule implements Observer {
    
    protected $modname      = 'Authorization Document';
    protected $description  = '***NETWAY*** เอกสารอนุญาติให้ดำเนินการกับบริการใดๆ';

    //react on event: before_displayuserfooter
    public function before_displayadminheader($details) {
        $script_location    = '../includes/modules/Other/authorizationhandle/templates/js/script.js';
        //this will be rendered in adminarea head tag:
        echo '<script type="text/javascript" src="'.$script_location.'"></script>';
    }


    
}
