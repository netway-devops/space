<?php

/**
 * 
 * Widget Symantec VIP View Logs
 * 
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */

require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

class widget_symantecvip_cpanel extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = 'Server Management';

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
    	$rvapi = $oAuth->request('get', '/vipuserinfo', array( 'action_do' => 'get_server_cpanel_list' ));
    	
		$aServer = (array)$rvapi;
        
        return array(
                               "symantecvip_cpanel.tpl", 
                               array(
                                   'aServer' => $aServer
                               )
                      );
    }


}


/*
require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

class widget_symantecvip_viewcpanel extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = "Manage Server";

    
     * HostBill will call this function when widget is visited from clientarea
     * @param HostingModule $module Your provisioning module object
     * @return array
    
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
                               "symantecvip_viewcpanel.tpl", 
                               array(
                                   'accountId' => $accountId, 
                                   'serverId' => $serverId,
                                   'aLog' => $aLog
                               )
                      );
    }


}

*/