<?php

/**
 *
 * Widget SSL Details
 *
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 *
 */

// include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class widget_renew extends HostingWidget {

    protected $description = 'Client renew their certificate';
    protected $widgetfullname = "Renew";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return arrayacc
     */
    public function clientFunction(&$module) {
    	$accountDetails = $this->getAccountDetails($module);
    	return array('renew.tpl', $accountDetails);
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
    				, a.next_due
    				, s.is_renewal
    			FROM
    				hb_accounts AS a
    				, hb_ssl_order AS s
    			WHERE
    				a.id = {$accountId}
    				AND a.order_id = s.order_id
    	")->fetch();
    	$due = strtotime($getData['next_due']);
    	$now = strtotime('now');
    	$due -= (60*60*24*90);
    	return ($getData['status'] != 'Pending' && $getData['status'] != 'Renewing' && $due <= $now && !s.is_renewal) ? true : false;
    }

}