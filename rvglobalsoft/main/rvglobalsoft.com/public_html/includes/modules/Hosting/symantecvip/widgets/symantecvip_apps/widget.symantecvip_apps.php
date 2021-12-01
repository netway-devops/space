<?php

/**
 * 
 * Widget Symantec VIP View Logs
 * 
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */

require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

class widget_symantecvip_apps extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = 'Apps Management';

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
        
        $accountId = (isset($aAccountDetails["id"])) ? $aAccountDetails["id"] : null;
        $serverId = (isset($aAccountDetails["server_id"])) ? $aAccountDetails["server_id"] : null;
        $clientId = (isset($aAccountDetails["client_id"])) ? $aAccountDetails["client_id"] : null;
        
        
         
        $oAuth =& RvLibs_RvGlobalSoftApi::singleton();
    	$rvapi = $oAuth->request('get', '/vipuserinfo', array( 'action_do' => 'viewlog' ));
    	
		$aLog = (array)$rvapi;
        
        return array(
                               "symantecvip_apps.tpl", 
                               array(
                                   'accountId' => $accountId, 
                                   'serverId' => $serverId,
                                   'aLog' => $aLog
                               )
                      );
    }


}