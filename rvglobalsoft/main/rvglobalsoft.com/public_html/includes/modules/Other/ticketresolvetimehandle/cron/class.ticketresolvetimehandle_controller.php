<?php

class ticketresolvetimehandle_controller extends HBController {
    
    public $module;
    
    public function call_EveryRun() {
        
        $db         = hbm_db();
        $message    = '';
        
        self::_logTicketResolveTime();
        
        return $message;
    }
    
    /**
    *   3.2.1-Average service request resolve time  (SAL team) **
    *   เวลาตั้งแต่ ticket เปิด ถึง ที่ตัวเองตอบหรือ comment สุดท้าย โดย ticket นั้นจะต้อง close แล้ว / ทุกคนที่เกี่ยวข้องในการตอบหรือ comment
    *   จะมีหลาย record / ticket
    *   ตาม monitor hb_tickets_log ดูว่ามี ticket ใหน close แล้วบ้าง
    */
    private function _logTicketResolveTime ()
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        $nwTicketLogForMatrixSLA    = ConfigCustom::singleton()->getValue('nwTicketLogForMatrixSLA');
        
        $result     = $db->query("
                SELECT tl.*
                FROM hb_tickets_log tl
                WHERE tl.id > :logId
                    AND tl.action LIKE 'Ticket status changed % to \"Closed\" %'
                ORDER BY tl.id ASC LIMIT 10
                ", array(
                    ':logId'    => $nwTicketLogForMatrixSLA
                ))->fetchAll();
        
        if (! count($result)) {
            $result     = $db->query("SELECT MAX(id) AS idx FROM hb_tickets_log ")->fetch();
            $idx        = isset($result['idx']) ? $result['idx'] : 0;
            if ($idx < $nwTicketLogForMatrixSLA) {
                ConfigCustom::singleton()->setValue('nwTicketLogForMatrixSLA', 0);
            }
            return true;
        }
        
        $result_    = $result;
        
        foreach ($result_ as $arr) {
            $nwTicketLogForMatrixSLA    = $arr['id'];
            $ticketId   = $arr['ticket_id'];
            
            $result     = $db->query("
                    SELECT trt.*
                    FROM mtx_ticket_resolve_time trt
                    WHERE trt.ticket_id = :ticketId
                    ", array(
                        ':ticketId'     => $ticketId
                    ))->fetch();
            
            if (isset($result['id'])) {
                continue;
            }
            
            $result         = $db->query("
                    SELECT t.*
                    FROM hb_tickets t
                    WHERE t.id = :ticketId
                        AND t.client_id != 0
                    ", array(
                        ':ticketId'     => $ticketId
                    ))->fetch();
            
            $ticketDate     = isset($result['date']) ? $result['date'] : 0;
            
            if (! $ticketDate) {
                continue;
            }
            
            $aStaff     = array();
            
            $result     = $db->query("
                    SELECT tr.*
                    FROM hb_ticket_replies tr
                    WHERE tr.ticket_id = :ticketId
                        AND tr.type = 'Admin'
                        AND tr.status = 'Sent'
                    GROUP BY tr.replier_id
                    ORDER BY tr.date DESC
                    ", array(
                        ':ticketId'     => $ticketId
                    ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr) {
                    $staffId    = $arr['replier_id'];
                    
                    if (! isset($aStaff[$staffId])) {
                        $aStaff[$staffId]   = array();
                    }
                    
                    $aStaff[$staffId]['date']     = $arr['date'];
                    $aStaff[$staffId]['type']     = 1; // Reply
                    $aStaff[$staffId]['id']       = $arr['id'];
                }
            }
            
            $result     = $db->query("
                    SELECT tn.*
                    FROM hb_tickets_notes tn
                    WHERE tn.ticket_id = :ticketId
                    GROUP BY tn.admin_id
                    ORDER BY tn.date DESC
                    ", array(
                        ':ticketId'     => $ticketId
                    ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr) {
                    $staffId    = $arr['admin_id'];
                    
                    if (! isset($aStaff[$staffId])) {
                        $aStaff[$staffId]   = array();
                    }
                    
                    if (isset($aStaff[$staffId]['date'])) {
                        if (strtotime($aStaff[$staffId]['date']) < strtotime($arr['date'])) {
                            $aStaff[$staffId]['date']   = $arr['date'];
                            $aStaff[$staffId]['type']   = 2; // Note
                            $aStaff[$staffId]['id']     = $arr['id'];
                        }
                    } else {
                        $aStaff[$staffId]['date']   = $arr['date'];
                        $aStaff[$staffId]['type']   = 2; // Note
                        $aStaff[$staffId]['id']     = $arr['id'];
                    }
                }
            }
            
            $result         = $db->query("
                    SELECT t2r.*
                    FROM sc_ticket_2_request t2r
                    WHERE t2r.ticket_id = :ticketId
                    ", array(
                        ':ticketId'     => $ticketId
                    ))->fetch();
            
            $ticketType     = isset($result['request_type']) ? $result['request_type'] : '';
            $requestType    = ($ticketType == 'Service Request') ? 1 : 2; // 1 = Service Request, 2 = Incident
            
            if (count($aStaff) && $ticketType) {
                foreach ($aStaff as $staffId => $arr) {
                    $replyId    = $arr['id'];
                    $replyType  = $arr['type'];
                    $replyDate  = $arr['date'];
                    
                    $responseTime   = strtotime($arr['date']) - strtotime($ticketDate);
                    
                    // ถ้า $responseTime เกิน 96 ชั่วโมงให้ตัดเป็น 96 ชั่วโมง
                    if ($responseTime > (96*60*60)) {
                        $responseTime   = (96*60*60);
                    }
                    
                    $result         = $db->query("
                            SELECT tm.*
                            FROM sc_team_member tm
                            WHERE tm.staff_id = :staffId
                            ", array(
                                ':staffId'     => $staffId
                            ))->fetch();
                    
                    $teamId         = isset($result['team_id']) ? $result['team_id'] : 0;
                    
                    $db->query("
                        INSERT INTO `mtx_ticket_resolve_time` (
                        `ticket_id`, `ticket_date`, `rel_id`, `rel_type`, `rel_date`, 
                        `staff_id`, `team_id`, `time_in_second`, `request_type`
                        ) VALUES (
                        :ticketId, :ticketDate, :replyId, :replyType, :replyDate, 
                        :staffId, :teamId, :responseTime, :requestType
                        )
                        ", array(
                            ':ticketId'     => $ticketId,
                            ':ticketDate'   => $ticketDate,
                            ':replyId'      => $replyId,
                            ':replyType'    => $replyType,
                            ':replyDate'    => $replyDate,
                            ':staffId'      => $staffId,
                            ':teamId'       => $teamId,
                            ':responseTime' => $responseTime,
                            ':requestType'  => $requestType,
                        ));
                    
                }
            }
            
            
        }
        
        ConfigCustom::singleton()->setValue('nwTicketLogForMatrixSLA', $nwTicketLogForMatrixSLA);
        
        
    }
    
}
