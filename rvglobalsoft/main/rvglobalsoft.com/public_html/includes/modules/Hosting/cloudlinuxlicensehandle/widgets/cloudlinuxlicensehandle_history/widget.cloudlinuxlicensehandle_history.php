<?php

class widget_cloudlinuxlicensehandle_history extends HostingWidget {

    protected $widgetfullname   = 'License history';
    protected $description      = 'List history of license';
    
    public function clientFunction (&$module) {
        
        $aVariable          = array();
        
        return array('history.tpl', $aVariable);
    }
    
}