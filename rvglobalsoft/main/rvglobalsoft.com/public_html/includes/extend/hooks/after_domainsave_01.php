<?php

/**
 * Domain details has been changed
 * Following variable is available to use in this file:  $details POST params from domain details save form.
 * Some of available keys:
 * $details['id']; // Domain id in hb_domains table
 * $details['period']; // Domain registartion period (in years)
 * $details['expires']; // Domain expiration date
 * $details['date_created']; // Domain registartion date
 * $details['reg_module']; // Domain registrar module ID
 * $details['firstpayment']; // Domain registration price
 * $details['status']; // Current domain status
 * $details['recurring_amount']; // Current domain renewal price
 * $details['name']; // Domain name, ie. example.com
 * $details['nameservers']['ns1']; // Domain NS1
 * $details['nameservers']['ns2']; // Domain NS2
 * $details['epp_code']; // Domain Epp Code
 * $details['autorenew']; // Is aytorenew enabled
 * $details['notes']; // Domain notes
 */


// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
 */

if (isset($_POST['is_shipped']) && $_POST['is_shipped']) {
    
    $db->query("
        UPDATE hb_invoice_items 
        SET is_shipped = 1
        WHERE id = :invoiceItemId
    ", array(
        ':invoiceItemId'    => $_POST['is_shipped']
    ));
    
}

