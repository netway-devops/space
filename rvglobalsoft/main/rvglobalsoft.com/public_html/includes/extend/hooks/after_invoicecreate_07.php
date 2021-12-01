<?php
/**
 * สำหรับ การตั้งค่า next gen invoice เท่ากับ 0 รึว่า ค่าว่าง
 * มันจะ update next gen เป็นค่า default ใน โปรแกรม คือ 7 วัน
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId          = $details;
$resultC     = $db->query("
            SELECT 
                acc.id,acc.next_due
            FROM 
                hb_invoice_items i,
                hb_accounts acc,
                hb_automation_settings s
            WHERE 
                i.item_id = acc.id
                AND acc.product_id = s.item_id
                AND s.setting = 'InvoiceGeneration'
                AND (s.value =  '' OR s.value =  '0')
                AND i.invoice_id = :invoiceId
            ", array(
                ':invoiceId'  => $invoiceId
            ))->fetch();
if ($resultC) {
	$resup = $db->query("
                UPDATE hb_accounts
                SET next_invoice = :newdate
                WHERE id = :acccountid
                ", array(
                    ':newdate'         => $resultC['next_due'],
                    ':acccountid'    => $resultC['id']
                ));
}
