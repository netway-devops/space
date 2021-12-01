<?php

/*************************************************************
 *
 * Hosting Module Class - Netway Common
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * @test
 * 
 * itvarieties.com
 * https://netway.co.th/7944web/index.php?cmd=accounts&action=edit&id=667&list=all
 * https://netway.co.th/clientarea/domains/3324/itvarieties.com/&widget=contactinfo&wid=31#contactinfo
 * https://netway.co.th/clientarea/domains/3324/itvarieties.com/&widget=nameservers#nameservers
 * 
 * aec1.net
 * https://netway.co.th/7944web/index.php?cmd=domains&action=edit&id=3345
 * https://netway.co.th/clientarea/domains/3345/aec1.net/&widget=contactinfo&wid=50#contactinfo
 * 
 * thairadio.com
 * 
 * 
 * on billing || ecomsupply
 * https://billing.siaminterhost.com/?page=account/dom_acc
 * https://billing.siaminterhost.com/?page=account/google_apps_code&domain_id=11213
 * https://billing.siaminterhost.com/?page=account/dom_forwarding
 * 
 * http://192.168.1.192/phpMyAdmin/index.php?db=ecomsupp_mlm&token=b435969d8ea55817ad5c6064696544af
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
        } else if ($request['subaction'] == 'doUpdateContactInfo') {
        	HostbillCommon::singleton()->doUpdateContactInfo($request);
        } else if ($request['subaction'] == 'doModifyNameServer') { 
            HostbillCommon::singleton()->doModifyNameServer($request);
        } else if ($request['subaction'] == 'doDomainForwarding') { 
            HostbillCommon::singleton()->doDomainForwarding($request);
        } else if ($request['subaction'] == 'doDomainGoogleCode') {
        	HostbillCommon::singleton()->doDomainGoogleCode($request);
        } else if ($request['subaction'] == 'doDomainForwardingDelete') {
            HostbillCommon::singleton()->doDomainForwardingDelete($request);
        } else {
        	// Etc.        	
        }
        
        $this->json->show();
   }
    
   public function setWebpackVersion(){
       
       require_once(APPDIR . 'class.config.custom.php');
       
       $webpackVersion    = ConfigCustom::singleton()->setValue('webpackVersion',date('YmdHis'));
       $webpackVersion    = ConfigCustom::singleton()->getValue('webpackVersion');
       
       $this->loader->component('template/apiresponse', 'json');
       $this->json->assign("aResponse", array(
                                            'status'    =>  200 ,
                                            'data'      =>  $webpackVersion ,
                                            'msg'       =>  'OK.'
                                            ));
       $this->json->show();
       
   } 

    
}