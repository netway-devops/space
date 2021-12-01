<?php

class widget_oauth extends HostingWidget {
    
    protected $widgetfullname   = 'OAuth';
    protected $description      = 'Email marketing campaign authentication.';
    
    public function clientFunction (& $module)
    {
        $db                 = hbm_db();
        
        $tplVar             = array();
        
        $result             = $module->testConnection();
        
        if (! $result) {
            $this->addError('Connection fail');
            return false;
        }
        
        $aConfig            = $module->getConfig();
        
        $tplVar['username']     = $aConfig['client_username']['value'];
        $tplVar['password']     = $aConfig['client_password']['value'];

        $tplVar['connection']   = 'success';
        
        return array('oauth.tpl', $tplVar);
    }
    
}