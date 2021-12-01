<?php

/**
 * 
 * Widget Zabbix Monitor
 * 
 */



class widget_zabbix_monitor extends HostingWidget {

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
        
        return array(
                        "zabbix_monitor.tpl", 
                        array(
                            'accountId' => $accountId, 
                            'serverId' => $serverId,
                            'clientId' => $clientId
                        )
                    );
                    
    }
    

}