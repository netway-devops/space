<?php

class invoicehandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    public function restoreInvoice ($request)
    {
        $db             = hbm_db();
        
        $client         = hbm_logged_client();
        $oClient        = (object) $client;
        
        if (! isset($oClient->id) || ! $oClient->id) {
            return false;
        }
        
        $db->query("
            UPDATE hb_invoices
            SET client_id = -client_id
            WHERE 
                client_id = :clientId
                AND status = 'Unpaid'
        ", array(
            ':clientId'     => '-'. $oClient->id
        ));
        
    }
    
    public function hiddenInvoice ($request)
    {
        $db             = hbm_db();
        
        $client         = hbm_logged_client();
        $oClient        = (object) $client;
        
        if (! isset($oClient->id) || ! $oClient->id) {
            return false;
        }
        
        $invoices       = isset($request['invoices']) ? $request['invoices'] : '';
        $aInvoice       = explode(',', $invoices);
        
        if (! count($aInvoice)) {
            return false;
        }
        
        $db->query("
            UPDATE hb_invoices
            SET client_id = -client_id
            WHERE 
                id NOT IN (". implode(',', $aInvoice).")
                AND client_id = :clientId
                AND status = 'Unpaid'
        ", array(
            ':clientId'     => $oClient->id
        ));
        
        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Invoice not in '. implode(',', $aInvoice).' is keeped."]'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}