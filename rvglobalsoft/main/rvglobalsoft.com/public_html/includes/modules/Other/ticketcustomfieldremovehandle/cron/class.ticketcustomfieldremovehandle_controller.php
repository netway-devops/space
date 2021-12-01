<?php

class ticketcustomfieldremovehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * สามารถตั้ง cron ไปลบ custom field ใน ticket  ที่ close แล้ว
     * @return string
     */
    public function call_Daily() 
    {
        $db     = hbm_db();
        
        $db->query("
            DELETE FROM
                hb_ticket_customfields
            WHERE
                ticket_id IN
                (
                    SELECT
                        t.id
                    FROM
                        hb_tickets t
                    WHERE
                        t.status = 'Closed'
                )
            ");
        $message    = '';
        return $message;
    }
    
}


