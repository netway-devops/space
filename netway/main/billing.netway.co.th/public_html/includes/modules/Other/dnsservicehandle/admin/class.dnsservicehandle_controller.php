<?php
#@LICENSE@#

class dnsservicehandle_controller extends HBController 
{
	protected $moduleName = 'dnsservicehandle';
	
	public function view($request) 
	{
	
	}
	
	public function addPark($request){
		
		require_once(APPDIR . 'class.general.custom.php');
	    require_once(APPDIR . 'class.api.custom.php');
	       
	    $adminUrl = GeneralCustom::singleton()->getAdminUrl();
	    $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
	     
	    $post = array(
	           'call' 		=> 'module',
	           'module' 	=> 'dnsservicehandle',
	           'fn' 		=> 'addDNSZoneSkipVerifyNs',
	           'domainName' => $request['domainName'] ,
	           'domainID'	=> $request['domainID'] ,
	           'do'			=> 'Button: Add park DNS zone'
	    );
		
	    $aRes = $apiCustom->request($post);
		
		
		$this->loader->component('template/apiresponse', 'json');
		        $this->json->assign("aResponse", array(
		                                        'data' 	=> $aRes['isValid'],
		                                        'msg'	=> $aRes['resError']
		                                        ));
        $this->json->show();
		
	}
	
}
