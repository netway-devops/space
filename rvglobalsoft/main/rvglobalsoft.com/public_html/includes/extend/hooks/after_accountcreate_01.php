<?php

/**
 * Account-related module (for ex. cPanel) successfully created account
 * Following variable is available to use in this file:  $details $details = array('service' => ACCOUNT DETAILS ARRAY,
 * 'account_id' => ACCOUNT ID, 'server' => RELATED SERVER DETAILS ARRAY)
 */

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
 */

$accountId  = isset($details['service']['id']) ? $details['service']['id'] : 0;

if ($accountId) {
    
    $result     = $db->query("
                SELECT 
                    ii.id
                FROM 
                    hb_accounts a,
                    hb_orders o,
                    hb_invoice_items ii
                WHERE 
                    a.id = :accountId
                    AND a.order_id = o.id
                    AND o.invoice_id = ii.invoice_id
                    AND ii.type = 'Hosting'
                    AND ii.item_id = :accountId
                    AND ii.is_shipped = 0
                ", array(
                    ':accountId' => $accountId
                ))->fetch();
    
    if (isset($result['id']) && $result['id']) {
        $db->query("
            UPDATE hb_invoice_items 
            SET is_shipped = 1
            WHERE id = :invoiceItemId
        ", array(
            ':invoiceItemId'    => $result['id']
        ));
    }

}
