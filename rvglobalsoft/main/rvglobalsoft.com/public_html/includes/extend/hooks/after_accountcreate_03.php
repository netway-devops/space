<?php

/**
 * Account-related module (for ex. cPanel) successfully created account
 * Following variable is available to use in this file:  $details $details = array('service' => ACCOUNT DETAILS ARRAY,
 * 'account_id' => ACCOUNT ID, 'server' => RELATED SERVER DETAILS ARRAY)
 */

// --- hostbill helper ---
require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
$db         = hbm_db();
$oAuth =& RvLibs_SSL_PHPLibs::singleton();
// --- hostbill helper ---

$accountId  = isset($details['service']['id']) ? $details['service']['id'] : 0;
$productChk = $db->query("
		SELECT
			mc.module
		FROM
			hb_modules_configuration AS mc
		WHERE
			mc.id = {$details['product']['module']}
			AND mc.module = 'ssl'
")->fetch();
if($accountId && $productChk['module']){
	$partnerOrderIdQ = $db->query("SELECT partner_order_id FROM hb_ssl_order WHERE order_id = {$details['service']['order_id']}")->fetch();
	$partnerOrderId = $partnerOrderIdQ['partner_order_id'];
	$sslDetail = $oAuth->GetOrderByPartnerOrderID($partnerOrderId, array('ReturnCertificateInfo' => True));
	$next_due = strtotime($sslDetail['details']['certificateInfo']['expireDate']);
	$next_due = date("Y-m-d",$next_due);

	$db->query("UPDATE hb_accounts SET next_due = '{$next_due}' WHERE id = {$accountId}");

}