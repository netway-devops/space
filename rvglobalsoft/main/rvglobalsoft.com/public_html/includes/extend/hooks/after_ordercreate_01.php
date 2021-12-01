
<?php

/**
 * New order has been placed
 * Following variable is available to use in this file:  $details is ID property in hb_orders table
 */


// --- hostbill helper ---
require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

$oAuth =& RvLibs_SSL_PHPLibs::singleton();
$apiCustom  = $oAuth->generateAPICustom();
// --- hostbill helper ---

$orderId    = $details;

$aOrder     = $db->query("
            SELECT
				o.client_id
				,o.invoice_id
				,o.id
				,o.total
            FROM
				hb_orders o
            WHERE
				o.id = :orderId
            ", array(
                ':orderId' => $orderId
            ))->fetch();

/**
 * คืนค่า credit ให้ลูกค้าจาก after_invoicecreate_01.php
 */
if (isset($aOrder['client_id']) && $aOrder['client_id']) {
    $clientId   = $aOrder['client_id'];

    $credit     = 0;
    $creditSwap = 0;
    $aClientBilling     = $db->query("
                    SELECT cb.credit, cb.credit_swap
                    FROM hb_client_billing cb
                    WHERE cb.client_id = :clientId
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();

    $credit     = $aClientBilling['credit'] + $aClientBilling['credit_swap'];

    $db->query("
        UPDATE hb_client_billing
        SET credit = :credit,
            credit_swap = :creditSwap
        WHERE client_id = :clientId
    ", array(
        ':credit'       => $credit,
        ':creditSwap'   => $creditSwap,
        ':clientId'     => $clientId
    ));

}



if (isset($_SESSION['AppSettings']['admin_login'])) {
		$item		= $aOrder['invoice_id'];

		$aItem = $db->query("
			SELECT
				i.description
			FROM
				hb_invoice_items i
			WHERE
				i.invoice_id = :invoice_id
			", array(
					':invoice_id' => $item
			)
		)->fetch();

			$itemdes	= $aItem['description'];
			$chkproduct = substr($itemdes,0,3);

			if ($chkproduct == "SSL") {
				$cComment 	= substr($itemdes,0,-34);
				$desword 	= substr($cComment,6);

				$sslid = $db->query("
						SELECT
						s.ssl_id
						FROM
						hb_ssl s
						WHERE
						ssl_name LIKE '$desword'
						")->fetch();

				$getsslid		= $sslid['ssl_id'];
				$order_id 		= $aOrder['id'];
				$usr_id   		= $aOrder['client_id'];
				$date_created 	= time();
				$last_updated 	= time();
				$sqlprice	  	= $aOrder['total'];

				$sqlpricesearch = $db->query("
				SELECT
					c.a 			AS oneyear
					,c.b 			AS twoyear
					,c.t 			AS threeyear
				FROM
					hb_ssl 			AS s
					,hb_products 	AS p
					,hb_common 		AS c
				WHERE
					s.ssl_name = p.name
					AND p.id = c.id
					AND c.rel = 'Product'
				 	AND s.ssl_id = :ssl_id
				", array(
						':ssl_id' => $getsslid
				)
				)->fetch();

				$oneyear 	= $sqlpricesearch['oneyear'];
				$twoyear 	= $sqlpricesearch['twoyear'];
				$threeyear 	= $sqlpricesearch['threeyear'];

				if ($oneyear == $sqlprice) {
					$price = "12";
				} elseif ($twoyear == $sqlprice) {
					$price = "24";
				} elseif ($threeyear == $sqlprice) {
					$price = "36";
				} else {
					$price = "0";
				}

				//insert to hb_ssl_order
				/*$inserttosslorder = $db->query("
				INSERT INTO hb_ssl_order
					( order_id, usr_id, date_created, last_updated,
			  		  ssl_id, contract, server_type , partner_order_id , symantec_status)
				VALUES
					( :order_id, :usr_id, :date_created, :last_updated,
			  		  :ssl_id, :price, :server_type , :partner_order_id , :symantec_status)
		 		", array(
				 		':order_id' 	=> $order_id,
				 		':usr_id'		=> $usr_id,
				 		':date_created' => $date_created,
				 		':last_updated' => $last_updated,
				 		':ssl_id' 		=> $getsslid,
				 		':price' 		=> $price,
				 		':server_type' 	=> 'Other',
				 		':partner_order_id'  => 'RVSSL_'.$orderId,
				 		':symantec_status' => 'WAITING_SUBMIT_CSR'
				 )
				 );*/

		} ///endif

}


$chkWHMCS = $db->query("SELECT settings FROM hb_order_drafts_items WHERE settings LIKE '%,\"category_id\":\"1\"' OR settings LIKE '%,\"orderId_forecast\":{$orderId}}' OR settings LIKE '%,\"orderId_forecast\":\"{$orderId}\"}'")->fetchAll();
if($chkWHMCS){
	$chkWHMCS = json_decode($chkWHMCS[0]["settings"], 1);
	$_SESSION["SSLORDER"] = $chkWHMCS["session"]["SSLORDER"];
	$_SESSION["SSLSAN"] = $chkWHMCS["session"]["SSLSAN"];
	if(isset($chkWHMCS["session"]["WHMCS_ORDER"])){
		$_SESSION["WHMCS_ORDER"] = $chkWHMCS["session"]["WHMCS_ORDER"];
	}
}

if (isset($_SESSION['SSLORDER'])) {
	$dataCSR 	= $_SESSION['SSLORDER']['csr'];
	$dataCSRmd5 = md5($dataCSR);
	$order_id 	= $aOrder['id'];
	$invoiceId = $aOrder['invoice_id'];
	$adminOrder = false;
	if($_SESSION['SSLORDER']['csr'] == ''){
		$symantec_status = 'WAITING_SUBMIT_CSR';
	} else {
		$symantec_status = 'WAITING_SUBMIT_ORDER';
	}
	if($_SESSION['SSLORDER']['ssl_validation_id'] == '1'){
		$custom_techaddress = 0;
	} else {
		$custom_techaddress = isset($_SESSION['SSLORDER']['same_address']) ? $_SESSION['SSLORDER']['same_address'] : 1;
	}
	$insertorderssl = $db->query("
			INSERT INTO hb_ssl_order
				(order_id, usr_id, date_created, last_updated, csr, ssl_id, email_approval, server_type, contract, pid, commonname ,partner_order_id ,custom_techaddress ,symantec_status, hashing_algorithm, dns_name, san_amount, server_amount, comment)
			VALUES
				(:order_id, :usr_id, :date_created, :last_updated, :csr, :ssl_id, :email_approval, :server_type, :contract, :pid, :commonname, :partner_order_id, :custom_techaddress, :symantec_status, :hashing_algorithm, :dns_name, :additional_domain, :additional_server, :comment)
			", array(
				':order_id' => $orderId,
				':usr_id' => $clientId,
				':date_created' => time(),
				':last_updated' => time(),
				':csr' => isset($_SESSION['SSLORDER']['csr']) ? $_SESSION['SSLORDER']['csr'] : '',
				':ssl_id' => isset($_SESSION['SSLORDER']['ssl_id']) ? $_SESSION['SSLORDER']['ssl_id']: '',
				':email_approval' => isset($_SESSION['SSLORDER']['email_approval']) ? $_SESSION['SSLORDER']['email_approval'] : '',
				':server_type' => isset($_SESSION['SSLORDER']['servertype']) ? $_SESSION['SSLORDER']['servertype'] : '',
				':contract' => isset($_SESSION['SSLORDER']['contract']) ? $_SESSION['SSLORDER']['contract'] : '',
				':pid' => isset($_SESSION['SSLORDER']['pid']) ? $_SESSION['SSLORDER']['pid'] : '',
				':commonname' => isset($_SESSION['SSLORDER']['commonname']) ? $_SESSION['SSLORDER']['commonname'] : '',
				':partner_order_id'   => 'RVSSL_'.$orderId,
				':custom_techaddress' => 1,//$custom_techaddress,
				':symantec_status'    => $symantec_status,
				':hashing_algorithm'  => isset($_SESSION['SSLORDER']['hashing_algorithm']) ? $_SESSION['SSLORDER']['hashing_algorithm'] : '',
				':dns_name' => isset($_SESSION['SSLSAN']['dns_name']) ? $_SESSION['SSLSAN']['dns_name'] : '',
				':additional_domain' => isset($_SESSION['SSLSAN']['additional_domain']) ? $_SESSION['SSLSAN']['additional_domain'] : 0,
				':additional_server' => isset($_SESSION['SSLSAN']['additional_server']) ? $_SESSION['SSLSAN']['additional_server'] : 0,
				':comment' => isset($_SESSION["WHMCS_ORDER"]) ? 'order from WHMCS' : ""
			)
	);

	$aDomain = (isset($_SESSION['SSLORDER']['commonname'])) ? $_SESSION['SSLORDER']['commonname'] : '';
	$db->query("
			UPDATE
				hb_accounts
			SET
				domain = '{$aDomain}'
			WHERE
				order_id = {$orderId}
	");
	if(isset($dataCSR)){
		$query_contact =$db->query("
				SELECT
					COUNT(*) AS cnt
				FROM
					hb_ssl_order_contact
				WHERE
					csr_md5 = :md5
				",array(
						':md5' => $dataCSRmd5
			)
		)->fetch();
		if($query_contact['cnt']!="0") {
			$db->query("
				UPDATE
					hb_ssl_order_contact
				SET
					order_id = :order_id
				WHERE
					csr_md5 = :csr
					AND order_id = 0
				",array(
					':order_id' => $order_id,
					':csr' => $dataCSRmd5
				)
			);

		}
	}

	$have_promo = false;
	if(isset($_SESSION['SSLPROMO'])){
		$promo_code = $_SESSION['SSLPROMO']['code'];
		$promo_type = $_SESSION['SSLPROMO']['type'];
		$promo_value = $_SESSION['SSLPROMO']['value'];
		$promo_cycle = $_SESSION['SSLPROMO']['cycle'];
// 		$adminOrder = $oAuth->getExtraPromo($clientId, $promo_code);
		$have_promo = true;
		$discount = 0;
		unset($_SESSION['SSLPROMO']);

		$nowInv = $db->query("SELECT id, amount FROM hb_invoice_items WHERE invoice_id = {$invoiceId}")->fetch();
		$firstPrice = floatval($nowInv['amount']);

		switch($promo_type){
			case 'fixed' :
				$firstPrice -= $promo_value;
				$discount += $promo_value;
				break;
			case 'percent' :
				$promo_cal = (100-$promo_value)/100;
				$discount += $firstPrice-($firstPrice*$promo_cal);
				$firstPrice *= $promo_cal;
				if($promo_value == '100' || $promo_value == '100.00'){
					$adminOrder = true;
				}
				break;
		}

// 		$db->query("UPDATE hb_invoice_items SET amount = '{$firstPrice}' WHERE id = {$nowInv['id']}");
	}

	$iParams = array('call' => 'getInvoiceDetails', 'id' => $invoiceId);
	$thisInvoice = $apiCustom->request($iParams);
	//$paidEmail = ($thisInvoice['invoice']['status'] == 'Paid') ? true : false;
	$paidEmail = $thisInvoice['invoice']['status'];
	$sendMail = false;

	if($thisInvoice['success']){
		$getInvoice = $db->query("
				SELECT
					a.id AS acct_id
					, o.id AS order_id
					, a.date_created
					, a.next_due
					, a.product_id
					, p.name
					, p.tax
					, a.billingcycle
					, so.san_amount
					, so.server_amount
					, i.payment_module
					, i.status AS payment_status
				FROM
					hb_invoices AS i
					, hb_accounts AS a
					, hb_orders AS o
					, hb_products AS p
					, hb_ssl AS s
					, hb_ssl_order AS so
				WHERE
					i.id = {$invoiceId}
					AND o.invoice_id = i.id
					AND o.id = a.order_id
					AND a.product_id = p.id
					AND p.name = s.ssl_name
					AND o.id = so.order_id
		")->fetch();

		if(isset($getInvoice['product_id']) && $getInvoice['product_id'] != null){
			$pid = $getInvoice['product_id'];
			$cyc = $getInvoice['billingcycle'];
			$acctId = $getInvoice['acct_id'];
			$ordId = $getInvoice['order_id'];
			$paymentModule = $getInvoice['payment_module'];
			$addonStat = ($getInvoice['payment_status'] == 'Paid') ? 'Active' : 'Pending';
			$dateCreate = date('d/m/Y', strtotime($getInvoice['date_created']));
			$dateEnd = date('d/m/Y', (strtotime($getInvoice['next_due'])-(60*60*24)));
			$sanAmount = $getInvoice['san_amount'];
			$servAmount = $getInvoice['server_amount'];
			$qty = $comment['san']['amount'];
			$tax = $getInvoice['tax'];

			switch($cyc){
				case 'Annually': $scyc = 'a'; break;
				case 'Biennially': $scyc = 'b'; break;
				case 'Triennially': $scyc = 't'; break;
			}

			$cParams = array(
					'call' => 'getProductApplicableAddons',
					'id' => $pid
			);

			$productAddonsList = $apiCustom->request($cParams);
			if($productAddonsList['success'] && $sanAmount > 0){
				foreach($productAddonsList['addons']['addons'] as $vv){
					$productId = explode(',', $vv['products']);
					if(in_array($pid, $productId)){
						$aParams = array(
								'call' => 'getAddonDetails'
								, 'id' => $vv['id']
						);
						$addonDetail = $apiCustom->request($aParams);
						$price = $addonDetail['addon'][$scyc];
						$name = $addonDetail['addon']['name'];
						$description = "+ Additional Domain Name";
						$description .= ($sanAmount > 1) ? 's' : '';
						$description .= " x {$sanAmount} " /*. ({$dateCreate} - {$dateEnd}) "Account #{$acctId}"*/;

						$cParams = array(
								'call' => 'addInvoiceItem'
								, 'id' => $invoiceId
								, 'line' => $description
								, 'price' => $price
								, 'qty' => $sanAmount
								, 'tax' => $addonDetail['addon']['taxable']
						);
						$addInvoiceResponse = $apiCustom->request($cParams);

						$getAccount = $apiCustom->request(array('call' => 'getAccountDetails', 'id' => $acctId));
						$nowP = $getAccount['details']['total'];
						$totalPrice = ($price*$sanAmount)+$nowP;
						$editAccountParams = array(
								'call' => 'editAccountDetails'
								, 'id' => $acctId
								, 'total' => $totalPrice
								, 'firstpayment' => $totalPrice
						);
						$apiCustom->request($editAccountParams);
						$db->query("UPDATE hb_orders SET total = {$totalPrice} WHERE id = {$ordId}");
						if($addInvoiceResponse['success']){
							$regDate = date('Y-m-d', strtotime($getInvoice['date_created']));
							$nextDue = date('Y-m-d', (strtotime($getInvoice['next_due'])-(60*60*24)));
							$nextInv = date('Y-m-d', (strtotime($getInvoice['next_due'])-(60*60*24*7)));
							$db->query("
									INSERT INTO
										`hb_accounts_addons`(
											`account_id`
											, `order_id`
											, `addon_id`
											, `payment_module`
											, `name`
											, `setup_fee`
											, `recurring_amount`
											, `billingcycle`
											, `status`
											, `regdate`
											, `next_due`
											, `next_invoice`
										) VALUES (
											:acctId
											, :orderId
											, :addonId
											, :payModule
											, :name
											, :setupFee
											, :recurringAmount
											, :cyc
											, :status
											, :regdate
											, :next_due
											, :next_invoice
										)
							", array(
									':acctId' => $acctId
									, ':orderId' => $ordId
									, ':addonId' => $vv['id']
									, ':payModule' => $paymentModule
									, ':name' => $description
									, ':setupFee' => 0.00
									, ':recurringAmount' => $price*$sanAmount
									, ':cyc' => $cyc
									, ':status' => $addonStat
									, ':regdate' => $regDate
									, ':next_due' => $nextDue
									, ':next_invoice' => $nextInv
							));

							$db->query("UPDATE hb_invoice_items SET item_id = {$acctId} WHERE invoice_id = {$invoiceId}");
						}
					}
				}
			}


			if($servAmount > 1){
				$getInvoiceDetails = $apiCustom->request(array('id' => $invoiceId, 'call' => 'getInvoiceDetails'));
				$servPrice = 0.00;
				foreach($getInvoiceDetails['invoice']['items'] as $v){
					$servPrice+=$v['linetotal'];
					if($have_promo && substr($v['description'], 0, 12) != '+ Additional'){
						$discount += ($v['linetotal']-$firstPrice)*($servAmount-1);
					}
				}
				if($servPrice > 0){
					$sqty = $servAmount-1;
					$servDescription = "+ Additional Server";
					$servDescription .= ($sqty > 1) ? "s" : "";
					$servDescription .= " x {$sqty} " /*. ({$dateCreate} - {$dateEnd}) "Account #{$acctId}"*/;
					$sParams = array(
							'call' => 'addInvoiceItem'
							, 'id' => $invoiceId
							, 'line' => $servDescription
							, 'price' => $servPrice
							, 'qty' => $sqty
							, 'tax' => $tax
					);
					$addInvoiceResponse = $apiCustom->request($sParams);

					$getAccount = $apiCustom->request(array('call' => 'getAccountDetails', 'id' => $acctId));
					$nowP = $getAccount['details']['total'];
					$totalPrice = ($sqty*$servPrice)+$nowP;
					$editAccountParams = array(
							'call' => 'editAccountDetails'
							, 'id' => $acctId
							, 'total' => $totalPrice
							, 'firstpayment' => $totalPrice
					);
					$apiCustom->request($editAccountParams);
					$db->query("UPDATE hb_orders SET total = {$totalPrice} WHERE id = {$ordId}");
					$db->query("UPDATE hb_invoice_items SET item_id = {$acctId} WHERE invoice_id = {$invoiceId}");
				}
			}
		}

		$getInvoiceDetails = $apiCustom->request(array('id' => $invoiceId, 'call' => 'getInvoiceDetails'));

		if($adminOrder){
			$discount = (isset($totalPrice)) ? $totalPrice - 0.01 : $discount - 0.01;
		}

		if($have_promo){
			$discountParams = array(
					'call' => 'addInvoiceItem'
					, 'id' => $invoiceId
					, 'line' => 'Discount:'
					, 'price' => $discount*(-1)
					, 'qty' => 1
					, 'tax' => 0
			);
			$discountAdd = $apiCustom->request($discountParams);
			$getInvoiceDetails = $apiCustom->request(array('id' => $invoiceId, 'call' => 'getInvoiceDetails'));
			$sumPrice = 0.00;
			$firstPrice = 0.00;
			foreach($getInvoiceDetails['invoice']['items'] as $v){
				$firstPrice += $v['linetotal'];
				if($promo_cycle != 'recurring' && $v['description'] == 'Discount:'){
					continue;
				} else {
					$sumPrice += $v['linetotal'];
				}
			}
			$accountId = $db->query("SELECT id FROM hb_accounts WHERE order_id = {$orderId}")->fetch();
			$accountId = $accountId['id'];
			$apiCustom->request(array('call' => 'editAccountDetails', 'id' => $accountId, 'total' => $sumPrice, 'firstpayment' => $firstPrice));

			$coupon = $db->query("SELECT id, num_usage FROM hb_coupons WHERE code = '{$promo_code}'")->fetch();
			if($coupon){
				$nowdate = date('Y-m-d');
				$coupon_id = $coupon['id'];
				$num_usage = intval($coupon['num_usage']);
				$num_usage++;
				$db->query("UPDATE hb_coupons SET num_usage = {$num_usage} WHERE code = '{$promo_code}'");
				$db->query("INSERT INTO hb_coupons_log (coupon_id, client_id, order_id, date, discount) VALUES ({$coupon_id}, {$clientId}, {$orderId}, '{$nowdate}', {$discount})");
			}

			$invoiceTotal = $db->query("SELECT subtotal FROM hb_invoices WHERE id = {$invoiceId}")->fetch();
			$setOrderTotal = $db->query("UPDATE hb_orders SET total = {$invoiceTotal["subtotal"]} WHERE id = {$ordId}");
		}

		if(isset($_SESSION['SSLSAN']) && ((isset($_SESSION['SSLSAN']['additional_domain']) && $_SESSION['SSLSAN']['additional_domain'] > 0 ) || (isset($_SESSION['SSLSAN']['additional_server']) && $_SESSION['SSLSAN']['additional_server'] > 1 )) && (true || !$oAuth->checkClientCredit($order_id))){
			$iParams = array('call' => 'getInvoiceDetails', 'id' => $invoiceId);
			$thisInvoice = $apiCustom->request($iParams);
			$paymentModule = $thisInvoice['invoice']['payment_module'];

			$clientCredit = $db->query("SELECT credit FROM hb_client_billing WHERE client_id = {$clientId}")->fetch();
// 			$paidByCredit = $db->query("SELECT * FROM hb_client_credit_log WHERE invoice_id = {$invoiceId}")->fetch();
			if($clientCredit){
				$nowCredit = $clientCredit['credit'];
				$invDB = $db->query("SELECT * FROM hb_invoices WHERE id = {$invoiceId}")->fetch();
				$sslAdditional = $db->query("SELECT san_amount, server_amount FROM hb_ssl_order WHERE order_id = {$order_id}")->fetch();
				if($sslAdditional && ($sslAdditional['san_amount'] > 0 || $sslAdditional['server_amount'] > 1)){
					$nowPaid = $invDB['credit']; // จ่ายไป
					$total = $invDB['subtotal']; // ราคารวม
					$admin['id'] = (isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['id'])) ? $_SESSION['AppSettings']['admin_login']['id'] : 0;
					$admin['email'] = (isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['username'])) ? $_SESSION['AppSettings']['admin_login']['username'] : '';
					$date = date('Y-m-d H:i:s');
					if(($nowCredit+$nowPaid) >= $total){
						// หักเงินเพิ่ม
						$totalCredit = $total;
						$total-=$nowPaid;
						$balance = $nowCredit-$total;
						$db->query("INSERT INTO `hb_client_credit_log`(`date`, `client_id`, `in`, `out`, `balance`, `description`, `transaction_id`, `invoice_id`, `admin_id`, `admin_name`) VALUES ('{$date}', '{$clientId}','0.00','{$total}','{$balance}','Credit applied to invoice','0','{$invoiceId}','{$admin['id']}','{$admin['email']}')");
						$db->query("UPDATE hb_client_billing SET credit = {$balance} WHERE client_id = {$clientId}");
						//$addPaymentParams = array('call' => 'addInvoicePayment', 'id' => $invoiceId, 'amount' => $total, 'paymentmodule' => $paymentModule, 'fee' => 0, 'date' => $date);
						$db->query("UPDATE hb_invoices SET credit = {$totalCredit}, total = 0.00 WHERE id = {$invoiceId}");
						$paidEmail = 'Paid';
						$sendMail = true;
						$apiCustom->request(array('call' => 'accountCreate', 'id' => $acctId));
					} else {
						// คืน credit
						 $totalPrice = $total; // 85
						 $total-=$nowPaid; // ตอนนี้เหลือ 85-75 = 10 ที่ต้องจ่าย
						 // $nowCredit : credit ที่เหลือ
						 if($nowCredit > 0 && $nowCredit < $total){
						 	$balance = $total - $nowCredit;
						 	$newCredit = $nowPaid+$nowCredit;
						 	$db->query("INSERT INTO `hb_client_credit_log`(`date`, `client_id`, `in`, `out`, `balance`, `description`, `transaction_id`, `invoice_id`, `admin_id`, `admin_name`) VALUES ('{$date}', '{$clientId}','0.00','{$nowCredit}','0.00','Credit applied to invoice','0','{$invoiceId}','{$admin['id']}','{$admin['email']}')");
						 	$db->query("UPDATE hb_client_billing SET credit = 0.00 WHERE client_id = {$clientId}");
						 	$db->query("UPDATE hb_invoices SET credit = {$newCredit}, total = {$balance} WHERE id = {$invoiceId}");
// 						 	$createParams = array('call' => 'accountCreate', 'id' => $acctId);
// 						 	$apiCustom->request($createParams);
						 }
					}
				}
			}
		} else {
			$clientCredit = $db->query("SELECT credit FROM hb_client_billing WHERE client_id = {$clientId}")->fetch();
			if($clientCredit){
				$nowCredit = $clientCredit['credit'];
				$iParams = array('call' => 'getInvoiceDetails', 'id' => $invoiceId);
				$thisInvoice = $apiCustom->request($iParams);
				$paymentModule = $thisInvoice['invoice']['payment_module'];
				if($nowCredit > 0.00 && $thisInvoice['invoice']['total'] > 0.00){
					$date = date('Y-m-d H:i:s');
					$nowPayment = $thisInvoice['invoice']['total'];
					if($nowCredit >= $thisInvoice['invoice']['total']){
						$remainingCredit = $nowCredit - $nowPayment;
						$createParams = array('call' => 'accountCreate', 'id' => $acctId);
						$apiCustom->request($createParams);
						$creditOut = $nowPayment;
						$totalNow = '0.00';
						$paidEmail = 'Paid';
						$sendMail = true;
					} else {
						$remainingCredit = '0.00';
						$creditOut = $nowCredit;
						$totalNow = $nowPayment - $nowCredit;
					}
					$admin['id'] = (isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['id'])) ? $_SESSION['AppSettings']['admin_login']['id'] : 0;
					$admin['email'] = (isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['username'])) ? $_SESSION['AppSettings']['admin_login']['username'] : '';

					$db->query("UPDATE hb_client_billing SET credit = '{$remainingCredit}' WHERE client_id = {$clientId}");
					$db->query("INSERT INTO `hb_client_credit_log`(`date`, `client_id`, `in`, `out`, `balance`, `description`, `transaction_id`, `invoice_id`, `admin_id`, `admin_name`) VALUES ('{$date}', '{$clientId}','0.00','{$creditOut}','0.00','Credit applied to invoice','0','{$invoiceId}','{$admin['id']}','{$admin['email']}')");
					$db->query("UPDATE hb_invoices SET credit = '{$creditOut}', total = '{$totalNow}' WHERE id = {$invoiceId}");
				}
			}
		}
	}

	$setParams = array('call' => 'setInvoiceStatus', 'id' => $invoiceId, 'status' => $paidEmail);
	$apiCustom->request($setParams);
	if($sendMail){
		$oAuth->sendMailNew($order_id, 'paidInvoice');
	}
}
unset($_SESSION['SSLORDER']);
unset($_SESSION['SSLITEM']);
unset($_SESSION['SSLSAN']);
unset($_SESSION["WHMCS_ORDER"]);