<?php

/*************************************************************
 *
 * Hosting Module Class - Symantecvip
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/client-area/
 * 
 ************************************************************/
require_once APPDIR_MODULES . "Hosting/rv_verifylicense/include/common/RVCheckipDao.php";
class rv_verifylicense_controller extends HBController {
    
    protected $moduleName = "rv_verifylicense";
    protected $cpl;
    public function accountdetails($params) {
        
    }
        
    public function view($request) {
    }
	
	public function chkClassCpanelLicense()
	{
		if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing',false))) {
			require_once APPDIR_MODULES . "Hosting/rv_verifylicense/include/cpl-3.6/php/cpl.inc.php";
		}
		
		$serverid = RVCheckipDao::singleton()->getIdServerRvVerifyCpanel();
		if ($serverid != '') {
			$api = new ApiWrapper();
			$aServerDtl = $api->getServerDetails(array('id' => $serverid));
			if (isset($aServerDtl['success']) && $aServerDtl['success'] == 1) {
				$this->cpl = new cPanelLicensing($aServerDtl['server']['username'], $aServerDtl['server']['password']);
			}
		}
	}

	private function get_ip($aParam)
	{
		$res = array();	
		$res['res'] = false;
		foreach ($aParam as $config_cat => $config_id) {
			if (gettype($config_id) == 'string' ) continue;
            $aData = array(
                'id' => $config_cat
            );
			$isIp = RVCheckipDao::singleton()->getNameVariable($aData);
			if ($isIp == true) {
				$getConfigId = array_keys($config_id);
                $ip = $aParam[$config_cat][$getConfigId[0]];
                if(preg_match("/^\d*\.\d*\.\d*\.\d*$/", $ip)) {
                	$res['res'] = true;
					$res['ip'] = $ip;
                }				
			} else {
				$res['msg'] = 'ไม่ใช่ product ที่ต้องการ input IP';
			}
		}
		return $res;
		
	}
	
	public function verify_license_rvskin()
	{
			
	}

  

}