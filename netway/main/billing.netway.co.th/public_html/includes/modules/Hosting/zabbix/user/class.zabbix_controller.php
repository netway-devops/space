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
		
		// Assing Hidden Value In Templates
        $this->template->assign("accountId", $params["account"]["id"]);
        $this->template->assign("serverId", $params["account"]["server_id"]);
        $this->template->assign("clientId", $params["account"]["client_id"]);
		
	}
		
	
    public function viewTrafficBandwidth($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->viewTrafficBandwidth($request));
        $this->json->show();
    }
    
    
    public function viewUserMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->viewUserMedia($request));
        $this->json->show();
    }
    
    
    public function doDeleteUserMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doDeleteUserMedia($request));
        $this->json->show();
    }
    
    
    public function doAddUserMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doAddUserMedia($request));
        $this->json->show();
    }
    
    
    public function viewPing($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->viewPing($request));
        $this->json->show();
    }
    
    
    public function doActionPing($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doActionPing($request));
        $this->json->show();
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