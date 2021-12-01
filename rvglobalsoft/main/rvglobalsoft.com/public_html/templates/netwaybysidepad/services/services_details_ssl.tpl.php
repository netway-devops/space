<?php
require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
$db = hbm_db();
$oAuth =& RvLibs_SSL_PHPLibs::singleton();

if(empty($_GET['widget']) && empty($_GET['wid'])){
	$orderItrmInfo = $db->query("
		SELECT
			so.ssl_id AS ssl_id,
			so.csr AS csr,
			so.commonname AS cname,
			so.symantec_status,
			so.server_type,
			so.custom_techaddress,
			sa.authority_name,
			so.authority_orderid,
			so.order_id,
			so.email_approval,
			so.partner_order_id,
			so.dns_name,
			so.hashing_algorithm,
			so.cert_status,
			i.status AS invoice_status,
			i.id as invoice_id,
			ssla.support_for_san,
			ssla.san_startup_domains,
			so.san_amount,
			so.server_amount
		FROM
			hb_invoice_items AS it,
			hb_orders AS o,
			hb_ssl_order AS so,
			hb_ssl AS ssla,
			hb_ssl_authority AS sa,
			hb_invoices AS i
		WHERE
			it.item_id = :item_id
			AND it.invoice_id = o.invoice_id
			AND o.id = so.order_id
			AND so.ssl_id = ssla.ssl_id
			AND ssla.ssl_authority_id = sa.ssl_authority_id
			AND i.id = it.invoice_id
		",
		array(
			':item_id' => $this->_tpl_vars['service']['id']
		)
	)->fetch();

	$this->_tpl_vars['service']['server_amount'] = ($orderItrmInfo['server_amount'] > 1) ? $orderItrmInfo['server_amount'] : 1;
	if($orderItrmInfo['support_for_san']){
		$dnsName = explode(',', $orderItrmInfo['dns_name']);
		$dnsNameOutput = array();
		foreach($dnsName as $eachName){
			if(trim($eachName) != ''){
				array_push($dnsNameOutput, $eachName);
			}
		}
		$this->assign('totalDomain', 1+count($dnsName));
		if(sizeof($dnsNameOutput) > 0) $this->assign('sanList', $dnsNameOutput);
		$this->assign('supportSan', true);
		$this->assign('sanAmount', $orderItrmInfo['san_amount']);
		$this->assign('sanFirst', $orderItrmInfo['san_startup_domains']);
	} else {
		$this->assign('supportSan', false);
		$this->assign('totalDomain', 1);
	}

	$opt = array(
		'ReturnProductDetail' => True,
		'ReturnCertificateInfo' => True,
		'ReturnFulfillment' => True,
		'ReturnCACerts' => True,
		'ReturnPKCS7Cert' => True,
	);

	if($orderItrmInfo['authority_orderid']){
		$orderInfo = $oAuth->GetOrderByPartnerOrderIdClient($orderItrmInfo['partner_order_id']);
	// 	echo '<pre>'; print_r($orderInfo); echo '</pre>';
		if(isset($orderInfo['CertificateInfo']['EndDate'])){
			$toTime = strtotime($orderInfo['CertificateInfo']['EndDate']);
	// 		if($oAuth->isTestMode()) $toTime-=(60*60*24*365*2);
			if(($toTime-(60*60*24*90)) < strtotime('now')){
				$orderInfo['CertificateInfo']['CanRenew'] = true;
			}
		}
		$this->_tpl_vars['service']['order_info'] = $orderInfo;
	}

	if($orderItrmInfo['csr'] != ''){
		$cQuery = $db->query("SELECT * FROM hb_ssl_order_contact WHERE order_id = {$orderItrmInfo['order_id']}")->fetchAll();
		$contactInfo = array();
		foreach($cQuery as $k => $v){
			switch($v['address_type']){
				case 0: $contactInfo['organize'] = $v; break;
				case 1: $contactInfo['admin'] = $v; break;
				case 2: $contactInfo['tech'] = $v; break;
			}
		}
		$this->assign('contactInfo', $contactInfo);
	}

	$this->_tpl_vars['service']['ssl_id'] = $orderItrmInfo['ssl_id'];
	$this->_tpl_vars['service']['authority_name'] = $orderItrmInfo['authority_name'];
	$this->_tpl_vars['service']['authority_orderid'] = $orderItrmInfo['authority_orderid'];
	$this->_tpl_vars['service']['invoice_id'] = $orderItrmInfo['invoice_id'];
	$this->_tpl_vars['service']['hashing_algorithm'] = $orderItrmInfo['hashing_algorithm'];
	$this->_tpl_vars['service']['cert_status'] = $orderItrmInfo['cert_status'];
	$this->_tpl_vars['service']['country_list'] = $oAuth->countryList();

	switch($orderItrmInfo['authority_name']){
		case 'Thawte':
			$this->_tpl_vars['service']['authority_live_chat'] = 'https://www.thawte.com/chat/chat_intro.html';
			break;
		case 'Rapid SSL':
			$this->_tpl_vars['service']['authority_live_chat'] = 'https://www.rapidssl.com/chat/intro.html';
			break;
		case 'GeoTrust':
			$this->_tpl_vars['service']['authority_live_chat'] = 'https://knowledge.geotrust.com/support/knowledge-base/index?page=chatConsole';
			break;
		case 'Verisign':
			$this->_tpl_vars['service']['authority_live_chat'] = 'https://knowledge.symantec.com/support/ssl-certificates-support/index?page=chatConsole';
			break;
	}


	if ($orderItrmInfo['cname'] != '') {
		$this->_tpl_vars['service']['cname'] = 'for ' . $orderItrmInfo['cname'];
		$this->_tpl_vars['service']['realcname'] = $orderItrmInfo['cname'];
	}

	if ($orderItrmInfo['csr'] == '') {
		//$this->_tpl_vars['service']['cname'] = '(Waitting submit CSR)';
		$this->_tpl_vars['service']['allowsubmitcsr'] = true;
	}

	$aservice = $this->get_template_vars('service');
	$iQuery = $db->query("
			SELECT
				i.status
				, i.id AS invoice_id
			FROM
				hb_invoices AS i
				, hb_invoice_items AS ii
				, hb_accounts AS a
			WHERE
				a.id = :accountId
				AND ii.item_id = a.id
				AND ii.invoice_id = i.id
				ORDER BY ii.id DESC
				LIMIT 0,1
			", array(
					':accountId' => $this->_tpl_vars['service']['id']
			)
	)->fetch();
	$orderItrmInfo['invoice_status'] = ($iQuery) ? $iQuery['status'] : $orderItrmInfo['invoice_status'];
	$this->_tpl_vars['service']['invoice_id'] = ($iQuery && $iQuery['invoice_id'] != '') ? $iQuery['invoice_id'] : $this->_tpl_vars['service']['invoice_id'];
	    if($aservice['status'] == 'Terminated'){
			$this->_tpl_vars['service']['status'] = 'Terminated';
		} else if($orderItrmInfo['invoice_status'] == 'Unpaid' && $this->_tpl_vars['service']['status'] != 'Renewing'){
	        $this->_tpl_vars['service']['status'] = 'Unpaid';
	    }else{
	        if($aservice['status'] == 'Active'){
	            $this->_tpl_vars['service']['status'] = 'Active';
	        }else{
	        	if($aservice['status'] == 'Renewing'){
	        		$this->_tpl_vars['service']['status'] = 'Renewing';
	        		$this->_tpl_vars['service']['renewpayment'] = $orderItrmInfo['invoice_status'];
	        	} else if($aservice['status'] == 'Pending' && $orderItrmInfo['csr'] != '' && $orderItrmInfo['invoice_status'] == 'Paid' && !strpos($orderItrmInfo['symantec_status'],'FAILED') && $orderItrmInfo['symantec_status'] != 'DOMAIN_NOT_PREVETTED'){
	                $this->_tpl_vars['service']['status'] = 'Processing';
	            }else if($aservice['status'] == 'Pending' || $orderItrmInfo['csr'] == '' || strpos($orderItrmInfo['symantec_status'],'FAILED') || $orderItrmInfo['symantec_status'] == 'DOMAIN_NOT_PREVETTED'){
	                $this->_tpl_vars['service']['status'] = 'Incomplete';
	            }else{
	                $this->_tpl_vars['service']['status'] = $aservice['status'];
	            }
	        }
	    }

	$this->_tpl_vars['service']['symantec_status'] = $orderItrmInfo['symantec_status'];
	if($orderItrmInfo['symantec_status'] != 'COMPLETED'){
	    $this->_tpl_vars['service']['next_due'] = 0;
	} else {
		$this->_tpl_vars['service']['csrInfo'] = $oAuth->ParseCSRByValidateOrderParameters($orderItrmInfo['csr'], $orderItrmInfo['ssl_id']);
	}

	$this->_tpl_vars['service']['server_type'] = $orderItrmInfo['server_type'];

	/*หา validation_id*/

	$result = $db->query("
			SELECT
				s.ssl_name
				, s.ssl_validation_id
				, s.ssl_productcode
				, v.validation_name
			FROM
				hb_ssl AS s
				, hb_ssl_validation AS v
			WHERE
				s.ssl_id = {$orderItrmInfo['ssl_id']}
				AND s.ssl_validation_id = v.ssl_validation_id
	                    ")->fetch();
	$this->_tpl_vars['service']['ssl_validation_id'] = $result['ssl_validation_id'];
	$this->_tpl_vars['service']['domain_validation'] = $result['validation_name'];
	$this->_tpl_vars['service']['validationText'] = str_replace('Validation', 'Validation SSL', $result['validation_name']);
	$this->_tpl_vars['service']['ssl_name'] = $result['ssl_name'];
	$this->_tpl_vars['service']['ssl_productcode'] = $result['ssl_productcode'];

	$authorityQuery = $db->query("
			SELECT
				s.ssl_authority_id
			FROM
				hb_ssl AS s
				, hb_ssl_authority AS sa
			WHERE
				s.ssl_id = {$orderItrmInfo['ssl_id']}
				AND s.ssl_authority_id = sa.ssl_authority_id
				AND sa.authority_name = 'Verisign'
	")->fetch();
	if($authorityQuery){
		$this->_tpl_vars['service']['is_symantec'] = true;
	}

	if ($result['ssl_validation_id'] == '1'){
		$this->_tpl_vars['service']['hide_email'] = 0;
	} else {
		$this->_tpl_vars['service']['hide_email'] = 1;
	}

	/*หา phone call*/

	$resultphone = $db->query("
	                        SELECT *
	                        FROM hb_ssl_order_contact
	                        WHERE order_id = {$orderItrmInfo['order_id']}
	                        AND address_type = 1
	                    ")->fetch();
	$this->_tpl_vars['service']['time_verify_from'] = ($resultphone['time_verify_from'] != '') ? date("Y-m-d H:i:s",strtotime(substr($resultphone['time_verify_from'],0,16))) : '';
	$this->_tpl_vars['service']['time_verify_to'] = ($resultphone['time_verify_to'] != '' ) ? date("Y-m-d H:i:s",strtotime(substr($resultphone['time_verify_to'],0,16))) : '';
	$this->_tpl_vars['service']['time_verify_from2'] = ($resultphone['time_verify_from2'] != '') ? date("Y-m-d H:i:s",strtotime(substr($resultphone['time_verify_from2'],0,16))) : '';
	$this->_tpl_vars['service']['time_verify_to2'] = ($resultphone['time_verify_to2'] != '') ? date("Y-m-d H:i:s",strtotime(substr($resultphone['time_verify_to2'],0,16))) : '';
	$this->_tpl_vars['service']['time_zone'] = explode(' ', $resultphone['time_verify_from']);
	$this->_tpl_vars['service']['time_zone2'] = explode(' ', $resultphone['time_verify_from2']);
	$this->_tpl_vars['service']['phonecall_1'] = $resultphone['time_verify_from'];
	$this->_tpl_vars['service']['phonecall_2'] = $resultphone['time_verify_from2'];
	if($orderItrmInfo['csr'] != '') $this->_tpl_vars['service']['downloadCSR'] = true;
	$resultphone['email_approval'] = $orderItrmInfo['email_approval'];
	$this->_tpl_vars['service']['contact'] = $resultphone;

	$this->_tpl_vars['service']['order_id'] = $orderItrmInfo['order_id'];
	switch($this->_tpl_vars['service']['billingcycle']){
		case 'Annually': $this->_tpl_vars['service']['hashing_disabled'] = false; break;
		case 'Biennially':
		case 'Triennially':
				$this->_tpl_vars['service']['hashing_disabled'] = true; break;
	}

	$cancelRequest = $db->query("SELECT * FROM hb_cancel_requests WHERE account_id = {$aservice['id']}")->fetch();
	if($cancelRequest){
		$cancelRequest['date'] = date('d M Y', strtotime($cancelRequest['date']));
		$this->assign('cancelRequest', $cancelRequest);
	}

	if(isset($_GET['action'])){
		$this->assign('pageAction', $_GET['action']);
		switch($_GET['action']){
			case 'reissue':
				if($aservice['status'] == 'Active' && $orderInfo['CertificateInfo']['CertificateStatus'] == 'Active'){
					$reissueEmail = $orderItrmInfo['email_approval'];
					$this->_tpl_vars['service']['email_approval_list'] = $oAuth->GetQuickApproverList($orderItrmInfo['cname']);
					$this->assign('reissue_email', $reissueEmail);
					$this->assign('reissue_action', true);
				}
				break;
			case 'downloadCert':
				$downloadCertPath = APPDIR_MODULES . 'Hosting/ssl/templates/user/download-cert.tpl';
				$this->assign('download_cert_action', true);
				$this->assign('download_cert_path', $downloadCertPath);
				break;

		}
	}
	if(isset($_GET['service'])){
		$systemUrl = $this->get_template_vars('system_url');
		header("Location: {$systemUrl}index.php/clientarea/services/ssl/{$_GET['service']}");
	}

	$this->_tpl_vars['hashing_data'] = $oAuth->generateHashingAlgorithm();
	$this->_tpl_vars['test_mode'] = $oAuth->isTestMode();
}
// echo '<pre>'; print_r($this->_tpl_vars['service']); echo '</pre>';

/*
echo '<pre>';
print_r($this->get_template_vars());
echo '</pre>';
