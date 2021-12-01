<?php

class geninvoicehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * 
     * @return string
     */
    public function call_EveryRun ()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        $message    .= $this->_updateGenerateInvoicesNextRun();
        
        return $message;
    }
    
    /**
     * ให้เรียกใช้งานก่อน 9 โมง
     */
    public function call_Daily ()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        $message    .= $this->_updateInvoiceNextGenForToday();
        
        return $message;
    }
    
    private function _updateGenerateInvoicesNextRun ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $endTime    = strtotime(date('Y-m-d 16:00:00', time()));
        $nextRun    = $endTime;
        $result     = $db->query("
            SELECT *
            FROM hb_domains
            WHERE next_invoice LIKE '%:01:01'
                AND next_invoice > NOW()
            ORDER BY next_invoice ASC
            LIMIT 1
            ")->fetch();
        
        if (isset($result['id'])) {
            $newRun = strtotime($result['next_invoice']);
            if ($newRun < $nextRun) {
                $nextRun    = $newRun;
            }
        }
        
        $result     = $db->query("
            SELECT *
            FROM hb_accounts
            WHERE next_invoice LIKE '%:01:01'
                AND next_invoice > NOW()
            ORDER BY next_invoice ASC
            LIMIT 1
            ")->fetch();
        
        if (isset($result['id'])) {
            $newRun = strtotime($result['next_invoice']);
            if ($newRun < $nextRun) {
                $nextRun    = $newRun;
            }
        }
        
        $runTime    = '1200';
        if ($nextRun != $endTime) {
            $runTime    = date('H', $nextRun) .'30';
        }

        $db->query("
            UPDATE hb_cron_tasks
            SET run_every_time = :runTime
            WHERE task = 'generateInvoices'
            ", array(
                ':runTime'  => $runTime
            ));
        
        return $message;
    }
    
    private function _updateInvoiceNextGenForToday ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $db->query("
            UPDATE hb_cron_tasks
            SET run_every_time = '1200'
            WHERE task = 'generateInvoices'
            ");
        
        $currentDateTime    = date('Y-m-d 12:00:00', time());
        $aAddress   = array();
        
        $result     = $db->query("
            SELECT d.*, cd.firstname, cd.lastname, cd.language
            FROM hb_domains d
            JOIN hb_client_details cd ON (cd.id=d.client_id)
            LEFT JOIN hb_automation_settings au ON au.item_id = d.tld_id AND au.setting = 'RenewInvoice'
            WHERE
                d.autorenew='1'
                AND d.billing_contact_id != 0
                AND d.status='Active'
                AND d.next_invoice<=:currentDateTime
                AND d.next_invoice!='0000-00-00 00:00:00'
                AND (au.value IS NULL OR au.value = 1)
                AND d.id NOT IN (
                    SELECT dd.id FROM hb_domains dd
                    JOIN hb_orders o ON (o.id=dd.order_id)
                    WHERE o.date_created > DATE_SUB(:currentDateTime, INTERVAL 6 MONTH)
                )
            ", array(
                ':currentDateTime'  => $currentDateTime
            ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $id         = $arr['id'];
                $clientId   = $arr['client_id'];
                $addressId  = $arr['billing_contact_id'];
                if (! is_array($aAddress[$clientId][$addressId]['domain'])) {
                    $aAddress[$clientId][$addressId]['domain']  = array();
                }
                array_push($aAddress[$clientId][$addressId]['domain'], $id);
            }
        }
        
        $result     = $db->query("
            SELECT a.billing_contact_id, a.client_id, a.next_due, a.next_invoice, a.total, a.billingcycle, a.payment_module, a.id, a.product_id, p.name, p.tax,
            cd.firstname, cd.lastname, a.domain, c.name as catname, cd.language
            FROM hb_accounts a JOIN hb_client_details cd ON(a.client_id=cd.id)
            LEFT JOIN hb_products p ON (a.product_id=p.id)
            LEFT JOIN hb_categories c ON (p.category_id=c.id)
            WHERE (a.status='Active' OR a.status='Suspended' ) 
                AND a.next_invoice<=:currentDateTime 
                AND a.next_invoice!='0000-00-00' 
            AND a.billing_contact_id != 0
            AND a.billingcycle<>'One Time' AND a.billingcycle<>'Free'
            ORDER BY a.client_id
            ", array(
                ':currentDateTime'  => $currentDateTime
            ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $id         = $arr['id'];
                $clientId   = $arr['client_id'];
                $addressId  = $arr['billing_contact_id'];
                if (! is_array($aAddress[$clientId][$addressId]['hosting'])) {
                    $aAddress[$clientId][$addressId]['hosting']  = array();
                }
                array_push($aAddress[$clientId][$addressId]['hosting'], $id);
            }
        }
        
        if (! count($aAddress)) {
            return $message;
        }
        
        $aAddress_  = $aAddress;
        foreach ($aAddress_ as $clientId => $arr) {
            $start  = 10;
            foreach ($arr as $addressId => $arr2) {
                $aAddress[$clientId][$addressId]['start']   = $start;
                $start++;
            }
        }
        
        foreach ($aAddress as $clientId => $arr) {
            foreach ($arr as $addressId => $arr2) {
                $start  = $arr2['start'] ? $arr2['start'] : 10;
                $nextInvoice    = date('Y-m-d '. $start .':01:01', strtotime($currentDateTime));
                
                if (isset($arr2['domain']) && count($arr2['domain'])) {
                    $db->query("
                        UPDATE hb_domains
                        SET next_invoice = :nextInvoice
                        WHERE id IN (". implode(',', $arr2['domain']) .")
                        ", array(
                            ':nextInvoice'  => $nextInvoice
                        ));
                }
                
                if (isset($arr2['hosting']) && count($arr2['hosting'])) {
                    $db->query("
                        UPDATE hb_accounts
                        SET next_invoice = :nextInvoice
                        WHERE id IN (". implode(',', $arr2['hosting']) .")
                        ", array(
                            ':nextInvoice'  => $nextInvoice
                        ));
                }
                
            }
        }
        
        $db->query("
            UPDATE hb_cron_tasks
            SET run_every_time = '0930'
            WHERE task = 'generateInvoices'
            ");
        
        return $message;
    }

}


