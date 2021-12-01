<?php

require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class widget_buycpanel_freervskin_license_transfer extends HostingWidget
{
	protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "Change IP";
	
	 /** 
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) 
    {
        $aAdmin         = hbm_logged_admin();
        
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
		
		$aIp = RVProductLicenseDao::singleton()->getIpByAccountId($aAccountDetails['id']);
		
		$displayNone = RVProductLicenseDao::singleton()->getTransferLimitByAccid(array('acc_id'=>$aAccountDetails['id']));
        if ((int)$displayNone >= 2) {
            $dis_not_show = false;
        } else {
            $dis_not_show = true;
        }
        
        /* --- ถ้าเป็น Admin สามารถแก้ไขกี่ครั้งก็ได้ --- */
        if (isset($aAdmin['id']) && $aAdmin['id']) {
            $dis_not_show   = true;
        }
        
        return array(
			"buycpanel_freervskin_transfer.tpl"
			, array(
				'acc_id' => $aAccountDetails['id'],
				'frm_ip' => $aIp['data'],
				'cmd' => 'buycpanel_freervskin',
				'server_id' => $aAccountDetails['server_id'],
				'dis_show' => $dis_not_show
			)
		);
    }
}
