<?php

/**
 * Transaction has been sucessfully stored in HostBill database
 * Following variable is available to use in this file:  $details new transaction details, following keys are available:
 * $details['client_id']; //RELATED CLIENT ID,
 * $details['invoice_id']; //RELATED INVOICE ID
 * $details['module']; //RELATED GATEWAY NAME,
 * $details['date']; //TRANSACTION DATE,
 * $details['descr']; //TRANSACTION DESCRIPTION,
 * $details['in']; //IN AMOUNT,
 * $details['fee']; //APPLIED FEEs (if any),
 * $details['out']; //AMOUNT SENT to gateway from your account (if any)
 * $details['trans_id'];  //GATEWAY SPECIFIC Transaction ID)
 * $details['currency_id']; //Transaction currency id, default=0
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

/* --- แก้ปัญหาตอน add transaction แล้ว trans_id ถูก gen ใหม่แทนที่จะใช้ค่าที่กรอก --- */

if (isset($_POST['trans_id']) && $_POST['trans_id']) {
    
    $transId    = $_POST['trans_id'];
    
    $db->query("
            UPDATE 
                hb_transactions
            SET 
                trans_id = :transId
            ORDER BY id DESC
            LIMIT 1
            ", array(
                ':transId'            => $transId
            ));
    
}

