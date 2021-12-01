<?php

class sendmailautomationtaskhandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * พี่กวงเปลี่ยนไม่บ่อย
     * @return string
     */
    public function call_Hourly() 
    {
        $db             = hbm_db();
        $message        = '';
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $nwSendmailAutomationTask       = ConfigCustom::singleton()->getValue('nwSendmailAutomationTask');
        
        $result         = $db->query("
                SELECT
                    a.id, a.product_id, a.next_due
                FROM
                    hb_accounts a,
                    hb_task_list tl
                WHERE
                    a.product_id = tl.rel_id
                    AND a.status IN ('Active', 'Suspended')
                    AND a.id > :accountId
                    AND tl.rel_type = 'Hosting'
                    AND tl.task = 'sendEmail'
                ORDER BY
                    a.id ASC
                LIMIT 300
                ", array(
                    ':accountId'    => $nwSendmailAutomationTask
                ))->fetchAll();
        
        if (! count($result)) {
            ConfigCustom::singleton()->setValue('nwSendmailAutomationTask', 0);
            return $message;
        }
        
        foreach ($result as $aData) {
            $accountId          = $aData['id'];
            $productId          = $aData['product_id'];
            $nextDue            = strtotime($aData['next_due']);
            self::_scheduleAll($accountId, $productId, $nextDue);
        }
        
        
        $result_            = $result;
        
        foreach ($result_ as $aData) {
            $accountId          = $aData['id'];
            $nwSendmailAutomationTask   = $accountId;
        }
        
        // --- ถ้า Account ถูก terminate ให้ Cancel task send mail ทิ้ง ---
        
        $result         = $db->query("
                SELECT
                    tx.id
                FROM
                    hb_accounts a,
                    hb_task_list tl,
                    hb_task_log tx
                WHERE
                    a.product_id = tl.rel_id
                    AND tl.id = tx.task_id
                    AND a.status = 'Terminated'
                    AND a.id > :accountId
                    AND tl.rel_type = 'Hosting'
                    AND tl.task = 'sendEmail'
                    AND tl.when = 'before'
                    AND tx.rel_type = 'Hosting'
                    AND tx.rel_id = a.id
                ORDER BY
                    a.id ASC
                LIMIT 300
                ", array(
                    ':accountId'    => $nwSendmailAutomationTask
                ))->fetchAll();
        
        if (count($result)) {
            $aTask          = array();
            
            foreach ($result as $arr) {
                array_push($aTask, $arr['id']);
            }
            
            $db->query("
                    UPDATE
                        hb_task_log
                    SET
                        status = 'Canceled'
                    WHERE
                        id IN (". implode(',', $aTask) .")
                    ");
            
        }
        
        ConfigCustom::singleton()->setValue('nwSendmailAutomationTask', $nwSendmailAutomationTask);
        
        return $message;
    }
    
    private function _scheduleAll ($accountId, $productId, $nextDue) {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT
                    tl.*
                FROM
                    hb_task_list tl
                WHERE
                    tl.rel_id = :productId
                    AND tl.rel_type = 'Hosting'
                    AND tl.task = 'sendEmail'
                ORDER BY
                    tl.id ASC
                ", array(
                    ':productId'        => $productId
                ))->fetchAll();
        
        $result_            = $result;
        
        foreach ($result_ as $aData) {
            
            $when               = $aData['when'];
            $event              = $aData['event'];
            $interval           = abs($aData['interval']); // ใน db ตั้งให้ติดลบเพื่อไท่มห้เข้าเงื่อนไข hostbill จึงต้องเปลี่ยนเป็น int
            $intervalType       = $aData['interval_type'];
            $taskId             = $aData['id'];
            
            $aAutomation        = array();
            
            $result             = $db->query("
                    SELECT
                        ase.*
                    FROM
                        hb_automation_settings ase
                    WHERE
                        ase.item_id = :productId
                        AND ase.type = 'Hosting'
                    ", array(
                        ':productId'    => $productId
                    ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr) {
                    $aAutomation[$arr['setting']]   = $arr['value'];
                }
            }
            
            $oAutomation        = (object) $aAutomation;
            
            $suspendDate        = ($oAutomation->EnableAutoSuspension == 'on')
                                ? strtotime('+'. $oAutomation->AutoSuspensionPeriod .' days', $nextDue) : 0;
            $terminateDate      = ($oAutomation->EnableAutoTermination == 'on')
                                ? strtotime('+'. $oAutomation->AutoTerminationPeriod .' days', $nextDue) : 0;
            
            switch ($when)
            {
                // before AccountSuspend AccountTerminate 
                case 'before': {
                    
                    switch ($event)
                    {
                        case 'AccountSuspend': {
                            $executeDate            = $suspendDate 
                                                    ? strtotime('-'. $interval .' '. $intervalType, $suspendDate) : 0;
                            break;
                        }
                        case 'AccountTerminate': {
                            $executeDate            = $terminateDate 
                                                    ? strtotime('-'. $interval .' '. $intervalType, $terminateDate) : 0;
                            break;
                        }
                    }
                    
                    break;
                }
                
                // after AccountCreate NewOrder AccountSuspend AccountTerminate AccountUnsuspend
                case 'after': {
                    // [TODO] เหมือนยังไม่จำเป็น
                    break;
                }
                
            }
            
            if (! $executeDate) {
                continue;
            }
            
            $result         = $db->query("
                    SELECT
                        tl.*
                    FROM
                        hb_task_log tl
                    WHERE
                        tl.task_id = :taskId
                        AND tl.rel_type = 'Hosting'
                        AND tl.rel_id = :accountId
                    ", array(
                        ':taskId'       => $taskId,
                        ':accountId'    => $accountId
                    ))->fetch();
            
            if (isset($result['id'])) {
                
                if ($result['status'] == 'Pending') {
                    
                    $status     = (time() > $executeDate) ? 'Failed' : 'Pending';
                    
                    $db->query("
                        UPDATE
                            hb_task_log
                        SET
                            date_execute = :dateExecute,
                            status = :status
                        WHERE
                            id = :logId
                        ", array(
                            ':dateExecute'  => date('Y-m-d H:i:s',$executeDate),
                            ':logId'        => $result['id'],
                            ':status'       => $status
                        ));
                }
                
            } else {
                
                $status     = (time() > $executeDate) ? 'Failed' : 'Pending';
                
                $db->query("
                    INSERT INTO hb_task_log (
                        id, task_id, rel_type, rel_id, date_created, date_execute, status, log
                    ) VALUES (
                        '', :taskId, 'Hosting', :accountId, NOW(), :dateExecute, :status, ''
                    )
                    ", array(
                        ':taskId'       => $taskId,
                        ':accountId'    => $accountId,
                        ':status'       => $status,
                        ':dateExecute'  => date('Y-m-d H:i:s',$executeDate)
                    ));
                
            }
            
        }
        
    }
    
}


