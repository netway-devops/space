<?php

/**
 * Addon was activated
 * Following variable is available to use in this file:  $details is ID property in hb_accounts_addons table
 */


// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
 */

$addonId    = $details;

if ($addonId) {
    
    $result     = $db->query("
                SELECT 
                    ii.id
                FROM 
                    hb_accounts_addons aa,
                    hb_orders o,
                    hb_invoice_items ii
                WHERE 
                    aa.id = :addonId
                    AND aa.order_id = o.id
                    AND o.invoice_id = ii.invoice_id
                    AND ii.type = 'Addon'
                    AND ii.item_id = :addonId
                    AND ii.is_shipped = 0
                ", array(
                    ':addonId' => $addonId
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
