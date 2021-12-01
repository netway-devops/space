<?php

/**
 * 
 * Widget Symantec VIP View Logs
 * 
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */

require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class widget_rvsitebuilder_license_transfer extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "Change IP";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) {
        
        $aAdmin         = hbm_logged_admin();
        
        $reflectionObject 	= new ReflectionObject($module);
        $property 			= $reflectionObject->getProperty('account_details');
        $property->setAccessible(true);
        $aAccountDetails 	= $property->getValue($module);
        $aIp 				= RVProductLicenseDao::singleton()->getIpByAccountId($aAccountDetails['id']);
		$aPbIp 				= RVProductLicenseDao::singleton()->getPbIpByAccountId($aAccountDetails['id']);
        
        $displayNone 		= RVProductLicenseDao::singleton()->getTransferLimitByAccid(array('acc_id' => $aAccountDetails['id']));
        if ((int)$displayNone == 2||(int)$displayNone >2) {
            $dis_not_show = false;
        } else {
            $dis_not_show = true;
        }
        
        /* --- ถ้าเป็น Admin สามารถแก้ไขกี่ครั้งก็ได้ --- */
        if (isset($aAdmin['id']) && $aAdmin['id']) {
            $dis_not_show   = true;
        }
        
        return array(
    			"rvsitebuilder_license_transfer.tpl", 
				array(
                   'acc_id' 		=> $aAccountDetails['id'],
                   'server_type' 	=> $aAccountDetails['options']['Server Type'],
                   'frm_ip' 		=> $aIp['data'],
                   'frm_pbip'		=> $aPbIp['data'],
                   'cmd' 			=> 'rvsitebuilder_license',
                   'dis_show' 		=> $dis_not_show
               )
		);
    }
    
    

}