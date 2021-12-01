<?php

class widget_campaign extends HostingWidget {
    
    protected $widgetfullname   = 'Campaign';
    protected $description      = 'Email marketing campaign list.';
    
    public function clientFunction (& $module)
    {
        $db                 = hbm_db();
        
        $tplVar             = array();
        
        $result             = $module->testConnection();
        
        if (! $result) {
            $this->addError('Connection fail');
            return false;
        }
        
        try {
            $result         = $module->apiMailchimp->campaigns->getList(array('status'=>'sent'));
        } catch (Mailchimp_Error $e) {
            $this->addError($e->getMessage());
        }
        
        $tplVar['aLists']   = (isset($result['total']) && $result['total']) ? $result['data'] : array();
        
        
        return array('campaign.tpl', $tplVar);
    }
    
}