<?php

/**
 * Addon was activated
 * Following variable is available to use in this file:  $details is ID property in hb_accounts_addons table
 */


// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

/**
 * ตั้งระยะสัญญาใน invoice ให้ service ทันที ถ้ายังไม่มีระยะสัญญา (ระยะสัญญามี comment <!--(07/05/2013 - 07/06/2013)--> )
 */

$addonId    = $details;

if ($addonId) {
    
    $result     = $db->query("
                SELECT 
                    ii.id, ii.description
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
                ", array(
                    ':addonId' => $addonId
                ))->fetch();
    
    if (isset($result['id']) && $result['id']) {
        $invoiceItemId  = $result['id'];
        $desc           = $result['description'];
        
        require_once(APPDIR . 'class.general.custom.php');
        $desc       = GeneralCustom::singleton()->newAccountTerm($desc);
        
        $db->query("
            UPDATE hb_invoice_items
            SET description = :itemDesc
            WHERE id = :invoiceItemId
            ", array(
                ':itemDesc'         => $desc,
                ':invoiceItemId'    => $invoiceItemId
            ));
    }

}
