<?php

class domainexpirehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_Hourly ()
    {
        $message    = '';
        
        $message    = $this->_updateRenewalDate();
        
        return $message;
    }
    
    private function _updateRenewalDate ()
    {
        $db         = hbm_db();
        $message    = '';

        $result     = $db->query("
            SELECT MAX(domain_log_id) AS logId
            FROM hb_domain_renewal_logs
            ")->fetch();
        
        $logId      = $result['logId'] ? $result['logId'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_domain_logs
            WHERE result = 1
                AND ( `change` LIKE '%name%Expires%'
                    OR `change` LIKE '%Domain renewed%'
                )
                AND id > '{$logId}'
            ORDER BY id ASC
            LIMIT 10
            ")->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $aLog) {
            $aData      = unserialize($aLog['change']);
            $domainId   = $aLog['domain_id'];
            $logDate    = $aLog['date'];
            
            if (! isset($aData['data'])) {
                continue;
            }
            $expire     = '';
            foreach ($aData['data'] as $arr) {
                if (($arr['name'] == 'Expires' || $arr['name'] == 'expires') && $arr['to']) {
                    $expire = $arr['to'];
                    break;
                }
            }
            $isFromInvoice  = 0;
            if (preg_match('/Domain\srenewed/i', $aData['data'])) {
                $isFromInvoice  = 1;
                $expire         = $logDate;
            }
            if (! $expire) {
                continue;
            }
            
            $invoiceId  = 0;
            $start      = '0000-00-00';
            if (strtotime($expire) > 0) {
                $sDate  = date('Y-m-d', strtotime('-60 day', strtotime($logDate)));
                $eDate  = date('Y-m-d', strtotime('+30 day', strtotime($logDate)));
                $result     = $db->query("
                    SELECT ii.*
                    FROM hb_invoice_items ii,
                        hb_invoices i
                    WHERE ii.invoice_id = i.id
                        AND ii.type LIKE 'Domain %'
                        AND ii.item_id = '{$domainId}'
                        AND ( i.duedate BETWEEN '{$sDate}' AND '{$eDate}' )
                        AND i.status IN ('Paid', 'Unpaid')
                        AND ii.description LIKE '%(%/%/%'
                    ")->fetch();
                
                $invoiceId  = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
                $desc       = isset($result['description']) ? $result['description'] : '';
        
                if (preg_match('/\s\((\d{2}\s[a-zA-Z]{3}\s\d{4})\s/', $desc, $match)) {
                    $date   = isset($match[1]) ? $match[1] : '';
                    $date   = $date ? $this->_convertStrtotime($date) : 0;
                    $start  = $date ? date('Y-m-d', $date) : $start;
                } else {
                    preg_match('/\(\s?(\d{2}\/\d{2}\/\d{4})\s?-/', $desc, $match);
                    $date   = isset($match[1]) ? $match[1] : '';
                    $date   = $date ? $this->_convertStrtotime($date) : 0;
                    $start  = $date ? date('Y-m-d', $date) : $start;
                }

                if ($isFromInvoice) {

                    if (preg_match('/\s(\d{2}\s[a-zA-Z]{3}\s\d{4})\)/', $desc, $match)) {
                        $date   = isset($match[1]) ? $match[1] : '';
                        $date   = $date ? $this->_convertStrtotime($date) : 0;
                        $expire = $date ? date('Y-m-d', $date) : '';
                    } else {
                        preg_match('/-\s?(\d{2}\/\d{2}\/\d{4}\s?)\)/', $desc, $match);
                        $date   = isset($match[1]) ? $match[1] : '';
                        $date   = $date ? $this->_convertStrtotime($date) : 0;
                        $expire = $date ? date('Y-m-d', $date) : '';
                    }

                }
                
            }
            
            if (! $expire) {
                continue;
            }
            
            $db->query("
                REPLACE INTO hb_domain_renewal_logs (
                domain_log_id, domain_id, log_date, invoice_id, start_date_invoice_item, end_date_domain_log,
                is_invoice_expire_date
                ) VALUES (
                :domain_log_id, :domain_id, :log_date, :invoice_id, :start_date_invoice_item, :end_date_domain_log,
                :is_invoice_expire_date
                )
                ", array(
                    ':domain_log_id'    => $aLog['id'],
                    ':domain_id'    => $domainId,
                    ':log_date'     => $logDate,
                    ':invoice_id'   => $invoiceId,
                    ':start_date_invoice_item'  => $start,
                    ':end_date_domain_log'      => $expire,
                    ':is_invoice_expire_date'   => $isFromInvoice,
                ));
            
            $message    .= ' domain_log_id : '. $aLog['id'];
            $message    .= ' domain_id:'. $domainId;
            $message    .= ' log_date:'. $logDate;
            $message    .= ' invoice_id:'. $invoiceId;
            $message    .= ' start_date_invoice_item:'. $start;
            $message    .= ' end_date_domain_log:'. $expire;
            $message    .= "<br/>\n";
            
        }
        
        return $message;
    }
    
    /**
     * จะต้องรันหลังจาก Change status of expired domains  5-10 นาที
     * SELECT id 
     * FROM hb_domains 
     * WHERE status='Active' 
     *    AND expires!='0000-00-00' 
     *    AND DATE_ADD(expires,INTERVAL 1 DAY) <= '2013-04-29 10:34:06'
     * UPDATE hb_domains SET status='Expired' WHERE id='3091'
     * @return string
     */
    public function call_Daily() {
        
        $db         = hbm_db();
        
        $currentDate    = date('Y-m-d H:i:s');
        $aOrderIds      = array();
        
        /* --- เลียนแบบการ query Change status of expired domains    --- */
        $reselt     = $db->query("
                    SELECT 
                        o.id, o.invoice_id
                    FROM 
                        hb_domains d,
                        hb_orders o
                    WHERE 
                        d.status = 'Expired'
                        AND d.expires != '0000-00-00'
                        AND DATE_ADD(d.expires, INTERVAL 1 DAY) <= :currentDate
                        AND d.order_id = o.id
                        AND o.status = 'Pending'
                    ", array(
                        ':currentDate'  => $currentDate
                    ))->fetchAll();
        
        if (is_array($reselt) && count($reselt)) {
            $aDatas         = $reselt;
            
            foreach ($aDatas as $aData) {
                
                if ($aData['id']) {
                    
                    /* --- proforma invoice ย่อยไม่ต้องทำการเปลี่ยนแปลง เพราะจะทำให้ provisioning ไม่เป็น automation --- */
                    
                    $result     = $db->query("
                            SELECT
                                ii.id
                            FROM
                                hb_invoice_items ii
                            WHERE
                                ii.type = 'Invoice'
                                AND ii.item_id = :invoiceId
                            ", array(
                                ':invoiceId'    => $aData['invoice_id']
                            ))->fetch();
                            
                    if (isset($result['id']) && $result['id']) {
                        continue;
                    }
                    
                    /* --- cancel order --- */
                    $db->query("
                        UPDATE hb_orders 
                        SET status='Cancelled' 
                        WHERE id = :orderId 
                        ", array(
                            ':orderId' => $aData['id']
                        ));
                    
                    array_push($aOrderIds, $aData['id']);
                    
                    /* --- cancel invoice --- */
                    if ($aData['invoice_id']) {
                        
                        $db->query("
                            UPDATE hb_invoices 
                            SET status = 'Cancelled' 
                            WHERE id = :invoiceId 
                                AND status = 'Unpaid'
                            ", array(
                                ':invoiceId' => $aData['invoice_id']
                            ));
                    }
                }
                
            }
        }
        
        $message        = '';
        if (count($aOrderIds)) {
            //$message   .= 'Cancelled order ' . implode(',', $aOrderIds) . ' after domain is set expired';
        }
        
        return $message;
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $aMonth     = array(
            'jan' => '1',
            'feb' => '2',
            'mar' => '3',
            'apr' => '4',
            'may' => '5',
            'jun' => '6',
            'jul' => '7',
            'aug' => '8',
            'sep' => '9',
            'oct' => '10',
            'nov' => '11',
            'dec' => '12',
        );

        if (preg_match('/(\d{2})\s([a-zA-Z]{3})\s(\d{4})/', $str, $matches)) {
            $d  = isset($matches[1]) ? $matches[1] : 00;
            $m  = ( isset($matches[2]) && isset($aMonth[strtolower($matches[2])]) ) ? $aMonth[strtolower($matches[2])] : 00;
            $y  = isset($matches[3]) ? $matches[3] : 0000;
            return strtotime($y .'-'. $m .'-'. $d);
        }
        
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
}
