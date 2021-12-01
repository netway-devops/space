<?php

/**
 *
 * Widget SSL Details
 *
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 *
 */

// include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_download_cert extends HostingWidget {

    protected $description = 'Client download Certificate';
    protected $widgetfullname = "Download Certificate";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) {
    	$accountDetails = $this->getAccountDetails($module);
    	$db = hbm_db();

    	$orderId = $accountDetails['order_id'];

    	if(empty($_GET['type']) || ($_GET['type'] != 'all' && $_GET['type'] != 'crt' && $_GET['type'] != 'ca' && $_GET['type'] != 'pkcs7')){
	    	$template_vars = array('all' => false, 'certificate' => false, 'ca' => false, 'pkcs7' => false);

	    	$getCert = $db->query("SELECT commonname, code_certificate, code_ca, code_pkcs7 FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
	    	if($getCert){
	    		$template_name = 'download_cert.tpl';
	    		$ins = true;
	    		if(class_exists('ZipArchive', false) && ($getCert['code_certificate'] != '' || $getCert['code_ca'] != '' || $getCert['code_pkcs7'] != '')){
	    			$template_vars['all'] = true;
	    			$ins = false;
	    		}

	    		if($getCert['code_certificate'] != ''){
	    			$template_vars['certificate'] = true;
	    			$ins = false;
	    		}

	    		if($getCert['code_ca'] != ''){
	    			$template_vars['ca'] = true;
	    			$ins = false;
	    		}

	    		if($getCert['code_pkcs7'] != ''){
	    			$template_vars['pkcs7'] = true;
	    			$ins = false;
	    		}

	    		if($ins){
	    			$template_name = 'not_working.tpl';
	    		}
    			$template_vars['download_url'] = $_SERVER[REQUEST_URI];
	    	} else {
	    		$template_name = 'not_working.tpl';
	    	}
    	} else if($_GET['type'] == 'all' || $_GET['type'] == 'crt' || $_GET['type'] == 'ca' || $_GET['type'] == 'pkcs7'){
    		$this->downloadCert($_GET['type'], $orderId);
    	} else {
    		$template_name = 'not_working.tpl';
    	}

    	return array($template_name, $template_vars);
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
    	$orderId = $this->getOrderId($accountId);
    	if($orderId){
	    	$db = hbm_db();
	    	$getCert = $db->query("SELECT commonname, code_certificate, code_ca, code_pkcs7 FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
	    	if($getCert && $getCert['commonname'] != '' && ( $getCert['code_certificate'] != '' || $getCert['code_ca'] != '' || $getCert['code_pkcs7'] != '' )){
	    		return true;
	    	}
    	}
    	return false;
    }

    public function getOrderId($accountId)
    {
    	$db = hbm_db();
    	$getOrderId = $db->query("SELECT order_id FROM hb_accounts WHERE id = '{$accountId}'")->fetch();
    	return ($getOrderId) ? $getOrderId['order_id'] : false;
    }

    public function downloadCert($type, $orderId)
    {
    	$db = hbm_db();
    	$getCert = $db->query("SELECT commonname, code_certificate, code_ca, code_pkcs7 FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	if($getCert){
    		$commonname = str_replace('.', '_', $getCert['commonname']);
    		switch($type){
    			case 'crt': $extension = '.crt'; $content = $getCert['code_certificate']; break;
    			case 'ca': $extension = '.ca'; $content = $getCert['code_ca']; break;
    			case 'pkcs7': $extension = '.pkcs7'; $content = $getCert['code_pkcs7']; break;
    			case 'all':
    				$results = $db->query("SELECT code_certificate, code_ca, code_pkcs7 FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    				$contentArray = array();

    				$tmp_file = dirname(__FILE__) . '/../../../../../../uploads/ssl/documents/' . $commonname . '-' . strtotime('now') . '.zip';
    				$zip = new ZipArchive();
    				$zip->open($tmp_file, ZipArchive::CREATE);

    				foreach($results as $k => $v){
    					if($v != ''){
    						$extension = '';
    						switch($k){
    							case 'code_certificate' : $extension = '.crt'; break;
    							case 'code_ca' : $extension = '.ca'; break;
    							case 'code_pkcs7' : $extension = '.p7b'; break;
    						}
    						$zip->addFromString($commonname . $extension, $v);
    					}
    				}
    				$zip->close();

    				header('Content-disposition: attachment; filename=' . $commonname . '.zip');
    				header('Content-Length: ' . filesize($tmp_file));
    				header('Content-type: application/zip');
    				readfile($tmp_file);
    				unlink($tmp_file);
    				exit;
    			default: exit();
    		}

    		header("Content-type: text/plain");
    		header("Content-Disposition: attachment; filename={$commonname}{$extension}");
    		print $content;
    		exit();
    	}
    }
}