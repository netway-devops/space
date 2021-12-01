<?php
//#############################SSL UPDATE ADDON STATUS##########################################
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

if(substr($details['items'][0]['description'], 0, 3) == 'SSL' && $details['status'] == 'Paid'){
	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
	$invoiceId = $details['id'];
	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
	$apiCustom  = $oAuth->generateAPICustom();

	$ord = $db->query("
			SELECT
				aa.id
			FROM
				hb_orders AS o
				, hb_accounts_addons AS aa
				, hb_ssl_order AS so
			WHERE
				o.invoice_id = {$invoiceId}
				AND o.id = aa.order_id
				AND so.order_id = o.id
			")->fetchAll();

			foreach($ord as $v){
				$id = $v['id'];
				$db->query("UPDATE hb_accounts_addons SET status = 'Active' WHERE id = {$id}");
			}

//############################RENEW CREATE#########################################
	$oQuery = $db->query("
    			SELECT
    				DISTINCT so.is_renewal
					, a.id AS account_id
    			FROM
    				hb_invoice_items AS ii
    				, hb_accounts AS a
    				, hb_orders AS o
    				, hb_ssl_order AS so
    			WHERE
    				ii.invoice_id = :invoiceId
    				AND ii.item_id = a.id
    				AND a.order_id = o.id
    				AND o.invoice_id != ii.invoice_id
    				AND so.order_id = o.id
    			", array(
    				':invoiceId' => $invoiceId
    			)
    	)->fetch();

	$accountId = $oQuery['account_id'];

	if($oQuery && $oAuth->isRenewal($invoiceId)){
		$apiCustom->request(array('call' => 'accountCreate', 'id' => $accountId));
	}

 }

