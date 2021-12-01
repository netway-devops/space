<?php

class optimizationhandle extends OtherModule {
    
    protected $modname      = 'Hostbill optimization handle';
    protected $description  = 'ส่วนจัดการข้อมูลของ Hostbill ทั้ง Database และ Website ให้ำงานเร็วขึ้น';
    
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    public function restoreTicketReplyArchive ($ticketId)
    {
        $db         = hbm_db();
        
        $result     =         $db->query("
            SELECT COUNT(*) AS total FROM hb_ticket_replies_archive WHERE ticket_id = :ticketId
            ", array(
                ':ticketId' => $ticketId
            ))->fetch();
        
        if (! isset($result['total']) || ! $result['total']) {
            return false;
        }
        
        $db->query("
            INSERT IGNORE INTO hb_ticket_replies 
            SELECT * FROM hb_ticket_replies_archive WHERE ticket_id = :ticketId
            ", array(
                ':ticketId' => $ticketId
            ));
        
        $db->query("
            DELETE FROM hb_ticket_replies_archive WHERE ticket_id = :ticketId
            ", array(
                ':ticketId' => $ticketId
            ));
        
        return true;
    }
    
}

