<?php

class billingcycle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        
        
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function updatevalidrecurringamount ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        $valid      = isset($request['valid']) ? $request['valid'] : 0;
        
        $db->query("
            UPDATE hb_accounts
            SET is_valid_recurring_amount = :valid
            WHERE id = :accountId
            ", array(
                ':valid'        => $valid,
                ':accountId'    => $accountId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update valid recurring amount success"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}