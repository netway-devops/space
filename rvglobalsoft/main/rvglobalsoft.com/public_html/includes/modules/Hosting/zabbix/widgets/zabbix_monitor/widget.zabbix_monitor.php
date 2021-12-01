<?php

/**
 * 
 * Widget Zabbix Monitor
 * 
 */



class widget_zabbix_monitor extends HostingWidget {

    protected $description = 'This is description of widget that will be displayed in adminarea';
    protected $widgetfullname = 'Zabbix Monitor';

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
        $isDisplayFreeMonitor = (HostbillApi::singleton()->isAddonFreeMonitorActive($accountId)) ? "1" : "0";
 
        $outputDiscoveryMedia = HostbillCommon::singleton()->outputDiscoveryMedia($accountId, $serverId);
        
        return array(
                        "zabbix_monitor.tpl", 
                        array(
                            'accountId' => $accountId, 
                            'serverId' => $serverId,
                            'isDisplayFreeMonitor' => $isDisplayFreeMonitor,
                            'stutusFreeMonitor' => HostbillApi::singleton()->getAddonFreeMonitorStatus($accountId),
                            'outputDiscoveryMedia' => $outputDiscoveryMedia
                        )
                    );
    }
    

}