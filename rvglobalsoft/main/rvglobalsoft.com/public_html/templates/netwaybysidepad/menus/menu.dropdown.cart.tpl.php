<?php

$db = hbm_db();
$client = hbm_logged_client();
$oClient    = (object) $client;
$clientID  = $oClient->id;
$newURL = '';

$accountDetail = $db->query("
							SELECT
								product_id
								,status
							FROM
								hb_accounts
							WHERE
								client_id = :client_id
								AND product_id IN (58, 59)
							ORDER BY product_id DESC
							LIMIT 0,1
							", array(
								':client_id' => $clientID
							)
)->fetch();

if(isset($accountDetail['product_id']) && $accountDetail['product_id'] != ''){
	if($accountDetail['product_id'] == 58){
		$newURL = '?cmd=order2factorhb&action=gotoUpgrade';
	} else {
		$newURL = '?cmd=order2factorhb&action=checkLogIn';
	}
}
$this->assign('2faURL', $newURL);

$productLicense = array(
		"RV" => array(
			array(
				"id" => 71
				, "name" => "RVskin"
			)
			, array(
				"id" => 158
				, "name" => "RVsitebuilder"
			)
		), "Other" => array(
			array(
					"id" => 111
					, "name" => "cPanel"
			)
			/*
			, array(
					"id" => 135
					, "name" => "ISP manager"
			)
			, array(
					"id" => 138
					, "name" => "LiteSpeed"
			)
			*/
			, array(
					"id" => 145
					, "name" => "Softaculous"
			)
			, array(
					"id" => 116
					, "name" => "CloudLinux"
			)
			, array(
					"id" => 149
					, "name" => "Virtualizor"
			)
		)
);

$this->assign('product_license', $productLicense);
?>