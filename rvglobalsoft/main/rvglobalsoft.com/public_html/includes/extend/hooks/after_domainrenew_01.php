<?php

/**
 * HostBill succesfully renewed domain
 * $details = array('id'=>RELATED DOMAIN ID IN HOSTBILL,
 * 'name'=>DOMAIN NAME);
 * Following variable is available to use in this file:  $details
 */


// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
 */


$domainId  = isset($details['id']) ? $details['id'] : 0;

if ($domainId) {
    
    $result     = $db->query("
                SELECT 
                    ii.id
                FROM 
                    hb_domains d,
                    hb_orders o,
                    hb_invoice_items ii
                WHERE 
                    d.id = :domainId
                    AND d.order_id = o.id
                    AND o.invoice_id = ii.invoice_id
                    AND ii.type = 'Domain Renew'
                    AND ii.item_id = :domainId
                    AND ii.is_shipped = 0
                ", array(
                    ':domainId' => $domainId
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

