<?php

class supportcataloghandle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
        
    }
    
    public function noticChangeManagement ($request)
    {
        $db             = hbm_db();
        $aClient        = hbm_logged_client();
        
        $result         = $db->query("
                SELECT
                    cr.*, a.domain, a2.domain AS server
                FROM
                    hb_accounts a,
                    ch_request cr,
                    hb_accounts a2,
                    hb_tickets t
                WHERE
                    a.client_id = :clientId
                    AND a.id = cr.account_id
                    AND cr.account_id = a2.id
                    AND cr.ticket_id = t.id
                    AND t.status != 'Closed'
                
                UNION
                
                SELECT
                    cr.*, a.domain, a2.domain AS server
                FROM
                    hb_accounts a,
                    ch_account_relate car,
                    ch_request cr,
                    hb_accounts a2,
                    hb_tickets t
                WHERE
                    a.client_id = :clientId
                    AND a.id = car.account_id
                    AND car.change_request_id = cr.id
                    AND cr.account_id = a2.id
                    AND cr.ticket_id = t.id
                    AND t.status != 'Closed'
                ", array(
                    ':clientId'     => $aClient['id']
                ))->fetchAll();
        
        $this->template->assign('aNotic', $result);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.notic_change_management.tpl',array(), false);
    }
	
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}