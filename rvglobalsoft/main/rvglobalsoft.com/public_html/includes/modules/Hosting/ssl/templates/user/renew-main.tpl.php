<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
$aAdmin     = hbm_logged_admin();
// --- hostbill helper ---

$template_dir = $this->get_template_vars('template_dir'); // http://hostbill.rvglobalsoft.net/templates/netwaybysidepad/
$template_path = $this->get_template_vars('template_path'); // /home/rvglobal/public_html/templates/netwaybysidepad/
$system_url = $this->get_template_vars('system_url');
require_once($template_path . '../../includes/class.api.custom.php');
$apiCustom  = ApiCustom::singleton($system_url . '7944web/api.php');

$service = $this->get_template_vars('service');

$GLOBALS['apiCustom'] = $apiCustom;
$pid = $service['product_id'];
$orderId = $service['order_id'];
$cyc = $service['billingcycle'];
$domain = $service['domain'];
$sslDiscount = getDiscount($orderId, $cyc);

// service['bililngcycle']
// service['total']

// pprint($apiCustom->request(array('call' => 'addInvoice', 'client_id' => 9819)));

$clientDetail = $apiCustom->request(array('call' => 'getClientDetails', 'id' => $service['client_id']));

$authorityId = $db->query("SELECT ssl_authority_id FROM hb_ssl_authority WHERE authority_name = '{$service['authority_name']}'")->fetch();
$sslDetail = $db->query("SELECT * FROM hb_ssl WHERE ssl_id = {$service['ssl_id']}")->fetch();
$validation = $db->query("SELECT validation_name FROM hb_ssl_validation WHERE ssl_validation_id = {$sslDetail['ssl_validation_id']}")->fetch();
$ssl_order = $db->query("SELECT * FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();

$contactDetail = getContact($orderId);
if($authorityId) $authorityId = $authorityId['ssl_authority_id'];
$sslDetail = generateSSLInformation($sslDetail, $template_dir);

if($sslDetail['support_for_san'] == 'yes'){
	if($ssl_order['dns_name'] != ''){
		$dnsNames = explode(',', $ssl_order['dns_name']);
		if($service['ssl_productcode'] == 'QuickSSLPremium'){
			foreach($dnsNames as $k => $v){
				if(substr($ssl_order['commonname'], 0, 4) == 'www.'){
					$gap = strlen($ssl_order['commonname'])-3;
				} else {
					$gap = strlen($ssl_order['commonname'])+1;
				}
				$dnsNames[$k] = substr($v, 0, -$gap);
			}
		}
		$this->assign('dnsNames', $dnsNames);
		$this->assign('dnsNamesJSON', json_encode($dnsNames));
		$this->assign('sanIncluded', $sslDetail['san_startup_domains']);
		$this->assign('additionalAmount', $ssl_order['san_amount']);
	}
}
$productPrice = getProductPrice($pid, $orderId, $cyc, $sslDiscount);

$this->assign('authorityId', $authorityId);
$this->assign('service', $service);
$this->assign('sslDetail', $sslDetail);
$this->assign('productPrice', $productPrice);
$this->assign('priceListJSON', json_encode($productPrice['summary']));
$this->assign('priceList', $productPrice['summary']);
$this->assign('clientDetail', $clientDetail['client']);
$this->assign('clientDetailJSON', json_encode($clientDetail['client']));
$this->assign('paymentGateway', generatePaymentGateway());
$this->assign('supportSAN', $sslDetail['support_for_san']);
$this->assign('contactDetail', $contactDetail);
$this->assign('contactDetailJSON', json_encode($contactDetail));
$this->assign('validation', $service['domain_validation']);
$this->assign('validation_id', $service['ssl_validation_id']);
$this->assign('csr', $ssl_order['csr']);
$this->assign('email_approval', $ssl_order['email_approval']);
$this->assign('hashing_algorithm', $ssl_order['hashing_algorithm']);
$this->assign('server_type', $ssl_order['server_type']);
$this->assign('price_summary', $productPrice['price_summary']);
$this->assign('price_summary_json', json_encode($productPrice['price_summary']));
$this->assign('ssl_renew_discount', $sslDiscount);
$this->assign('client_credit', getCredit($orderId));
$this->assign('product_id', $pid);


if(isset($_POST) && sizeof($_POST) > 0){
// 	pprint($_POST);
	switch($cyc){
		case 'Annually': $cyc = 'a'; break;
		case 'Biennially': $cyc = 'b'; break;
		case 'Triennially': $cyc = 't'; break;
	}
	makeRenewInvoice($_POST, $service, $system_url, $orderId, $cyc);
}

// $this->assign('step1', base64_encode($firstPage));
// $this->assign('test', $this->get_template_vars('template_path') . "../orderpages/cart_ssl/product_details.tpl");

function getCheckImg($chk, $tempdir)
{
	return ($chk) ? $tempdir . 'images/checked.png' : $tempdir . '/images/non.png';
}

function generateSSLInformation($detail, $tempDir)
{
	$detail['green_addressbar'] = ($detail['green_addressbar']) ? true : false;
	$detail['secure_subdomain'] = ($detail['secure_subdomain']) ? true : false;
	$detail['support_for_san'] = ($detail['support_for_san']) ? true : false;
	$detail['reissue'] = ($detail['reissue']) ? true : false;
	$detail['licensing_multi_server'] = ($detail['licensing_multi_server']) ? true : false;
	$detail['malware_scan'] = ($detail['malware_scan']) ? true : false;
	$detail['secureswww'] = ($detail['secureswww']) ? true : false;

	$detail['validation_img'] = getCheckImg(true, $tempDir);
	$detail['insuance_time_img'] = getCheckImg(true, $tempDir);
	$detail['warranty_img'] = getCheckImg(true, $tempDir);
	$detail['green_addressbar_img'] = getCheckImg($detail['green_addressbar'], $tempDir);
	$detail['secure_subdomain_img'] = getCheckImg($detail['secure_subdomain'], $tempDir);
	$detail['support_for_san_img'] = getCheckImg($detail['support_for_san'], $tempDir);
	$detail['reissue_img'] = getCheckImg($detail['reissue'], $tempDir);
	$detail['licensing_multi_server_img'] = getCheckImg($detail['licensing_multi_server'], $tempDir);
	$detail['malware_scan_img'] = getCheckImg($detail['malware_scan'], $tempDir);
	$detail['secureswww_img'] = getCheckImg($detail['secureswww'], $tempDir);

	return $detail;
}

function pprint($output, $exit = true)
{
	echo '<pre>';
	print_r($output);
	echo '</pre>';
	if($exit) exit;
}

function arrayNumformat($inp)
{
	foreach($inp as $k => $v){
		if(is_array($v)){
			foreach($v as $kk => $vv){
				$output[$k][$kk] = strval(number_format($vv, 2, '.', ','));
			}
		} else {
			$output[$k] = $v;
		}
	}
	return $output;
}

function generatePaymentGateway()
{
	$apiCustom = $GLOBALS['apiCustom'];
	$paymentGateway = $apiCustom->request(array('call' => 'getPaymentModules'));

	if($paymentGateway['success']){
		foreach($paymentGateway['modules'] as $k => $v){
			if($v == 'Credit Card (subscribe)' || $v == 'Credit'){
				unset($paymentGateway['modules'][$k]);
			}
		}
		return $paymentGateway['modules'];
	}
	return false;
}

function getProductPrice($productId, $orderId, $bcyc, $discount = false)
{
	$db = hbm_db();
	$apiCustom = $GLOBALS['apiCustom'];
	$productDetail = $apiCustom->request(array('call' => 'getProductDetails', 'id' => $productId));
	$sanServInfo = $db->query("SELECT san_amount, server_amount FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
// 	pprint($sanServInfo);
	$output = array();
	$summary = array();
	$price_summary = array();

// 	pprint($productDetail);

	$billingCycle = array('a', 'b', 't');
	switch($bcyc){
		case 'Annually' : $bcyc = 'a'; break;
		case 'Biennially' : $bcyc = 'b'; break;
		case 'Triennially' : $bcyc = 't'; break;
	}

	$showPromotionText = false;

	if($productDetail['success']){
		foreach($billingCycle as $cyc){
			if($productDetail['product'][$cyc] > 0){
				$output[$cyc] = $productDetail['product'][$cyc];
				$summary[$cyc]['price'] = $productDetail['product'][$cyc];
				$price_summary[$cyc]['product_price'] = $productDetail['product'][$cyc];
			}
			if($sanServInfo['san_amount'] > 0){
				$productAddon = $apiCustom->request(array('call' => 'getProductApplicableAddons', 'id' => $productId));
				foreach($productAddon['addons']['addons'] as $v){
					if(in_array($productId, explode(',', $v['products']))){
						$addonDetail = $apiCustom->request(array('call' => 'getAddonDetails', 'id' => $v['id']));
						if(isset($output[$cyc])){
							$output[$cyc] += $addonDetail['addon'][$cyc]*$sanServInfo['san_amount'];
							$summary[$cyc]['san'] = $addonDetail['addon'][$cyc];
							$summary[$cyc]['sanSum'] = floatval($addonDetail['addon'][$cyc])*$sanServInfo['san_amount'];
							$price_summary[$cyc]['san_price'] = $addonDetail['addon'][$cyc]*$sanServInfo['san_amount'];
							$price_summary[$cyc]['san_amount'] = $sanServInfo['san_amount'];
						}
						$summary['san_amount'] = $sanServInfo['san_amount'];
					}
				}
			}
			if($sanServInfo['server_amount'] > 1){
				if(isset($output[$cyc])){
					$summary[$cyc]['server'] = $output[$cyc]*($sanServInfo['server_amount']-1);
					$output[$cyc] *= floatval($sanServInfo['server_amount']);
					$price_summary[$cyc]['server_price'] = $summary[$cyc]['server'];
					$price_summary[$cyc]['server_amount'] = $sanServInfo['server_amount']-1;

				}
				$summary['server_amount'] = $sanServInfo['server_amount'];
			}
			$price_summary[$cyc]['total'] = $output[$cyc];
			if($cyc == $bcyc && isset($discount['discount'])){
				$showPromotionText = true;
				$output[$cyc] = $output[$cyc]-$discount['discount'];
			}
		}
	}

	$summary = arrayNumformat($summary);

	if(isset($output['a'])){
		$pText['a'] = strval(number_format($output['a'], 2, '.', ','));
	}
	if(isset($output['b'])){
		$pText['b'] = strval(number_format($output['b'], 2, '.', ','));
		$sText['b'] = ($output['a']*2)-$output['b'];
	}
	if(isset($output['t'])){
		$pText['t'] = strval(number_format($output['t'], 2, '.', ','));
		$sText['t'] = ($output['a']*3)-$output['t'];
	}

	foreach($output as $k => $v){
		switch($k){
			case 'a': $val = '12'; $text = '1 year'; break;
			case 'b': $val = '24'; $text = '2 years'; break;
			case 't': $val = '36'; $text = '3 years'; break;
		}
		$bcolor = ($bcyc == $k) ? '#73c90e' : 'grey';
		$hcolor = ($bcyc == $k) ? '#7ed320' : 'black';
		$chk = ($bcyc == $k) ? 'checked' : '';
		if((empty($price_summary['validity_num']) || empty($price_summary['validity'])) && $bcyc == $k){
			$price_summary['validity'] = $k;
			$price_summary['validity_num'] = $val;
		}

		//$upStyle = (!$showPromotionText && $k == 'a') ? ' margin-top:-19px;' : '';

		$output[$k] = <<<EOF
		<input type="radio" id="price_id_{$val}" class="priceClass" style="display:none;" name="validity_period" value="{$val}" {$chk} />
		<input type="hidden" name="price{$val}" value="{$v}" />
		<label for="price_id_{$val}">
		<div id="priceBox{$val}" name="validity" class="priceBox" style="vertical-align:top; border-radius: 10px; border: 4px solid {$bcolor}; margin-right: 15px; width: 120px;{$upStyle}">
			<p id="priceHead{$val}" align="center" class="priceHead" style="border-radius: 5px 5px 0 0; background-color:{$hcolor}">
				<font color="white">{$text}</font>
			</p>
			<p align="center" style="border-radius: 0 0 5px 5px;" >\${$pText[$k]}</p>
		</div>
EOF;

		$isRecurring = (isset($discount['cyc']) && $k == $discount['cyc']) ? true : false;
		if(isset($sText[$k]) || ($k == 'a' && $k == $discount['cyc'])){
			$fontSize = ($isRecurring) ? 'style="font-size:13px;"' : '';
			$output[$k] .= <<<EOF
			<div align="center" style="margin-right:15px; width: 120px;">
				<font class="priceSave" id="priceSave{$val}" color="{$hcolor}" {$fontSize}>
EOF;
			if($isRecurring && $showPromotionText){
				$output[$k] .= 'Recurring Promotion';
			} else if($k != 'a' && $sText[$k] > 0.00){
				$output[$k] .= "Save \${$sText[$k]}";
			}
			$output[$k] .= <<<EOF
				</font>
			</div>
			</label>
EOF;
		}
	}
	$output['summary'] = $summary;
	$output['price_summary'] = $price_summary;
// 	pprint($price_summary, 1);

	return $output;
}

function getContact($orderId)
{
	$db = hbm_db();
	$qContact = $db->query("SELECT * FROM hb_ssl_order_contact WHERE order_id = {$orderId}")->fetchAll();
	$contact = array();
	foreach($qContact as $v){
		switch($v['address_type']){
			case 0:
				$contact['organization'] = array(
					'name' => $v['organization_name']
					, 'address' => $v['address']
					, 'city' => $v['city']
					, 'state' => $v['state']
					, 'country' => $v['country']
					, 'post_code' => $v['postal_code']
					, 'phone' => $v['phone']
					, 'ext' => $v['ext_number']

				);
				break;
			case 1:
			case 2:
				$key = ($v['address_type'] == 1) ? 'admin' : 'tech';
				$contact[$key] = array(
					'firstname' => $v['firstname']
					, 'lastname' => $v['lastname']
					, 'job' => $v['job']
					, 'phone' => $v['phone']
					, 'email' => $v['email_approval']
					, 'ext' => $v['ext_number']
					, 'organization_name' => $v['organization_name']
					, 'address' => $v['address']
					, 'city' => $v['city']
					, 'state' => $v['state']
					, 'country' => $v['country']
					, 'postal_code' => $v['postal_code']
				);
				break;
		}
	}

	return $contact;
}

function makeRenewInvoice($input, $service, $system_url, $orderId, $main_cyc)
{
	$apiCustom = $GLOBALS['apiCustom'];
    $db         = hbm_db();
    $aAdmin     = hbm_logged_admin();
    $api        = new ApiWrapper();
    
	$pid = $service['product_id'];
	$pCode = $service['ssl_productcode'];

		$dataAccount = $db->query("
						SELECT i.id as invoiceID ,ii.type ,a.id ,i.status as invoiceStatus ,a.order_id,a.total,a.due_day,a.next_due,a.next_invoice
						FROM hb_invoices i 
							LEFT JOIN  hb_invoice_items ii ON i.id=ii.invoice_id 
							LEFT JOIN hb_accounts a ON a.id = ii.item_id
						WHERE a.id = :accountId
							AND ii.type  = 'Hosting'
							AND i.status = 'Unpaid' 
						ORDER BY ii.id DESC
						LIMIT 0,1
						", array(
        					':accountId' => $service['id']
        					
				))->fetch();
				
		if(isset($dataAccount['invoiceID'] )&& $service['slug'] =='ssl'){
			echo '<div class="alert alert-error">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<h4>Error</h4>
				You have an invoice that has not been paid ! <br> 
				<a href =clientarea/invoice/'.$dataAccount['invoiceID'].'">Show your invoice unpaid </a>
				</div>';
			return false;
		}	
		
	foreach($input as $k => $v){
		if(json_decode($v)){
			$input[$k] = json_decode($v, 1);
		}
	}

	$orderSummary = $input['orderSummary'];
	$productPrice = $input['productPriceJSON'];

	switch($input['validity_period']){
		case 12: $cyc = 'a'; break;
		case 24: $cyc = 'b'; break;
		case 36: $cyc = 't'; break;
	}
        
    // bug hostbill addInvoice ทำ curl ไม่ได้
    $addInvoice     = $api->addInvoice(array('client_id'=>$service['client_id']));
    //$addInvoice = $apiCustom->request(array('call' => 'addInvoice', 'client_id' => $service['client_id']));
	
	if($addInvoice['success']){
		$invoiceId = $addInvoice['invoice_id'];

		$pParams = array(
				'call' => 'getProductDetails'
				, 'id' => $pid
		);
		$pDetails = $apiCustom->request($pParams);

		$iParams = array(
				'call' => 'addInvoiceItem',
				'id' => $invoiceId
				, 'line' => 'SSL - ' . $orderSummary['main']['product_name'] . ' ' . $service['domain']
				, 'price' => str_replace(',', '', $orderSummary['main']['price'])
				, 'qty' => 1
				, 'tax' => $pDetails['product']['tax']
		);
		$addInvoiceResponse = $apiCustom->request($iParams);

		if($addInvoiceResponse['success']){
			$db->query("UPDATE hb_invoice_items SET item_id = {$service['id']}, type = 'Hosting' WHERE invoice_id = {$addInvoice['invoice_id']}");
		}

		if(isset($productPrice['san_amount']) && $productPrice['san_amount'] > 0){
			$addonDetail = $db->query("SELECT a.taxable FROM hb_accounts_addons AS aa, hb_addons AS a WHERE aa.account_id = {$service['id']} AND a.id = aa.addon_id")->fetch();
			$iParams = array(
					'call' => 'addInvoiceItem',
					'id' => $invoiceId
					, 'line' => '+ Additional Domain Names x ' . $productPrice['san_amount'] . " Account #{$service['id']}"
					, 'price' => floatval(str_replace(',', '', $productPrice[$cyc]['san']))
					, 'qty' => $productPrice['san_amount']
					, 'tax' => $addonDetail['taxable']
			);
			$addInvoiceResponse = $apiCustom->request($iParams);
			if($addInvoiceResponse['success']){
				$db->query("UPDATE hb_invoice_items SET item_id = {$service['id']} WHERE invoice_id = {$addInvoice['invoice_id']}");
			}
		}

		if(isset($productPrice['server_amount']) && $productPrice['server_amount'] > 1){

			$iParams = array(
					'call' => 'addInvoiceItem',
					'id' => $invoiceId
					, 'line' => '+ Additional Servers x ' . ($productPrice['server_amount']-1) . " Account #{$service['id']}"
					, 'price' => floatval(str_replace(',', '', $productPrice[$cyc]['server']))/($productPrice['server_amount']-1)
					, 'qty' => $productPrice['server_amount']-1
					, 'tax' => $pDetails['product']['tax']
			);
			$addInvoiceResponse = $apiCustom->request($iParams);
			if($addInvoiceResponse['success']){
				$db->query("UPDATE hb_invoice_items SET item_id = {$service['id']} WHERE invoice_id = {$addInvoice['invoice_id']}");
			}
		}

		if($main_cyc == $cyc){
			$discount = getDiscount($orderId, $cyc);
			if($discount){
				$discountParams = array(
						'call' => 'addInvoiceItem'
						, 'id' => $invoiceId
						, 'line' => 'Discount:'
						, 'price' => $discount['discount']*(-1)
						, 'qty' => 1
						, 'tax' => 0
				);
				$discountAdd = $apiCustom->request($discountParams);
			}
		}

		$nowTotal = $apiCustom->request(array('call' => 'getInvoiceDetails', 'id' => $invoiceId));
		if($nowTotal['success']){
			$invoiceTotal = $nowTotal['invoice']['total'];
			$db->query("UPDATE hb_accounts SET total = '{$invoiceTotal}' WHERE order_id = '{$orderId}'");
		}

		$credit = getCredit($orderId);
		$renewNow = false;
		if($credit){
			$invoiceDetail = $apiCustom->request(array('call' => 'getInvoiceDetails', 'id' => $invoiceId));
			if($invoiceDetail['success']){
				$date = date('Y-m-d H:i:s');
				$total = $invoiceDetail['invoice']['total'];
				if($credit >= $total){
					$creditOut = $total;
					$credit -= $total;
					$total = 0.00;
					$setStatus = 'Paid';
					$renewNow = true;
				} else {
					$creditOut = $credit;
					$total -= $credit;
					$credit = 0.00;
					$setStatus = 'Unpaid';
				}
				$admin['id'] = (isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['id'])) ? $_SESSION['AppSettings']['admin_login']['id'] : 0;
				$admin['email'] = (isset($_SESSION['AppSettings']['admin_login']) && isset($_SESSION['AppSettings']['admin_login']['username'])) ? $_SESSION['AppSettings']['admin_login']['username'] : '';
				$db->query("UPDATE hb_client_billing SET credit = '{$credit}' WHERE client_id = {$service['client_id']}");
				$db->query("INSERT INTO `hb_client_credit_log`(`date`, `client_id`, `in`, `out`, `balance`, `description`, `transaction_id`, `invoice_id`, `admin_id`, `admin_name`) VALUES ('{$date}', '{$service['client_id']}','0.00','{$creditOut}','0.00','Credit applied to invoice','0','{$invoiceId}','{$admin['id']}','{$admin['email']}')");
				$db->query("UPDATE hb_invoices SET credit = '{$creditOut}' WHERE id = {$invoiceId}");
				setInvoice($invoiceId, $setStatus);
			}
		} else {
			setInvoice($invoiceId, 'Unpaid');
		}

		$eParams = array(
				'call' => 'editInvoiceDetails'
				, 'id' => $invoiceId
				, 'payment_module' => $input['gateway']
		);

		$editInvoiceDetails = $apiCustom->request($eParams);

		$seParams = array(
				'call' => 'sendInvoice'
				, 'id' => $invoiceId
		);
		$sendInvoice = $apiCustom->request($seParams);

		if($sendInvoice['success']){
			$dnsName = '';
			$cName = '';
			for($i = 0; $i < sizeof($input['sanDomain']); $i++){
				if($pCode == 'QuickSSLPremium'){
					$cQuery = $db->query("SELECT commonname FROM hb_ssl_order WHERE order_id = {$input['orderId']}")->fetch();
					if(substr($cQuery['commonname'], 0, 4) == 'www.'){
						$cQuery['commonname'] = substr($cQuery['commonname'], 4);
					}
					$cName = '.' . $cQuery['commonname'];
				}
				if($input['sanDomain'][$i] != ''){
					$dnsName .= $input['sanDomain'][$i] . $cName;
					if($i != (sizeof($input['sanDomain'])-1)){
						$dnsName .= ',';
					}
				}
			}

			if(substr($dnsName, -1) == ','){
				$dnsName = substr($dnsName, 0, -1);
			}

			if($input["submitCSROption"]){
				$db->query("
						UPDATE
							hb_ssl_order
						SET
							csr = :csr
							, contract = :contract
							, server_type = :server_type
							, hashing_algorithm = :hashing_algorithm
							, dns_name = :dns_name
							, symantec_status = 'WAITING_SUBMIT_ORDER'
							, is_renewal = 1
						WHERE
							order_id = :orderId
						", array(
							':csr' => $input['csr_data']
							, ':contract' => $input['validity_period']
							, ':server_type' => $input['servertype']
							, ':hashing_algorithm' => $input['hashing']
							, ':dns_name' => $dnsName
							, ':orderId' => $input['orderId']
						)
				);

				if(isset($input['email_approval']) && $input['email_approval'] != ''){
					if($service['ssl_validation_id'] != 1){
						$input['email_approval'] = $input['tech']['email'];
					}
					$db->query("UPDATE hb_ssl_order SET email_approval = :email_approval WHERE order_id = :orderId", array(':email_approval' => $input['email_approval'], ':orderId' => $orderId));
				}


				$contactMain = array('admin' => $input['admin'], 'tech' => $input['tech']);
				foreach($contactMain as $typeName => $type){
					$type['organize'] = isset($type['organize']) ? $type['organize'] : '';
					$type['address'] = isset($type['address']) ? $type['address'] : '';
					$type['city'] = isset($type['city']) ? $type['city'] : '';
					$type['state'] = isset($type['state']) ? $type['state'] : '';
					$type['country'] = isset($type['country']) ? $type['country'] : '';
					$type['post_code'] = isset($type['post_code']) ? $type['post_code'] : '';
					$db->query("
							UPDATE
								hb_ssl_order_contact
							SET
								csr_md5 = :csr_md5
								, firstname = :firstname
								, lastname = :lastname
								, organization_name = :organize
								, job = :job
								, address = :address
								, city = :city
								, state = :state
								, country = :country
								, postal_code = :postCode
								, telephone = :phone
								, phone = :phone
								, email_approval = :email_approval
							WHERE
								order_id = :orderId
								AND address_type = :address_type
							", array(
								':csr_md5' => md5($input['csr_data'])
								, ':firstname' => $type['firstname']
								, ':lastname' => $type['lastname']
								, ':organize' => $type['organize']
								, ':job' => $type['job']
								, ':address' => $type['address']
								, ':city' => $type['city']
								, ':state' => $type['state']
								, ':country' => $type['country']
								, ':postCode' => $type['post_code']
								, ':phone' => $type['phone']
								, ':email_approval' => $type['email']
								, ':orderId' => $input['orderId']
								, ':address_type' => ($typeName == 'admin') ? 1 : 2
							)
					);
				}

				if(isset($input['organize'])){
					$db->query("
							UPDATE
								hb_ssl_order_contact
							SET
								csr_md5 = :csr_md5
								, organization_name = :organization_name
								, address = :address
								, city = :city
								, state = :state
								, country = :country
								, postal_code = :postal_code
								, phone = :phone
								, telephone = :phone
							WHERE
								order_id = :orderId
								AND address_type = 0
							", array(
								':csr_md5' => md5($input['csr_data'])
								, ':organization_name' => $input['organize']['name']
								, ':address' => $input['organize']['address']
								, ':city' => $input['organize']['city']
								, ':state' => $input['organize']['state']
								, ':country' => $input['organize']['country']
								, ':postal_code' => $input['organize']['postcode']
								, ':phone' => $input['organize']['phone']
								, ':orderId' => $input['orderId']
							)
					);

				}
			}

			$db->query("
				UPDATE
					hb_ssl_order
				SET
					is_renewal = 1
					, symantec_status = 'WAITING_SUBMIT_ORDER'
				WHERE
					order_id = :orderId
				", array(
					':orderId' => $input['orderId']
				)
			);
			$apiCustom->request(array('call' => 'editAccountDetails', 'id' => $service['id'], 'status' => 'Renewing'));
		}

		if($renewNow){
			$oQuery = $db->query("
    			SELECT
    				DISTINCT so.is_renewal
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
			if($oQuery && $oQuery['is_renewal']){
				$apiCustom->request(array('call' => 'accountCreate', 'id' => $service['id']));
			}
		} else {
			header("Location: {$system_url}clientarea/invoice/{$invoiceId}");
		}
	}

}

function setInvoice($invoiceId, $status)
{
	$apiCustom = $GLOBALS['apiCustom'];
	$sParams = array(
			'call' => 'setInvoiceStatus'
			, 'id' => $invoiceId
			, 'status' => $status
	);
	return $apiCustom->request($sParams);
}

function getDiscount($orderId, $billingCycle)
{
	$db = hbm_db();
	$apiCustom = $GLOBALS['apiCustom'];
	$discount = $db->query("SELECT discount FROM hb_coupons_log WHERE order_id = '{$orderId}'")->fetch();
	$discount = $discount['discount'];
	if($discount){
		$account = $db->query("SELECT product_id, firstpayment FROM hb_accounts WHERE order_id = '{$orderId}'")->fetch();
		$total = $account['firstpayment'];
		$pid = $account['product_id'];
		switch($billingCycle){
			case 'Annually': $cyc = 'a'; break;
			case 'Biennially': $cyc = 'b'; break;
			case 'Triennially': $cyc = 't'; break;
			default: $cyc = $billingCycle;
		}
		$productPrice = $db->query("SELECT a, b, t FROM hb_common WHERE id = '{$pid}' AND rel = 'Product'")->fetch();
		$productPrice = $productPrice[$cyc];
		$discountPrice = number_format($productPrice-$discount, '2', '.', '');
		if($total == $discountPrice){
			$result = array('discount' => $discount, 'cyc' => $cyc);
			return $result;
		}
	}
	return false;
}

function getCredit($orderId)
{
	$db = hbm_db();
	$clientId = $db->query("
	        			SELECT
	        				usr_id
	        			FROM
	        				hb_ssl_order
	        			WHERE
	        				order_id = :orderId
	        		", array(
        				':orderId' => $orderId
	        		)
	)->fetch();
	if($clientId){
		$clientId = $clientId['usr_id'];
		$clientCredit = $db->query("SELECT credit FROM hb_client_billing WHERE client_id = '{$clientId}'")->fetch();
		if($clientCredit && $clientCredit['credit'] > 0){
			return $clientCredit['credit'];
		}
	}
	return false;
}

?>
