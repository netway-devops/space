<?php

require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class widget_buycpanel_freervskinfreervsitebuilder_license_history extends HostingWidget
{
	protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "License History";
	
	/** 
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) 
    {
    	$reflectionObject = new ReflectionObject($module);
		$property = $reflectionObject->getProperty('account_details');
    	$property->setAccessible(true);
        $aAccountDetails = $property->getValue($module);
		
		$api = new ApiWrapper();
		$params = array(
      		'id'=> $aAccountDetails['order_id']
   		);
   		$aOrderDetails = $api->getOrderDetails($params);
		
		$aAccountDetails['hosting'] = array();
		if (isset($aOrderDetails['details']['hosting'])) {
			$aAccountDetails['hosting'] = $aOrderDetails['details']['hosting'];
		}
		
		$aCondi = array(
        	'acc_id' => $aAccountDetails['id']
        );
		$aLog = RVProductLicenseDao::singleton()->getTransferLog($aCondi);

        return array(
			"buycpanel_freervskinfreervsitebuilder_history.tpl", 
			array(
				'acc_id' => $aAccountDetails['id'],
				'aLog' => $aLog
			)
		);
	}
}
