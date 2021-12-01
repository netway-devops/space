<?php

/**
 * Administrator has just posted reply to a ticket
 * $details = array('id'=>REPLY ID,
 * 'ticket_id'=>RELATED TICKET ID,
 * ticket_number'=>RELATED TICKET NUMBER,
 * 'replier_id'=>REPLIER ID (IF ANY),
 * 'name'=>REPLIER NAME,
 * 'email'=>REPLIER EMAIL,
 * 'body'=>REPLY MESSAGE BODY,
 * 'type'=>REPLIER TYPE (Admin or Client),
 * 'date'=>REPLY DATE)
 * Following variable is available to use in this file:  $details
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

/*
 * 3.1.1-Average service request response time  (SAL team)  **
 * บันทีกเวลาตั้งแต่ ticket เปิด ถึง reply ครั้งแรก ไม่สนใจว่า ticket assign ถึงตัวเองหรือเปล่า
*/

$ticketId       = $details['ticket_id'];
$replyId        = $details['id'];
$replyDate      = $details['date'];
$staffId        = $details['replier_id'];

$result         = $db->query("
        SELECT trt.*
        FROM mtx_ticket_response_time trt
        WHERE trt.ticket_id = :ticketId
        ", array(
            ':ticketId'     => $ticketId
        ))->fetch();

if (! isset($result['id']) && $staffId) {
    
    $result         = $db->query("
            SELECT t.*
            FROM hb_tickets t
            WHERE t.id = :ticketId
                AND t.client_id != 0
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
    
    $ticketDate     = isset($result['date']) ? $result['date'] : 0;
    
    $result         = $db->query("
            SELECT t2r.*
            FROM sc_ticket_2_request t2r
            WHERE t2r.ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ))->fetch();
    
    $ticketType     = isset($result['request_type']) ? $result['request_type'] : '';
    
    $result         = $db->query("
            SELECT tm.*
            FROM sc_team_member tm
            WHERE tm.staff_id = :staffId
            ", array(
                ':staffId'     => $staffId
            ))->fetch();
    
    $teamId         = isset($result['team_id']) ? $result['team_id'] : 0;
    
    if ($ticketDate && $ticketType) {
        $responseTime   = strtotime($replyDate) - strtotime($ticketDate);
        $requestType    = ($ticketType == 'Service Request') ? 1 : 2; // 1 = Service Request, 2 = Incident
        
        // ถ้า $responseTime เกิน 24 ชั่วโมงให้ตัดเป็น 24 ชั่วโมง
        if ($responseTime > (24*60*60)) {
            $responseTime   = (24*60*60);
        }
        
        $db->query("
            INSERT INTO `mtx_ticket_response_time` (
            `ticket_id`, `ticket_date`, `reply_id`, `reply_date`, `staff_id`, `team_id`, `time_in_second`, `request_type`
            ) VALUES (
            :ticketId, :ticketDate, :replyId, :replyDate, :staffId, :teamId, :responseTime, :requestType
            )
            ", array(
                ':ticketId'     => $ticketId,
                ':ticketDate'   => $ticketDate,
                ':replyId'      => $replyId,
                ':replyDate'    => $replyDate,
                ':staffId'      => $staffId,
                ':teamId'       => $teamId,
                ':responseTime' => $responseTime,
                ':requestType'  => $requestType,
            ));
        
    }

}


