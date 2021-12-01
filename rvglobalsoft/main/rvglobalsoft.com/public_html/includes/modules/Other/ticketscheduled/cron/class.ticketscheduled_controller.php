<?php

class ticketscheduled_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * Re-open ticket ที่มี status = Scheduled เมื่อถึงกำหนด
     * @return string
     */
    public function call_Daily() {
        
        $db         = hbm_db();
        
        $currentDate    = date('Y-m-d');

        /* --- Re-open sheduled ticket   --- */
        $result         = $db->query("
                    UPDATE 
                        hb_tickets
                    SET 
                        status = 'Open'
                    WHERE 
                        status = 'Scheduled'
                        AND scheduled_date <= :currentDate
                    ", array(
                        ':currentDate'  => $currentDate
                    ));
        
        $message        = 'Re open scheduled ticket on '. $currentDate .' success.';
        
        return $message;
    }
    
}
