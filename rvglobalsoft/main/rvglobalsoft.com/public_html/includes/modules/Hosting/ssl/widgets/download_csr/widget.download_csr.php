<?php

/**
 *
 * Widget SSL Details
 *
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 *
 */

// include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_download_csr extends HostingWidget {

    protected $description = 'Client download CSR';
    protected $widgetfullname = "Download CSR";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) {
    	$accountDetails = $this->getAccountDetails($module);
    	$orderId = $accountDetails['order_id'];
    	$db = hbm_db();
    	$results =  $db->query("SELECT csr , commonname FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	$results['commonname'] = str_replace('.', '_', $results['commonname']);

    	header("Content-type: text/plain");
    	header("Content-Disposition: attachment; filename={$results['commonname']}.csr");
    	print $results['csr'];
    	exit();
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
	    	$getCSR = $db->query("SELECT csr FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
	    	if($getCSR && $getCSR['csr'] != ''){
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
}