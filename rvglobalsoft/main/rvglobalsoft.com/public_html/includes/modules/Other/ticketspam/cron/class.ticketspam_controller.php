<?php

class ticketspam_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * Delete ticket ที่ถูก tag ว่าเป็น spam
     * @return string
     */
    public function call_EveryRun() {
        
        $db         = hbm_db();

        /* --- Delete ticket are tag as "spam"   --- */
        $aTicketId  = array();
        
        $result     = $db->query("
                    SELECT
                        t.id
                    FROM
                        hb_tags tg,
                        hb_tickets_tags tt,
                        hb_tickets t
                    WHERE
                        tg.tag = 'spam'
                        AND tg.id = tt.tag_id
                        AND tt.ticket_id = t.id
                    ORDER BY 
                        t.id ASC
                    LIMIT 25
                    ")->fetchAll();
        
        if (is_array($result) && count($result)) {
            
            foreach ($result as $arr) {
                $ticketId   = $arr['id'];
                if ($ticketId) {
                    // ใช้ API deleteTicket แล้วลบได้ทีละตัว จึงเลิกใช้
                    $db->query("DELETE FROM hb_tickets WHERE id = :ticketId"
                                , array(':ticketId' => $ticketId));
                    $db->query("DELETE FROM hb_ticket_replies WHERE ticket_id = :ticketId"
                                , array(':ticketId' => $ticketId));
                    $db->query("DELETE FROM hb_tickets_tags WHERE ticket_id = :ticketId"
                                , array(':ticketId' => $ticketId));
                    array_push($aTicketId, $ticketId);
                }
            }
            
        }
        
        $message        = 'Delete spam tag ticket ' . implode(',',$aTicketId) . ' success.';
        
        echo $message;
        
        return $message;
    }

    /**
     * เพิ่ม spam macro ใน My Macro ให้กับ staff ทุกคน เพื่อให้สามารถ apply macro ได้
     * @return string
     */
    public function call_Daily() {
        
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
                SELECT
                    tpc.id
                FROM
                    hb_tickets_predefinied_cats tpc
                WHERE
                    tpc.name = 'Spam'
                ", array())->fetch();
        
        $catId      = isset($result['id']) ? $result['id'] : 0;
        
        if (! $catId) {
            return $message;
        }
        
        $aAdmin     = array();
        $result     = $db->query("
                SELECT
                    aa.id
                FROM
                    hb_admin_access aa
                WHERE
                    1
                ", array())->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aAdmin, $arr['id']);
            }
        }
        
        if (! count($aAdmin)) {
            return $message;
        }
        
        $result     = $db->query("
                SELECT
                    tp.id
                FROM
                    hb_tickets_predefinied tp
                WHERE
                    tp.category_id = :catId
                    AND tp.name = 'spam'
                    AND tp.status = 'Closed'
                    AND tp.tags = 'spam'
                ", array(
                    ':catId'        => $catId
                ))->fetch();
        
        if (! isset($result['id'])) {
            $db->query("
                INSERT INTO hb_tickets_predefinied (
                    `category_id`, `name`, `reply`, `note`, `priority`, `status`, `owner`, `tags`, `share`
                ) VALUES (
                    :catId, 'spam','', '0', NULL, NULL, NULL, 'spam', NULL
                )
                ", array(
                    ':catId'        => $catId
                ));
            $result     = $db->query("SELECT MAX(tp.id) AS id FROM hb_tickets_predefinied tp", array())->fetch();
        }
        
        $preId      = isset($result['id']) ? $result['id'] : 0;
        
        if (! $preId) {
            return $message;
        }
        
        foreach ($aAdmin as $adminId) {
            $db->query("
                REPLACE INTO hb_tickets_predefinied_my (
                    admin_id,reply_id,sort_order
                ) VALUES (
                    :adminId, :preId, 20
                )
                ", array(
                    ':adminId'      => $adminId,
                    ':preId'        => $preId
                ));
        }
        
        
        
        return $message;
    }
    
}
