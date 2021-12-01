<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$templateVars	=	$this->get_template_vars();

$result	=	$db->query("
						SELECT
							a.* , p.name as product_name , i.status as payment_status
						FROM
							hb_accounts a , hb_products p , hb_orders o , hb_invoices i
						WHERE
							a.client_id = :clientID
							AND a.product_id IN (882,883)
							AND a.product_id = p.id
							AND a.order_id = o.id
							AND o.invoice_id = i.id
						ORDER BY a.id DESC
						", array(
							':clientID'		=>	$templateVars['login']['id']
						))->fetchAll();

$this->assign('allServer' , $result);

$vpslist = array();
foreach($result as $data){
	if($data['product_name'] == 'Basic VPS'){
		$vpslist[] = $data['id'];
	}
}

if(!empty($vpslist)){

	$inVpslist = implode(",", $vpslist);
	
	$result	=	$db->query("
							SELECT
								*
							FROM
								hb_vps_details
							WHERE
								account_id IN ({$inVpslist})
							")->fetchAll();
							
	$this->assign('vpslists' , $result);
}
//echo '<pre>'.print_r($result,true).'</pre>';
