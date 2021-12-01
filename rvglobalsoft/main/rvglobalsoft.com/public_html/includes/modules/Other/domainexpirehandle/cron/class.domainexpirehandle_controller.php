<?php

class domainexpirehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
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
            foreach ($reselt as $aData) {
                
                if ($aData['id']) {
                    
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
            $message   .= 'Cancelled order ' . implode(',', $aOrderIds) . ' after domain is set expired';
        }
        
        echo $message;
        
        return $message;
    }
    
}
