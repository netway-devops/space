<?php
// HOOK ACTION : CREATE ALL LICENSE IF INVOICE PAID AND STATUS NOT ACTIVE
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
require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';

 // --- hostbill helper ---
 $db         = hbm_db();
 // --- hostbill helper ---

$oAuth =& RvLibs_SSL_PHPLibs::singleton();
$apiCustom  = $oAuth->generateAPICustom();
// --- hostbill helper ---

foreach($details['items'] as $eachItem){
	$isLicense = $db->query("
			SELECT
				a.status
				, p.name
			FROM
				hb_invoice_items AS ii
				, hb_accounts AS a
				, hb_products AS p
				, hb_categories AS c
			WHERE
				ii.id = :ii_id
				AND ii.item_id = a.id
				AND a.product_id = p.id
				AND p.category_id = c.id
				AND c.name LIKE '%Licenses%'
	", array(':ii_id' => $eachItem['id']))->fetch();
	if($isLicense){
		$accountId = $eachItem['item_id'];
		$status = $isLicense['status'];
		switch($status){
			case 'Suspended': $call = 'accountUnsuspend'; break;
			case 'Terminated': $call = 'accountCreate'; break;
			default: unset($call);
		}
		if($call){
			$cParams = array(
					'call' => $call
					, 'id' => $accountId
			);
			$apiOutput = $apiCustom->request($cParams);
		}
	}
}

/**
 * [XXX] 0001420: [general] Domains are not renewed automatically when invoice is paid
 * Hostbill แก้ไขให้แล้ว ไม่ต้องมีไฟล์นี้
 * ทำ auto renew domain ทันที
 */
