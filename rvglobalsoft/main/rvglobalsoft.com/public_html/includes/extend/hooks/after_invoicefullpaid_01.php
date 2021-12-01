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
 $db->query("SELECT '". __FILE__ ."' ");
 // --- hostbill helper ---

/**
 * ออกหมายเลขใบกำกับภาษีให้ invoice นั้นทันทีเมื่อ invoice paid
 */

$invoiceId      = $details['id'];

require_once(APPDIR . 'class.config.custom.php');
$nwTaxNumber    = ConfigCustom::singleton()->getValue('nwTaxNumber');

require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

$result         = $db->query("
                SELECT 
                    i.id, i.tax, i.invoice_number
                FROM 
                    hb_invoices i
                WHERE 
                    i.id = :invoiceId
                ", array(
                    ':invoiceId'        => $invoiceId,
                ))->fetch();

if (isset($result['id'])) {
    
    /**
     * ต้องมี vat และยังไม่มี invoice_number
     */
    //if (floatval($result['tax']) > 0 && $result['invoice_number'] == '' ) {
        $invoiceNumber  = invoicehandle_controller::buildTaxNumberFormat($nwTaxNumber);
        
        $db->query("
            UPDATE hb_invoices
            SET invoice_number = :invoiceNumber
            WHERE 
                id = :invoiceId
            LIMIT 1
        ", array(
            ':invoiceNumber'    => $invoiceNumber,
            ':invoiceId'        => $invoiceId,
        ));
        
    //}
}
