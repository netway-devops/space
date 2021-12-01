<?php

/**
 * 
 * Widget Symantec VIP View Logs
 * 
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */

require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class widget_rvsitebuilder_license_history extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "License History";

    /**
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
     */
    public function clientFunction(&$module) {
        $reflectionObject = new ReflectionObject($module);
        $property = $reflectionObject->getProperty('account_details');
        $property->setAccessible(true);
        $aAccountDetails = $property->getValue($module);
        $aCondi = array(
        'acc_id' => $aAccountDetails['id']
        );
        $aLog = RVProductLicenseDao::singleton()->getTransferLog($aCondi);
       //echo '<pre>';print_r($aLog);
        return array(
                               "history.tpl", 
                               array(
                                   'acc_id' => $aAccountDetails['id'],
                                   'aLog' => $aLog
                               )
                      );
    }
    
    

}