<?php
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

$api = new ApiWrapper();

if(substr($details['items'][0]['description'],0,38) == '2-factor Authentication for WHM (Renew'){
	$clientId = $details['client_id'];
	$mainProductName = $details['items'][0]['description'];
	$lastAccountInfo = $db->query("
					SELECT
						id
						, client_id
						, order_id
						, product_id
						, next_due
						, status
					FROM
						hb_accounts
					WHERE
						client_id = :client_id
						AND (
							product_id = 59
							OR product_id = 60
							OR product_id = 61
						)

					", array(
						':client_id' => $clientId
	))->fetchAll();
	$lastAccountInfo = (array) $lastAccountInfo;

	if(sizeof($lastAccountInfo) == 3){
		$now = date('Y-m-d');
		if(strpos($mainProductName, 'Monthly') != null){
			$billingCycle = 'Monthly';
			$n1 = strtotime(date('Y-m-d', strtotime($now . '+1 months')));
			$n17 = strtotime(date('Y-m-7', strtotime($now . '+1 months')));	
		} else {
			$billingCycle = 'Annually';
			$n1 = strtotime(date('Y-m-d', strtotime($now . '+1 years')));
			$n17 = strtotime(date('Y-m-7', strtotime($now . '+1 years')));
		}
		if($n1 > $n17){
			if($billingCycle == 'Monthly'){
				$n17 = strtotime(date('Y-m-7', strtotime($now . '+2 months')));
			} else {
				$n17 = strtotime(date('Y-m-7', strtotime($now . '+1 years')));
			}
		}
		$nextDue = date('Y-m-d', $n17);
		$nextInv = date('Y-m-d', strtotime($nextDue . '-7 days'));
$i = 3;
		foreach($lastAccountInfo as $k => $v){
			$reNewParams = array('id' => $v['id']);
			if($v['status'] == 'Terminated'){
				$reNew = $api->accountCreate($reNewParams);
			} else if($v['product_id'] == 59){
				$reNew['success'] = 1;
			}
			if($reNew['success'] || $v['product_id'] == 60 || $v['product_id'] == 61){
				$db->query("
					UPDATE
						hb_accounts
					SET
						billingcycle = :billingcycle
						, next_due = :nextdue
						, next_invoice = :nextinv
						, date_changed = :datechanged
						, status = 'Active'
					WHERE
						id = :id
					", array(
						'billingcycle' => $billingCycle,
						'nextdue' => $nextDue,
						'nextinv' => $nextInv,
						'datechanged' => date('Y-m-d H:i:s'),
						'id' => $v['id']
					)
				);
				if($v['product_id'] == 59){
					$db->query("
							UPDATE
								hb_accounts
							SET
								total = :total
							WHERE
								id = :id
							", array(
								':total' => $details['total'],
								':id' => $v['id']
							));
				}
			}
		}
	}

}


