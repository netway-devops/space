<?php
/**
 * สำหรับ จ่ายผ่านบัตรเครดิตแบบ subscription
 * แก้ปัญหาเรื่องที่ว่า เวลา gen invoice มาอีก จะไม่มีรายการนี้ขึ้น
 * 49 คือ จ่ายแบบผ่านบัตรเครดิต subscription
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId          = $details;
$resultC     = $db->query("
            SELECT 
                i.*
            FROM 
                hb_invoices i
            WHERE 
                i.id = :invoiceId
                AND payment_module = 49
            ", array(
                ':invoiceId'  => $invoiceId
            ))->fetch();
if ($resultC) {
	$getFrmCreditCard = $db->query("
            SELECT 
                m.*
            FROM 
                hb_manual_payment m
            WHERE 
                m.invoice_id  = :invoiceId
            ", array(
                ':invoiceId'  => $invoiceId
            ))->fetch();
			//var_dump($getFrmCreditCard);
			
	if ($getFrmCreditCard == false) {
		
		$getFrmCreditCard = $db->query("
            INSERT INTO
            	hb_manual_payment
            	(invoice_id, client_id, status, date)
            	VALUES
            	(:invoiceid, :client_id,:status,:datenow)
            	 
            ", array(
                ':invoiceid'  => $invoiceId,
                ':client_id'  => $resultC['client_id'],
                ':status'  => 'Pending',
                ':datenow'  => date("Y-m-d")
            ));	 
	}
}
