<?php

class orderreviewhandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_Hourly()  
    {
        $db         = hbm_db();
        
        $message    = '';
        $message    .= self::_activeOrderAllServiceActive();
        
        return $message;
    }
    
    /**
     * เพิ่ม cron update order status ในกรณี account active แล้ว แต่ order ยัง pending
     */
    private function _activeOrderAllServiceActive ()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        $lastMonth  = date('Y-m-d H:i:s', strtotime('-3 month'));
        
        $result     = $db->query("
            SELECT o.*
            FROM hb_orders o
            WHERE o.status = 'Pending'
                AND o.date_created > :lastMonth
            ORDER BY o.id ASC
            LIMIT 100
            ", array(
                ':lastMonth'    => $lastMonth
            ))->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr_) {
            $orderId    = $arr_['id'];
            
            $result     = $db->query("
                SELECT ft.id
                FROM hb_fulfillment_ticket ft,
                    hb_tickets t
                WHERE ft.order_id = :orderId
                    AND ft.ticket_id = t.id
                    AND t.status != 'Closed'
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                continue;
            }
            
            $result     = $db->query("
                SELECT a.id
                FROM hb_accounts a
                WHERE a.order_id = :orderId
                    AND a.status != 'Active'
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                continue;
            }
            
            $result     = $db->query("
                SELECT d.id
                FROM hb_domains d
                WHERE d.order_id = :orderId
                    AND d.status != 'Active'
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                continue;
            }
            
            $result     = $db->query("
                SELECT u.id
                FROM hb_upgrades u
                WHERE u.order_id = :orderId
                    AND u.status = 'Pending'
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                continue;
            }
            
            $result     = $db->query("
                SELECT aa.id
                FROM hb_accounts_addons aa
                WHERE aa.order_id = :orderId
                    AND aa.status != 'Active'
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                continue;
            }
            
            // --- set order active ---
            $db->query("
                UPDATE hb_orders SET status='Active' WHERE id='{$orderId}'
                ");
            $db->query("
                INSERT INTO hb_order_log (`order_id`, `date`,`type`,`entry`, `who`) 
                VALUES 
                ('{$orderId}', NOW(), '', 'Order status changed Pending -> Active', 'Automation')
                ");
            
            $output     = 'Completed by cron module orderreview';
            $db->query("
                UPDATE `hb_order_steps`
                SET status = 'Completed',
                    date_changed = NOW(),
                    output = 'Completed by cron module orderreview'
                WHERE order_id = {$orderId}
                    AND step_id = 5
                ");
            
            $db->query("
                INSERT INTO hb_system_log(date,what,who,type,item_id) 
                VALUES 
                (NOW(),'Order Active by cron module orderreview','Automation','order','{$orderId}')
                ");
            $message    .= 'Order '. $orderId .' status changed Pending -> Active by cron module orderreview';
            
        }
        
        return $message;
    }
    
    public function call_Daily()  
    {
        $db         = hbm_db();
        
        $message    = '';
        $message    .= self::_cancelTerminatedOrder();
        
        return $message;
    }
    
    private function _cancelTerminatedOrder ()
    {
        $db         = hbm_db();
        $message    = '';
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $nwOrderReviewCancelIndex       = ConfigCustom::singleton()->getValue('nwOrderReviewCancelIndex');
        $nwOrderReviewCancelIndex       = unserialize($nwOrderReviewCancelIndex);
        $domainLogId    = isset($nwOrderReviewCancelIndex['domainLogId']) ? $nwOrderReviewCancelIndex['domainLogId'] : 0;
        $accountLogId   = isset($nwOrderReviewCancelIndex['accountLogId']) ? $nwOrderReviewCancelIndex['accountLogId'] : 0;
        
        $result         = $db->query("
            SELECT MAX(id) AS idx
            FROM hb_domain_logs
            ")->fetch();
        
        $maxId          = isset($result['idx']) ? $result['idx'] : 0;
        $domainLogId    = ($domainLogId > $maxId) ? $maxId : $domainLogId;
        
        $result     = $db->query("
            SELECT dl.id, d.order_id
            FROM hb_domain_logs dl,
                hb_domains d
            WHERE dl.id > :id
                AND dl.domain_id = d.id
            ORDER BY dl.id ASC
            LIMIT 100
            ", array(
                ':id'   => $domainLogId
            ))->fetchAll();
        
        if (count($result)) {
            $result1        = $result;
            
            foreach ($result1 as $arr) {
                $domainLogId    = $arr['id'];
                $message        .= self::_cancelOrder($arr['order_id']);
            }
            
        }
        
        
        $result         = $db->query("
            SELECT MAX(id) AS idx
            FROM hb_account_logs
            ")->fetch();
        
        $maxId          = isset($result['idx']) ? $result['idx'] : 0;
        $accountLogId   = ($accountLogId > $maxId) ? $maxId : $accountLogId;
        
        $result     = $db->query("
            SELECT al.id, a.order_id
            FROM hb_account_logs al,
                hb_accounts a
            WHERE al.id > :id
                AND al.account_id = a.id
            ORDER BY al.id ASC
            LIMIT 100
            ", array(
                ':id'   => $accountLogId
            ))->fetchAll();
        
        if (count($result)) {
            $result1        = $result;
            
            foreach ($result1 as $arr) {
                $accountLogId   = $arr['id'];
                $message        .= self::_cancelOrder($arr['order_id']);
            }
            
        }
        
        $nwOrderReviewCancelIndex['domainLogId']    = $domainLogId;
        $nwOrderReviewCancelIndex['accountLogId']   = $accountLogId;
        
        $nwOrderReviewCancelIndex       = serialize($nwOrderReviewCancelIndex);
        ConfigCustom::singleton()->setValue('nwOrderReviewCancelIndex', $nwOrderReviewCancelIndex);
        
        return $message;
    }
    
    private function _cancelOrder ($orderId)
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT o.*
            FROM hb_orders o,
                hb_invoices i
            WHERE o.id = :id
                AND o.invoice_id = i.id
                AND o.status = 'Pending'
                AND i.status = 'Paid'
            ", array(
                ':id'   => $orderId
            ))->fetch();
        
        if (! isset($result['id'])) {
            return $message;
        }
        
        $invoiceId      = $result['invoice_id'];
        $status         = $result['status'];
        
        $result     = $db->query("
            SELECT ii.*
            FROM hb_invoice_items ii
            WHERE ii.invoice_id = :invoiceId
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();
        
        if (! count($result)) {
            continue;
        }
        
        $result_    = $result;
        $enable     = true;
        
        foreach ($result_ as $arr) {
            $itemId     = $arr['item_id'];
            $type       = $arr['type'];
            
            if (preg_match('/domain/i', $type)) {
                $result     = $db->query("
                    SELECT d.*
                    FROM hb_domains d
                    WHERE d.id = :id
                        AND d.status NOT IN ('Cancelled','Fraud')
                    ", array(
                        ':id'   => $itemId
                    ))->fetch();
                
                if (isset($result['id'])) {
                    $enable     = false;
                    break;
                }
                
            } else if (preg_match('/hosting/i', $type)) {
                $result     = $db->query("
                    SELECT a.*
                    FROM hb_accounts a
                    WHERE a.id = :id
                        AND a.status NOT IN ('Terminated','Cancelled','Fraud')
                    ", array(
                        ':id'   => $itemId
                    ))->fetch();
                
                if (isset($result['id'])) {
                    $enable     = false;
                    break;
                }
                
            } else if (preg_match('/addon/i', $type)) {
                $result     = $db->query("
                    SELECT aa.*
                    FROM hb_accounts_addons aa
                    WHERE aa.id = :id
                        AND aa.status NOT IN ('Terminated','Cancelled')
                    ", array(
                        ':id'   => $itemId
                    ))->fetch();
                
                if (isset($result['id'])) {
                    $enable     = false;
                    break;
                }
                
            } else {
                // [TODO] --- รองรับเฉพาะ hosting และ domain ก่อน
                $enable     = false;
                break;
            }
            
        }
    
        if ($enable) {
            $db->query("
                UPDATE hb_orders SET status='Cancelled' WHERE id='{$orderId}'
                ");
            $db->query("
                INSERT INTO hb_order_log (`order_id`, `date`,`type`,`entry`, `who`) 
                VALUES 
                ('{$orderId}', NOW(), '', 'Order status changed {$status} -> Cancelled', 'Automation')
                ");
            $db->query("
                INSERT INTO hb_system_log(date,what,who,type,item_id) 
                VALUES 
                (NOW(),'Order Cancelled','Automation','order','{$orderId}')
                ");
            $message    = 'Order '. $orderId .' status changed '. $status .' -> Cancelled';
        }
        
        
        return $message;
    }
    
    public function call_Weekly()  
    {
        $db         = hbm_db();
        
        $message    = '';
        $message    .= self::_deletePendingOrder();
        
        return $message;
    }
    
    // ทำ order เฉยๆแล้วไม่ทำอะไรต่อ
    private function _deletePendingOrder ()
    {
        $db         = hbm_db();
        $message    = '';
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $nwOrderReviewDeleteIndex       = ConfigCustom::singleton()->getValue('nwOrderReviewDeleteIndex');
        
        $result     = $db->query("
            SELECT o.*
            FROM hb_orders o,
                hb_invoices i
            WHERE o.id > :id
                AND o.invoice_id = i.id
                AND o.status = 'Pending'
                AND i.status = 'Unpaid'
                AND o.date_created < DATE_SUB(now(), INTERVAL 6 MONTH)
            ORDER BY o.id ASC
            LIMIT 100
            ", array(
                ':id'   => $nwOrderReviewDeleteIndex
            ))->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result1    = $result;
        
        foreach ($result1 as $arr) {
            $orderId    = $arr['id'];
            $nwOrderReviewDeleteIndex   = $orderId;
            
            $invoiceId  = $arr['invoice_id'];
            $clientId   = $arr['client_id'];
            
            $result     = $db->query("
                SELECT ii.*
                FROM hb_invoice_items ii
                WHERE ii.invoice_id = :invoiceId
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetchAll();
            
            if (! count($result)) {
                continue;
            }
            
            $result2    = $result;
            $pending    = true;
            
            foreach ($result2 as $arr) {
                $itemId     = $arr['item_id'];
                $type       = $arr['type'];
                
                if (preg_match('/domain/i', $type)) {
                    $result     = $db->query("
                        SELECT d.*
                        FROM hb_domains d
                        WHERE d.id = :id
                            AND d.status != 'Pending'
                        ", array(
                            ':id'   => $itemId
                        ))->fetch();
                    
                    if (isset($result['id'])) {
                        $pending    = false;
                        break;
                    }
                    
                } else if (preg_match('/hosting/i', $type)) {
                    $result     = $db->query("
                        SELECT a.*
                        FROM hb_accounts a
                        WHERE a.id = :id
                            AND a.status != 'Pending'
                        ", array(
                            ':id'   => $itemId
                        ))->fetch();
                    
                    if (isset($result['id'])) {
                        $pending    = false;
                        break;
                    }
                    
                } else {
                    // [TODO] --- รองรับเฉพาะ hosting และ domain ก่อน
                    $pending    = false;
                    break;
                }
                
            }
            
            if (! $pending) {
                continue;
            }
            
            // --- ลบ pending order --- 
            $db->query("
                INSERT INTO hb_order_log (`order_id`, `date`,`type`,`entry`, `who`
                ) VALUES (
                '{$orderId}', NOW(), '', 'Deleting order', 'Automation'
                )
                ");
            
            $db->query("
                DELETE FROM hb_accounts_addons  WHERE order_id='{$orderId}' AND account_id NOT IN
                (SELECT id AS account_id FROM hb_accounts WHERE order_id='{$orderId}' AND client_id!='{$clientId}')
                ");
            
            $result     = $db->query("
                SELECT a.*
                FROM hb_accounts a
                WHERE a.order_id = :orderId
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                $accountId      = $result['id'];
                
                $db->query("
                    DELETE FROM hb_account_logs WHERE account_id='{$accountId}'
                    ");
                $db->query("
                    DELETE FROM hb_accounts_addons WHERE account_id='{$accountId}'
                    ");
                $db->query("
                    DELETE FROM hb_cancel_requests WHERE account_id='{$accountId}'
                    ");
                $db->query("
                    DELETE FROM hb_accounts WHERE id='{$accountId}'
                    ");
                $db->query("
                    DELETE FROM hb_accounts2servers WHERE account_id='{$accountId}'
                    ");
                $db->query("
                    DELETE FROM hb_config2accounts WHERE account_id='{$accountId}'
                    ");
                
                $db->query("
                    UPDATE hb_task_log t JOIN hb_task_list ls ON ls.id=t.task_id 
                    SET t.status='Archived' 
                    WHERE t.rel_id='{$accountId}' AND t.rel_type='Hosting' AND t.status ='OK'
                    ");
                $db->query("
                    DELETE t FROM hb_task_log t JOIN hb_task_list ls ON ls.id=t.task_id 
                    WHERE t.rel_id='{$accountId}' AND t.rel_type='Hosting' AND t.status !='Archived'
                    ");
                
            }
            
            $result     = $db->query("
                SELECT id FROM hb_domains WHERE order_id = :orderId AND client_id='{$clientId}' AND type!='Renew'
                ", array(
                    ':orderId'      => $orderId
                ))->fetch();
            
            if (isset($result['id'])) {
                $domainId       = $result['id'];
                
                $db->query("
                    DELETE FROM hb_domain_logs WHERE domain_id='{$domainId}'
                    ");
                $db->query("
                    DELETE FROM hb_domains WHERE order_id='{$orderId}' AND client_id='{$clientId}' AND type!='Renew'
                    ");
                
            }
            
            $db->query("
                DELETE FROM hb_invoices WHERE id='{$invoiceId}'
                ");
            $db->query("
                DELETE FROM hb_invoice_items WHERE invoice_id='{$invoiceId}'
                ");
            $db->query("
                DELETE FROM hb_transactions WHERE invoice_id='{$invoiceId}'
                ");
            $db->query("
                DELETE FROM hb_upgrades WHERE order_id='{$orderId}'
                ");
            $db->query("
                DELETE FROM hb_config_upgrades WHERE order_id='{$orderId}'
                ");
            $db->query("
                DELETE FROM hb_orders WHERE id='{$orderId}'
                ");
            
            $message    .= "\n<br />" . "Order Deleted (ID: {$orderId})";
            
            $db->query("
                INSERT INTO hb_system_log(date,what,who,type,item_id) 
                VALUES 
                (NOW(),'Order Deleted (ID: {$orderId})','Automation','none','')
                ");
            
        }
        
        ConfigCustom::singleton()->setValue('nwOrderReviewDeleteIndex', $nwOrderReviewDeleteIndex);
        
        return $message;
    }
    
}
