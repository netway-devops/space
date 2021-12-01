<?php

class authorizationhandle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        $api    = new ApiWrapper();
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/customtab.tpl',array(), true);
    }
    
    public function customtab ($request)
    {
        $db         = hbm_db();
        
        $clientId   = $request['client_id'];
        $accountId   = $request['accountId'];
        
        
        
        //$this->template->assign('aLists', $result);
        //$this->template->assign('clientId', $clientId);
        
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/customtab.tpl',array(), true);
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }

}