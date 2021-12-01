<?php

/**
 *
 * Widget SSL Details
 *
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 *
 */

// include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_revoke extends HostingWidget {

    protected $description = 'Client revoke their certificate';
    protected $widgetfullname = "Revoke";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return arrayacc
     */
    public function clientFunction(&$module) {
    	$accountDetails = $this->getAccountDetails($module);
    	return array('revoke.tpl', $accountDetails);
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
    	return ($getData['status'] == 'Active' || $getData['status'] == 'Renewing') ? true : false;
    }
}