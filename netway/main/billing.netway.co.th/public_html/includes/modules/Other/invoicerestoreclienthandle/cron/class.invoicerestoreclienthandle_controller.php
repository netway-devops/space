
<?php

class invoicerestoreclienthandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * 
     * @return string
     */
    public function _cancel_call_Hourly()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        $db->query("
            UPDATE
                hb_invoices
            SET 
                client_id = - client_id
            WHERE 
                client_id < 0
            ");
        
        return $message;
    }
    
}


