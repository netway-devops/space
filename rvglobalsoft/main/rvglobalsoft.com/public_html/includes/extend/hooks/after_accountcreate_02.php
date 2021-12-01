<?php

/**
 * Account-related module (for ex. cPanel) successfully created account
 * Following variable is available to use in this file:  $details $details = array('service' => ACCOUNT DETAILS ARRAY,
 * 'account_id' => ACCOUNT ID, 'server' => RELATED SERVER DETAILS ARRAY)
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

/**
 * ตั้งระยะสัญญาใน invoice ให้ service ทันที ถ้ายังไม่มีระยะสัญญา (ระยะสัญญามี comment <!--(07/05/2013 - 07/06/2013)--> )
 */

$accountId  = isset($details['service']['id']) ? $details['service']['id'] : 0;

if ($accountId) {
    
    $result     = $db->query("
                SELECT 
                    ii.id, ii.description, a.product_id
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
                ", array(
                    ':accountId' => $accountId
                ))->fetch();
    
    if (isset($result['id']) && $result['id']) {
        $invoiceItemId  = $result['id'];
        $desc           = $result['description'];
        $productId      = $result['product_id'];
        
        require_once(APPDIR . 'class.general.custom.php');

        if ($productId == 162) {
            $desc       = preg_replace('/\<\!\-\-(.*)\-\-\>/', '$1', $desc);
        } else {
            $desc       = GeneralCustom::singleton()->newAccountTerm($desc);
        }
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
