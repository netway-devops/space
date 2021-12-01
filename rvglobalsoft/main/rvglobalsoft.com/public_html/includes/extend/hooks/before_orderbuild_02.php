<?php
/**
 * Order data is about to be build (inserted into database)
 * @param array $details Following details are passed:
 * $details['product'] - array with ordered pacakge details
 * $details['configuration'] - array with ordered Form elements
 * $details['addons'] - array with ordered addons
 * $details['domains'] - array with ordered domains
 * $details['notes'] - order notes
 * $details['discounts'] - discounts applied in cart during order
 * $details['subproducts'] - subpackages ordered with main package
 * $details['client_id'] - client id that place this order.
 */

/*
 * $details['product']['id'] = 58;
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$clientId       = $details['client_id'];
$productId 		= $details['product']['id'];

if ($clientId == "8630") {
	echo "<pre>";
	print_r($details);
	
	//
	echo  "SELECT ac.client_id, ac.product_id
							                FROM hb_accounts ac
							                WHERE ac.client_id = ".$clientId."
							                	AND ac.product_id = ".$productId;
	
	if ($productId == '58') {
		  $aVipServiceDetail = $db->query("
							                SELECT ac.client_id, ac.product_id
							                FROM hb_accounts ac
							                WHERE ac.client_id = :clientId
							                	AND ac.product_id = :productId
							                ", array(
							                    ':clientId' => $clientId
		  									 , ':productId' => $productId
							                ))->fetch();
		  print_r($aVipServiceDetail);	
		  echo "</pre>";			            
	} 
	
	exit;
	
}


?>