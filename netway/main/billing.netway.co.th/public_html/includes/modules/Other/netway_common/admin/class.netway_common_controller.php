<?php

/*************************************************************
 *
 * Hosting Module Class - Netway Common
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * 
 ************************************************************/

// Load Hostbill Api
include_once(APPDIR_MODULES . "Other/netway_common/include/api/class.hostbill.api.php");

class netway_common_controller extends HBController {
    
    
    /**
     * 
     * Enter description here ...
     * @param $request
     */
    public function view($request) {
        
    }
    
    /**
     * Domain actions and verify subaction to process.
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     * @return json
     */
    public function domain($request) {
        
        $this->loader->component('template/apiresponse', 'json');
        
        if ($request['subaction'] == 'doViewDomain') {
            $this->json->assign("aResponse", HostbillCommon::singleton()->doViewDomain($request));
        } else {
            // Etc.         
        }
        
        $this->json->show();
   }
    
}