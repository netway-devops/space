<?php

class ticketeventnotificationhandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * แจ้งเตือนเจ้าหน้าที่เมื่อมีความเคลื่อนใหวในระบบ support
     * @return string
     */
    public function call_Hourly() 
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT
                mc.config
            FROM
                hb_modules_configuration mc
            WHERE
                mc.module = 'ticketeventnotificationhandle'
            ")->fetch();
        
        $aConfig    = isset($result['config']) ? unserialize($result['config']) : array();
        $emailTo    = isset($aConfig['Email To']['value']) ? $aConfig['Email To']['value'] : '';
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $nwTicketIDNotificationFrom         = ConfigCustom::singleton()->getValue('nwTicketIDNotificationFrom');
        $nwTicketReplyIDNotificationFrom    = ConfigCustom::singleton()->getValue('nwTicketReplyIDNotificationFrom');
        $nwTicketNoteIDNotificationFrom     = ConfigCustom::singleton()->getValue('nwTicketNoteIDNotificationFrom');
        
        $aTicketId  = array();
        $aTicket    = array();
        
        $result     = $db->query("
                SELECT
                    tn.*
                FROM
                    hb_tickets_notes tn
                WHERE
                    tn.id > :noteId
                ORDER BY
                    tn.id ASC
                LIMIT 100
                ", array(
                    ':noteId'       => $nwTicketNoteIDNotificationFrom
                ))->fetchAll();
        
        if (count($result)) {
            $noteId             = $nwTicketNoteIDNotificationFrom;
            foreach ($result as $arr) {
                $ticketId       = $arr['ticket_id'];
                $noteId         = $arr['id'];
                if (! in_array($arr['ticket_id'], $aTicketId)) {
                    array_push($aTicketId, $arr['ticket_id']);
                }
                if (! isset($aTicket[$ticketId])) {
                    $aTicket[$ticketId]     = array('note' => array());
                }
                $aTicket[$ticketId]['note'][$noteId]  = $arr;
            }
            ConfigCustom::singleton()->setValue('nwTicketNoteIDNotificationFrom', $noteId);
        }
        
        $result     = $db->query("
                SELECT
                    tr.*
                FROM
                    hb_ticket_replies tr
                WHERE
                    tr.id > :replyId
                ORDER BY
                    tr.id ASC
                LIMIT 100
                ", array(
                    ':replyId'      => $nwTicketReplyIDNotificationFrom
                ))->fetchAll();
        
        if (count($result)) {
            $replyId            = $nwTicketReplyIDNotificationFrom;
            foreach ($result as $arr) {
                $ticketId       = $arr['ticket_id'];
                $replyId        = $arr['id'];
                if (! in_array($arr['ticket_id'], $aTicketId)) {
                    array_push($aTicketId, $arr['ticket_id']);
                }
                if (! isset($aTicket[$ticketId])) {
                    $aTicket[$ticketId]     = array('reply' => array());
                }
                $aTicket[$ticketId]['reply'][$replyId]  = $arr;
            }
            ConfigCustom::singleton()->setValue('nwTicketReplyIDNotificationFrom', $replyId);
        }
        
        $result     = $db->query("
                SELECT
                    t.*
                FROM
                    hb_tickets t
                WHERE
                    t.id > :ticketId
                    ". (count($aTicketId) ? " OR t.id IN (". implode(',', $aTicketId) .") " : "") ."
                ORDER BY 
                    t.id ASC
                LIMIT 100
                ", array(
                    ':ticketId'     => $nwTicketIDNotificationFrom
                ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $ticketId       = $arr['id'];
                $arr['reply']   = isset($aTicket[$ticketId]['reply']) ? $aTicket[$ticketId]['reply'] : array();
                $arr['note']    = isset($aTicket[$ticketId]['note']) ? $aTicket[$ticketId]['note'] : array();
                $aTicket[$ticketId] = $arr;
                if ($nwTicketIDNotificationFrom < $ticketId) {
                    $nwTicketIDNotificationFrom = $ticketId;
                }
            }
            ConfigCustom::singleton()->setValue('nwTicketIDNotificationFrom', $nwTicketIDNotificationFrom);
        }
        
        if (! count($aTicket)) {
            return $message;
        }
        
        $subject    = 'มีความเคลื่อนใหวใหม่ '. count($aTicket) .' รายการในระบบ support@rvglobalsoft '. date('Y-m-d H:i');
        $html       = '
            <!DOCTYPE html>
            <html>
                <head>
                <meta charset="utf-8">
                </head>
                <body>
                ';
        foreach ($aTicket as $ticketId => $arr) {
            if (! isset($arr['id'])) {
                continue;
            }
            $html       .= '
                <div style="display:block; margin-top:60px;">
                    <h1><a 
                        href="https://rvglobalsoft.com/7944web/?cmd=tickets&action=view&num='.$arr['ticket_number'].'"
                        >'.$arr['subject'].'</a>
                        <small style="float:right; color:gray; font-size:small;">'.$arr['date'].'</small>
                    </h1>
                    <blockquote>
                    <p>'.$arr['body'].'</p>
                    <footer style="float:right; color:gray; font-weight:strong;
                        ">'.$arr['name'].' ('.$arr['email'].')</footer>
                    </blockquote>
                ';
            if (isset($arr['note']) && count($arr['note'])) {
                $html       .= '
                    <ul style="list-style:none;">
                    ';
                foreach ($arr['note'] as $k => $v) {
                    $html       .= '
                        <li style="border: 1px dotted gray;">
                            <blockquote class="blockquote-reverse">
                                <dl class="dl-horizontal">
                                    <dt>Type:</dt>
                                    <dd>Staff comment</dd>
                                </dl>
                                <dl class="dl-horizontal">
                                    <dt>Message:</dt>
                                    <dd>'.$v['note'].'</dd>
                                </dl>
                                <footer style="float:right; color:gray; font-weight:strong;
                                    ">'.$v['name'].' ('.$v['email'].') '.$v['date'].'</footer>
                            </blockquote>
                        </li>
                        ';
                }
                $html       .= '
                    </ul>
                    ';
            }
            if (isset($arr['reply']) && count($arr['reply'])) {
                $html       .= '
                    <ul style="list-style:none;">
                    ';
                foreach ($arr['reply'] as $k => $v) {
                    $html       .= '
                        <li style="border: 1px dotted gray;">
                            <blockquote class="blockquote-reverse">
                                <dl class="dl-horizontal">
                                    <dt>Type:</dt>
                                    <dd>'.$v['type'].' reply</dd>
                                </dl>
                                <dl class="dl-horizontal">
                                    <dt>Message:</dt>
                                    <dd>'.$v['body'].'</dd>
                                </dl>
                                <footer style="float:right; color:gray; font-weight:strong;
                                    ">'.$v['name'].' ('.$v['email'].') '.$v['date'].'</footer>
                            </blockquote>
                        </li>
                        ';
                }
                $html       .= '
                    </ul>
                    ';
            }
            $html       .= '
                </div>
                ';
        }
        $html       .= '
                </body>
            </html>
            ';
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/html; charset=utf-8' . "\r\n" .
                'From: admin@netway.co.th' . "\r\n" .
                'Reply-To: admin@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        @mail($emailTo, $subject, $html, $header);
        
        return $message;
    }
    
}


