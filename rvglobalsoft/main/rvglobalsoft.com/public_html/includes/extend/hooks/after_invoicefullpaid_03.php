<?php

/**
 * Invoice has been fully paid
 * Following variable is available to use in this file:  $details This array of invoice details contains following keys:
 * $details["id"]; // Invoice id
 * $details["status"]; //Current invoice status
 * $details["client_id"]; //Owner of invoice
 * $details["date"]; //Invoice generation date
 * $details["subtotal"]; //Subtotal
 * $details["credit"]; //Credit applied to invoice
 * $details["tax"]; //Tax applied to invoice
 * $details["total"]; //Invoice total
 * $details["payment_module"]; //ID of gateway used with invoice
 * $details["currency_id"]; //ID of invoice currency, default =0
 * $details["notes"]; //Invoice notes
 * $details["items"]; // Invoice items are listed under this key, sample item:
 * $details["items"][0]["type"]; //Item type (ie. Hosting, Domain)
 * $details["items"][0]["item_id"]; //Item id, for type=Hosting this relates to hb_accounts.id field
 * $details["items"][0]["description"]; //Item line text
 * $details["items"][0]["amount"]; //Item price
 * $details["items"][0]["taxed"]; //Is item taxed? 1/0
 * $details["items"][0]["qty"]; //Item quantitiy
 */

 // --- hostbill helper ---
 $db         = hbm_db();
 // --- hostbill helper ---

/**
 * อ้างอิง after_invoicecreate_02.php
 * ตั้งระยะสัญญาให้กับ account / addon ใหม่ เริ่มจากวันที่จ่ายเงินครบ
 */

$invoiceId      = $details['id'];

$result     = $db->query("
            SELECT 
                ii.id, ii.type, ii.item_id, ii.description
            FROM 
                hb_invoices i,
                hb_invoice_items ii
            WHERE 
                i.id = :invoiceId
                AND i.id = ii.invoice_id
                AND ii.type IN ('Hosting', 'Addon')
            ", array(
                ':invoiceId'  => $invoiceId
            ))->fetchAll();

if (count($result)) {
    $aDatas     = $result;
    foreach ($aDatas as $data) {
        
        $invoiceItemId  = $data['id'];
        $desc           = $data['description'];
        
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