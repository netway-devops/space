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

/**
 * ทำการบันทึกว่าถ้ามีค่าธรรมเนียมในการ add payment ให้บันทึกด้วยว่าเกี่ยวกับอะไร
 * โดยจะแยกค่าเป็น code:message บันทึกกันคนละ field
 */

if (isset($_POST['newpayment']['feeType']) && $_POST['newpayment']['feeType'] && $_POST['newpayment']['fee'] > 0) {
    
    $aFee       = @explode(':', $_POST['newpayment']['feeType']);
    $feeCode    = $aFee[0];
    $feeMessage = $aFee[1];
    
    if ($feeCode == 'B01') {
        $pre = '-';
    } else {
        $pre = '';
    }
    
    $db->query("
            UPDATE hb_transactions
            SET 
                `fee` = {$pre}`fee`,
                fee_code    = :feeCode,
                fee_message = :feeMessage
            ORDER BY id DESC
            LIMIT 1
            ", array(
                ':feeCode'            => $feeCode,
                ':feeMessage'         => $feeMessage,
            ));
    
}

