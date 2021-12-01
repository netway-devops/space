<?php

class hostbillmonitoringhandle_controller extends HBController {
    
    public $module;
    
    public function call_Hourly ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $message    = $this->_cron_generateInvoices();
        
        return $message;
    }
    
    private function _cron_generateInvoices ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $db->query("
            UPDATE hb_cron_tasks
            SET status = 1
            WHERE task = 'generateInvoices'
            ");
        
        return $message;
    }

}
