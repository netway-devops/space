<?php

class cancel_invoice_when_account_terminate_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    
    
    /**
     * 
     * @return string
     */
    public function call_Hourly() 
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl . '/api.php');
        
        $current    = time();
        
        /*
        $aAccountId = array();
        $result     = $db->query("
            SELECT
                a.id, a.domain, i.status
            FROM
                hb_accounts a,
                hb_products p,
                hb_invoice_items ii,
                hb_invoices i
            WHERE
                a.product_id = p.id
                AND a.status = 'Suspended'
                AND p.category_id = 23
                AND a.id = ii.item_id
                AND ii.type = 'Hosting'
                AND ii.invoice_id = i.id
                AND i.duedate < '2014-04-25'
            ORDER BY i.duedate DESC
            ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $aAccount) {
                if (in_array($aAccount['id'], $aAccountId)) {
                    continue;
                }
                array_push($aAccountId, $aAccount['id']);
                if ($aAccount['status'] == 'Paid') {
                    continue;
                }
                $db->query("
                    UPDATE
                        hb_accounts
                    SET
                        status = 'Terminated'
                    WHERE
                        id = :accountId
                    ", array(
                        ':accountId'    => $aAccount['id']
                    ));
                $db->query("
                    INSERT INTO hb_system_log (
                        date,what,
                        who,type,item_id
                    ) VALUES (
                        NOW(),'Account status changed Suspended to Terminated', 
                        'prasit@rvglobalsoft.com','account', :accountId
                    )
                    ", array(
                        ':accountId'    => $aAccount['id']
                    ));
            }
        }
        */
        
        $startDate  = date('Y-m-d 00:00:00', strtotime('-12 hours', $current));
        $endDate    = date('Y-m-d H:i:s', $current);
        
        $message    = '';
        
        $result     = $db->query("
                SELECT
                    a.id
                FROM
                    hb_accounts a
                WHERE
                    a.status = 'Terminated'
                    AND (a.date_changed BETWEEN :startDate AND :endDate )
                ORDER BY a.date_changed DESC
                ", array(
                    ':startDate'        => $startDate,
                    ':endDate'          => $endDate
                ))->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $aAccounts          = $result;
        foreach ($aAccounts as $aAccount) {
            
            $itemId         = $aAccount['id'];
            
            $result         = $db->query("
                    SELECT
                        i.id
                    FROM
                        hb_invoice_items ii,
                        hb_invoices i
                    WHERE
                        ii.item_id = :itemId
                        AND ii.type = 'Hosting'
                        AND ii.invoice_id = i.id
                        AND i.status = 'Unpaid'
                    ", array(
                        ':itemId'       => $itemId
                    ))->fetchAll();
            
            if (! count($result)) {
                continue;
            }
            
            $aInvoices      = $result;
            
            foreach ($aInvoices as $aInvoice) {
                
                $cancelAble     = true;
                $invoiceId      = $aInvoice['id'];
                
                $result         = $db->query("
                        SELECT
                            ii.type, ii.item_id
                        FROM
                            hb_invoice_items ii
                        WHERE
                            ii.invoice_id = :invoiceId
                        ", array(
                            ':invoiceId'        => $invoiceId
                        ))->fetchAll();
                
                if (! count($result)) {
                    continue;
                }
                
                $aItems         = $result;
                foreach ($aItems as $aItem) {
                    
                    $itemId_2           = $aItem['item_id'];
                    
                    if ($aItem['type'] != 'Hosting') {
                        $cancelAble     = false;
                        break;
                    }
                    
                    if ($aItem['type'] == 'Hosting') {
                        
                        $result         = $db->query("
                                SELECT
                                    a.id
                                FROM
                                    hb_accounts a
                                WHERE
                                    a.id = :accountId
                                    AND a.status != 'Terminated'
                                ", array(
                                    ':accountId'        => $itemId_2
                                ))->fetch();
                        
                        if (isset($result['id']) && $result['id']) {
                            $cancelAble     = false;
                            break;
                        }
                        
                    }
                    
                }
                
                /* --- cancel ได้ --- */
                if ($cancelAble) {
                    
                    $aPost      = array(
                            'call'      => 'setInvoiceStatus',
                            'id'        => $invoiceId,
                            'status'    => 'Cancelled'
                        );
                    $aRes       = $apiCustom->request($aPost);
                    
                    if (isset($aRes['info'])) {
                        $message        .= ', '. $aRes['info'];
                    }
                    
                }
                
            }
            
            
        }
        
        return $message;
    }
    
}


