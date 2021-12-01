<?php

class geninvoicehandle_controller extends HBController {
    
    public $module;
    
    public function call_Daily()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        $message    .= $this->_updateNextInvoiceDateAnnualy();
        
        return $message;
    }
    
    private function _updateNextInvoiceDateAnnualy ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            UPDATE hb_accounts
            SET next_invoice = DATE_SUB(next_due, INTERVAL 30 DAY)
            WHERE billingcycle IN ('Annually', 'Biennially', 'Triennially')
                AND status = 'Active'
                AND ( DATEDIFF(next_due, next_invoice) BETWEEN 0 AND 10 )
            LIMIT 30
            ");
        
        return $message;
    }
    
}
