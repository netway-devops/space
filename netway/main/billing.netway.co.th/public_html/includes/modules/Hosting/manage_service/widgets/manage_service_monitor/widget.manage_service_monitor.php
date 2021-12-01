<?php

/**
 * 
 * Widget Manage Service Apache
 * 
 * @auther Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
 * @reference
 * http://schlitt.info/opensource/blog/0581_reflecting_private_properties.html
 * 
 */


class widget_manage_service_monitor extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = 'Monitor';

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
        
        
        
        /*
        [modules] => Array
        (
            [112] => Array
                (
                    [account_id] => 3529
                    [module_id] => 112
                    [server_id] => 111
                    [status] => Pending
                    [username] => xen4
                    [password] => $K9gxU|$u?
                    [rootpassword] => $K9gxU|$u?
                    [extra_details] => 
                    [module] => 112
                    [modname] => Manage Service
                    [options] => 
                )

        )
        */
                        
        return array(
                               "manage_service_monitor.tpl", 
                               array(
                                   'accountId' => $accountId, 
                                   'serverId' => $serverId,
                                   'clientId' => $clientId
                               )
                      );
    }


}