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
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * ถ้าเลือกชำระเงินเป็น BankTransfer แล้วลูกค้าจ่ายเป็น Cheque
 * จะทำการบันทึกข้อมูลเกี่ยวกับ Cheque ลง description ของ transaction นั้นด้วย
 */

if (isset($_POST['newpayment']['is_cheque']) && $_POST['newpayment']['is_cheque']) {
    
    $notic      = 'ลูกค้าจ่ายด้วย Cheque ของธนาคาร: ' . $_POST['newpayment']['cheque_bank']
                . ' หมายเลขเช็ค: ' . $_POST['newpayment']['cheque_no']
                . "\n";
    
    $db->query("
            UPDATE hb_transactions
            SET description = CONCAT(:notic, description)
            ORDER BY id DESC
            LIMIT 1
            ", array(
                ':notic'            => $notic
            ));
    
}

