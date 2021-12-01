<?php

/*************************************************************
 *
 * rdns_vps Module Class - rDNS for VPS
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * 
 ************************************************************/

// Load Hostbill Api
include_once(APPDIR_MODULES . "Other/rdns_vps/include/api/class.hostbill.api.php");

class rdns_vps_controller extends HBController {
    
    
    /**
     * View rDNS for VPS.
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $request
     * @return json
     */
    public function doViewrDns($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doViewrDns($request));        
        $this->json->show();
   }
   
   
    /**
     * 
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $request
     * @return json
     */
    public function doUpdaterDns($request) {
        $this->loader->component('template/apiresponse', 'json');
        HostbillCommon::singleton()->doUpdaterDns($request);        
        $this->json->show();
   }
    
    
}