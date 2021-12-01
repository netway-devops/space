<?php

/**
 *
 * Widget SSL Details
 *
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 *
 */

// include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_reissue extends HostingWidget {

    protected $description = 'Client reissue their certificate';
    protected $widgetfullname = "Reissue";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return arrayacc
     */
    public function clientFunction(&$module) {
    	$db = hbm_db();
    	$template_vars = array();
    	$accountDetails = $this->getAccountDetails($module);
    	$orderId = $accountDetails['order_id'];
    	$template_vars['order_id'] = $orderId;
    	$domain = $accountDetails['domain'];
    	$template_vars['domain'] = $accountDetails['domain'];
    	$template_vars['form_url'] = $_SERVER[REQUEST_URI];
    	$template_vars['hashing_data'] = $this->getHashingAlgorithm();
    	$nowHashing = $db->query("SELECT hashing_algorithm FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	$template_vars['hashing_algorithm'] = $nowHashing["hashing_algorithm"];

    	$partnerOrderId = $this->getPartnerOrderId($orderId);

    	$productId = $accountDetails['product_id'];

    	$get_validation = $db->query("SELECT s.ssl_validation_id, s.ssl_productcode, s.support_for_san FROM hb_products AS p, hb_ssl AS s WHERE p.id = '{$productId}' AND p.name = s.ssl_name")->fetch();
    	$template_vars['productcode'] = $get_validation['ssl_productcode'];
    	if($get_validation['ssl_validation_id'] == 1 || $get_validation['ssl_productcode'] == 'TrueBizIDEV'){
    		$template_vars['validation'] = $get_validation['ssl_validation_id'];
    		$emailApprove = $db->query("SELECT email_approval FROM hb_ssl_order WHERE order_id = '{$accountDetails['order_id']}'")->fetch();
    		if($emailApprove){
    			$template_vars['reissue_email'] = $emailApprove['email_approval'];
    		}
    	}


    	$manageDNS = array();
    	if($get_validation['support_for_san']){
    		$qDnsName = $db->query("SELECT dns_name FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    		if(trim($qDnsName['dns_name']) != ''){
	    		$template_vars['dnsNames'] = explode(',', $qDnsName['dns_name']);
	    		$mergeDomain = '';
	    		if($get_validation['ssl_productcode'] == 'QuickSSLPremium'){
	    			$template_vars['quickpremiumdomain'] = (substr($template_vars['domain'], 0, 4) == 'www.') ? substr($template_vars['domain'], 4) : $template_vars['domain'];

	 				foreach($template_vars['dnsNames'] as $key => $val){
	    				$template_vars['dnsNames'][$key] = str_replace('.' . $template_vars['quickpremiumdomain'], '', $val);
	    			}

	    			$template_vars['dnsNames_quicksslpremium'] = true;
	    			$mergeDomain = '.' . $template_vars['quickpremiumdomain'];
	    		}
	    		if(isset($_POST['dns']) && count($_POST['dns']) > 0){
	    			$manageDNS = $this->mergeSAN($_POST['dns'], $template_vars['dnsNames'], $mergeDomain);
	    		}

		    	$template_vars['resetDNS'] = $template_vars['dnsNames'];
    		}
    	}

    	$getCertStatus = $this->getCertStatus($partnerOrderId);

    	$template_vars['reissuing'] = ($getCertStatus == 'PENDING_REISSUE') ? true : false;

    	// DO REISSUE
    	if(isset($_POST['order_id']) && $_POST['order_id'] != '' && isset($_POST['csr_data']) && $_POST['csr_data'] != ''){
    		$template_vars['csr'] = $_POST['csr_data'];
    		$template_vars['dnsNames'] = $_POST['dns'];
    		$template_vars["hashing_algorithm"] = $_POST["hashing"];
    		$reissueOutput = $this->reissue($_POST['order_id'], $_POST['csr_data'], $_POST["hashing"], $manageDNS);
    		if($reissueOutput['status']){
    			$template_vars['reissue_success'] = true;
    		} else if(!$reissueOutput['status'] && isset($reissueOutput['error'])){
    			$field = $reissueOutput['error'][0]['ErrorField'];
    			if($field == 'PartnerOrderID'){
    				$field = 'Reissue';
    			}
    			$template_vars['reissue_error'] = $field . ' failed: ' . $reissueOutput['error'][0]['ErrorMessage'];
    		}
    	} else if(isset($_POST['resend_email'])){
    		$resendOutput = $this->resendEmail($_POST['order_id']);
    		if($resendOutput['status']){
    			$template_vars['resend_success'] = true;
    		} else {
    			$template_vars['resend_error'] = $resendOutput['errorMessage'];
    		}
    	}
    	// END REISSUE

    	return array('reissue.tpl', $template_vars);
    }

    private function getAccountDetails($module)
    {
    	$reflectionObject = new ReflectionObject($module);
    	$property = $reflectionObject->getProperty('account_details');
    	$property->setAccessible(true);
    	$aAccountDetails = $property->getValue($module);
    	return $aAccountDetails;
    }

    public function widgetActive($accountId)
    {
    	$db = hbm_db();
    	$getData = $db->query("
    			SELECT
    				s.symantec_status
    				, a.status
    				, s.cert_status
    			FROM
    				hb_accounts AS a
    				, hb_ssl_order AS s
    			WHERE
    				a.id = {$accountId}
    				AND a.order_id = s.order_id
    	")->fetch();
    	return (($getData['status'] == 'Active' || $getData['status'] == 'Renewing')) ? true : false;
    }

    public function reissue($orderId, $csr, $hashing, $manageDNS)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$db = hbm_db();

	    $response = $oAuth->reissue($orderId, $csr, $hashing, $manageDNS);

    	return $response;
    }

    public function getHashingAlgorithm()
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	return $oAuth->generateHashingAlgorithm();
    }

    public function resendEmail($orderId)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$response = $oAuth->resendEmail($orderId, 'ApproverEmail');
    	return $response;
    }

    public function getPartnerOrderId($orderId)
    {
    	$db = hbm_db();
    	$aData = $db->query("SELECT partner_order_id FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	return $aData['partner_order_id'];
    }

    public function getCertStatus($partnerOrderId)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	return $oAuth->getCertStatus($partnerOrderId);
    }

    public function getValidation($orderId)
    {
    	$db = hbm_db();
    	$aQuery = $db->query("
    			SELECT

    			FROM
    				hb_accounts AS a
    			WHERE
    				a.order_id = {$orderId}
    				AND a.product_id = 'a'
    	")->fetch();
    }

    public function mergeSAN($edit, $main, $specialDomain)
    {
    	$mergeData = array();
    	foreach($edit as $eachEdit){
    		if(in_array($eachEdit, $main)){
    			unset($main[array_search($eachEdit, $main)]);
    			unset($edit[array_search($eachEdit, $edit)]);
    		}
    	}
    	foreach($edit as $eEdit){
    		foreach($main as $key => $eMain){
    			$mergeData['edit'][] = array('from' => $eMain . $specialDomain, 'to' => $eEdit . $specialDomain);
    			unset($main[$key]);
    			break;
    		}
    	}
    	return $mergeData;
    }
}