<?php

/**
 * New invoice has just been created with ID=$details
 *  This event is called after every items saved for the invoice.
 *  So if you will get this event you will be sure that invoice has been successfully created.
 * Following variable is available to use in this file:  $details This variable keeps invoice id
 */

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * Update invoice due date 
 * [XXX] เฉพาะ Domain Renew ก่อน เพราะวัน duedate เป็นวันเดียวกันกับวัน create
 */

$invoiceId          = $details;
$isAllRenewDomain   = false;

$result     = $db->query("
            SELECT 
                i.id, ii.type, ii.item_id
            FROM 
                hb_invoices i,
                hb_invoice_items ii
            WHERE 
                i.id = :invoiceId
                AND i.id = ii.invoice_id
                
            ", array(
                ':invoiceId'  => $invoiceId
            ))->fetchAll();

if (count($result)) {
    foreach ($result as $data) {
        if ($data['type'] == 'Domain Renew') {
            $isAllRenewDomain   = true;
        } else {
            $isAllRenewDomain   = false;
            break;
        }
        
    }
}

if ($isAllRenewDomain) {
    $result     = $db->query("
                SELECT 
                    MIN(d.expires) AS expire
                FROM 
                    hb_invoices i,
                    hb_invoice_items ii,
                    hb_domains d
                WHERE 
                    i.id = :invoiceId
                    AND i.id = ii.invoice_id
                    AND ii.item_id = d.id
                    AND ii.type = 'Domain Renew'
                ", array(
                    ':invoiceId'  => $invoiceId
                ))->fetch();
    if (isset($result['expire'])) {
        $db->query("
        UPDATE hb_invoices
        SET duedate = :expireDate
        WHERE id = :invoiceId
        ", array(
            ':expireDate'   => $result['expire'],
            ':invoiceId'    => $invoiceId
        ));
    }
    
}