<?php

/**
 * สร้าง Ticket สำหรับ product cpanel license
 * กรณี ip นี้มี risk score สูง
 */

$db             = hbm_db();
$orderId        = $details;

$getRiskScore = $db->query("
	SELECT
		a.id AS acct_id
		, ca.data AS risk_score
	FROM
		hb_config2accounts AS ca
		, hb_accounts AS a
		, hb_config_items_cat AS ic
	WHERE
		a.order_id = :oid
		AND a.id = ca.account_id
		AND ca.config_cat = ic.id
		AND ic.variable = :variable
", array(
	":oid" => $orderId
	, ":variable" => 'risk_score'
))->fetch();

if($getRiskScore && $getRiskScore["risk_score"] > 0){
	require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');
	$url = 'https://rvglobalsoft.com/7944web/?cmd=accounts&action=edit&id=' . $getRiskScore["acct_id"];

	$content = 'This cPanel license order have high risk score : <br /><br />';
	$content .= "<a href='{$url}' target='_blank'>{$url}</a><br /><br />";
	$content .= "Please verify them.";


	$mail = new PHPMailerNew();
	$mail->From = 'nobody@rvglobalsot.com';
	$mail->FromName = 'RVLicense Team';
	$mail->AddAddress('support@rvglobalsoft.zendesk.com');
	$mail->Subject = 'cPanel License Order : High Risk Score';
	$mail->Body = $content;

	$mail->ISHTML(true);

	$mail->Send();
}