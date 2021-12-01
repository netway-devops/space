<?php

class optimizationhandle_controller extends HBController {
    
    public $module;
    
    public function call_Daily ()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        self::_moveTicketReplyToArchive();
        
        return $message;
    }
    
    /**
     * ย้าย ticket reply เก่าไปไว้ที่ archive
     */
    private function _moveTicketReplyToArchive ()
    {
        $db         = hbm_db();
        
        $db->query("
            INSERT IGNORE INTO hb_ticket_replies_archive 
            SELECT * FROM hb_ticket_replies WHERE date <= DATE(CURRENT_DATE - INTERVAL 3 MONTH)
            ");

        $db->query("DELETE FROM hb_ticket_replies WHERE date < DATE(CURRENT_DATE - INTERVAL 3 MONTH)");
        
    }
    
}



