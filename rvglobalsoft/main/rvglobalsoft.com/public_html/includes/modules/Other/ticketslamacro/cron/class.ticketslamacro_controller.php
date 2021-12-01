<?php
/*********************************************************************
public $aTest =   array(
         'OFH KPI Controller E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'OFH KPI Controller E-mail'
        ),
        //=== sendToCSMgr ===
        'sendToCSMgr E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToCSMgr E-mail'
        ),
        //=== sendToCSMgr : Monday
        'sendToCSMgr|1|1' => array(
            'value' => 1,
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToCSMgr|1|2' => array(
            'value' => 1,
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToCSMgr|1|3' => array(
            'value' => 1,
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Monday 18:00-24:00'
        ));
 ********************************************************************/
class ticketslamacro_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;

    /**
     * Send Mail To Mgr slamacro
     * Link : https://netway.co.th/7944web/?cmd=tickets&list=Open&showall=true&assigned=true#697135
     */
    private function sendMailToMgr($aParam)
    {
        $frmMail = 'admin@rvglobalsoft.com';
        //https://netway.co.th/7944web/?cmd=tickets&action=view&list=&num=454628
        $url    = 'https://netway.co.th/7944web/?cmd=tickets&action=view&list=all&num=';//(isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $_SERVER['SCRIPT_NAME'];
        $subject    = 'mail จาก cron ticketslamacro ticket ID::' . $aParam['ticketid'];
        $message    = "\n" . 'รายละเอียด'
        . "\n" . '============================================================'
        . "\n" . 'อีเมล์:              ' . $aParam['mailmgr']
        . "\n" . 'ข้อความจาก ticket : '
        . "\n"
        . "\n" . '============================================================'
        . "\n" . 'Reference: ' . $url  . $aParam['ticketid']
        ;
        $mailto = $aParam['mailmgr'];
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: ' . $frmMail . "\r\n" .
                'Reply-To: ' . $frmMail . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        if (@mail($mailto, $subject, $message, $header)) {
            return true;
        } else {
            return false;
        }
    }
    /**
     * 1. where tg_tag in (sendToCSMgr,sendToSYSMgr,sendToNOCMgr,sendToGITMgr,sendToTRAMgr,sendToOFHMgr)
     * 2. if วันนี้ http://php.net/manual/en/function.getdate.php
     * 2.1 วันปัจจุบัน (จ=1,อ=2,พ=3, พฤ=4, ศ=5, ส=6, อา=0)
     * 2.2 เวลาปัจจุบัน [
            00:00 - 07:00 = 1,
            07:00 - 18:00 = 2,
            18:00 - 24:00 = 3,
        ]
     */
    public function call_EveryRun() 
    {
        $message = '';
        $db         = hbm_db();
        $aConfigs       = $this->module->configuration;
        $mailController = $aConfigs['OFH KPI Controller E-mail']['value'];
        if ($mailController == '') return true;
        $aTicketId  = array();
        $result     = $db->query("
                    SELECT
                        t.id,t.ticket_number,tg.tag,tt.tag_id,t.status,t.escalated,t.dept_id
                    FROM
                        hb_tags tg,
                        hb_tickets_tags tt,
                        hb_tickets t
                    WHERE
                        tg.tag LIKE '%sendTo%'
                        AND tg.id = tt.tag_id
                        AND tt.ticket_id = t.id
                    ORDER BY 
                        t.id ASC
                    LIMIT 25
                    ")->fetchAll();
        if (is_array($result) && count($result)) {
            $aListDate= getdate();
            $getTime = '';
            if ($aListDate['hours'] >= 0 &&  $aListDate['hours'] < 7) {
                $getTime = '1';
            } elseif($aListDate['hours'] >= 7 &&  $aListDate['hours'] < 18) {
                $getTime = '2';
            } elseif($aListDate['hours'] >= 18 &&  $aListDate['hours'] < 24) {
                $getTime = '3';
            }
           // $aListDate['wday'] = '1';
            //$getTime = '1';
            $arrValue = array( '1' => array('unrespone' => 0,'responeover' => 0),
                               '2' => array('unrespone' => 0,'responeover' => 0),
                               '3' => array('unrespone' => 0,'responeover' => 0),
                               '4' => array('unrespone' => 0,'responeover' => 0),
                               '5' => array('unrespone' => 0,'responeover' => 0),
                               '6' => array('unrespone' => 0,'responeover' => 0),
                               '7' => array('unrespone' => 0,'responeover' => 0),
                               '8' => array('unrespone' => 0,'responeover' => 0),
                               '9' => array('unrespone' => 0,'responeover' => 0),
                               '10' => array('unrespone' => 0,'responeover' => 0)
                             );
                               
            $tId = '';                    
            foreach ($result as $arr) {
                $tag = $arr['tag'];
                $ticketId = $arr['id'];
                $ticket_number = $arr['ticket_number'];
                
                $tagId = $arr['tag_id'];
                $tagsta = $arr['status'];
                if ($tagsta == 'Scheduled') {
                    $db->query("DELETE FROM hb_tickets_tags WHERE tag_id = :tagId and ticket_id=:ticketId "
                                    , array(':tagId' => $tagId,':ticketId' => $ticketId));
                    if($arr['escalated'] == 1){
                        $arrValue[(string)$arr['dept_id']]['unrespone'] += 1;
                    }
                    else if($arr['escalated'] == 2){
                        $arrValue[(string)$arr['dept_id']]['responeover'] += 1;
                    } 
                    $tId = $tId.$ticketId.",";
                } else {
                    $aGetConfig = $tag . '|' . $aListDate['wday'] . '|' .$getTime;
                    if (isset($aConfigs[$aGetConfig]['value']) && $aConfigs[$aGetConfig]['value']== '1') {
    
                        $mailFrmConfig = $aConfigs[$tag . ' E-mail']['value'];
                        $resmail = $this->sendMailToMgr(array('ticketid' =>  $ticket_number, 'mailmgr' => $mailFrmConfig));
                        if ($resmail) {
                            $resmailControll = $this->sendMailToMgr(array('ticketid' =>  $ticket_number, 'mailmgr' => $mailController));
                            $resSendMail = 'ok';
                             $db->query("DELETE FROM hb_tickets_tags WHERE tag_id = :tagId and ticket_id=:ticketId "
                                    , array(':tagId' => $tagId,':ticketId' => $ticketId));
                            if($arr['escalated'] == 1){
                                $arrValue[(string)$arr['dept_id']]['unrespone'] += 1;
                            }
                            else if($arr['escalated'] == 2){
                                $arrValue[(string)$arr['dept_id']]['responeover'] += 1;
                            } 
                            $tId = $tId.$ticketId.",";
                        } else {
                            $resSendMail = 'error';
                        }
                        $txt = $ticketId . ':' . $resSendMail;
                        array_push($aTicketId, $txt);
                    }   
                }

                
            }
         
            $dateT = date('Y-m-d h:i:s');
            foreach ($arrValue as $key => $value) {
                if($value['unrespone'] != 0 || $value['responeover'] != 0){
                    $db->query("INSERT INTO 
                                       `hb_kpi_ticket`( 
                                                       `date`, 
                                                       `unresponsed_timeover`, 
                                                       `responsed_timeover`, 
                                                       `dept_id`,
                                                       `ticket_id`
                                                       ) 
                                VALUES (:date,
                                        :unresponsed,
                                        :responsed,
                                        :dept_id,
                                        :ticket_id
                                        )
                               ", array(':date' => $dateT,
                                        ':unresponsed' => $value['unrespone'],
                                        ':responsed' => $value['responeover'],
                                        ':dept_id' => intval($key),
                                        ':ticket_id' => $tId));
                                    
                }
            }
            $message        = 'sendmail Mgr tag ticket ' . implode(',', $aTicketId) ;
        } 
        echo '===>'.$message;
        return $message;
    }
    
}
