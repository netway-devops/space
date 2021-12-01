<?php

/*************************************************************
 *
 * Hosting Module Class - Zabbix
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/client-area/
 * 
 ************************************************************/

// Load Hostbill Api
include_once(APPDIR_MODULES . "Hosting/zabbix/include/api/class.hostbill.api.php");

// Load Zabbix Api
include_once(APPDIR_MODULES . "Hosting/zabbix/include/api/class.zabbix.api.php");


class zabbix_controller extends HBController {
	
	public function accountdetails($params) {
		
	}
		
    public function view($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->view($request));
        $this->json->show();
    }
    
    
    public function viewTrafficNetwork($request) {
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->viewTrafficNetwork($request));
        $this->json->show();
    }
    
    
    public function viewDiscovery($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->viewDiscovery($request));
        $this->json->show();
    }
    
    
    public function doViewDiscoveryIp($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doViewDiscoveryIp($request));
        $this->json->show();
    }
    
    
    public function doDiscoveryRule($request) {
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doDiscoveryRule($request));
        $this->json->show();
    }
    
    public function doDiscoveryMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doDiscoveryMedia($request));
        $this->json->show();
    }
    
    public function doTrafficBandwidthGraph($request) {
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doTrafficBandwidthGraph($request));
        $this->json->show();
    }
    
	
}