<?php

require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class buycpanel_freervskinfreervsitebuilder_controller extends HBController
{
	protected $moduleName = "buycpanel_freervskinfreervsitebuilder";
    public $serviceid,$cpl;
	
    public function accountdetails($params) 
    {
    	
    }
        
    public function view($request) 
    {
    	
    }
	
	private function isIPFormat($ip='')
    {
    	if(preg_match("/^\d*\.\d*\.\d*\.\d*$/", $ip)) {
            return true;
        } else {
        	return false;
        }
	}
	
	private function getOldIPbyAcctId($acctID)
	{
		$aGetIp = RVProductLicenseDao::singleton()->getIpByAccountId($acctID);

		if ((count($aGetIp) > 0) && $aGetIp['data']) {
			return $aGetIp['data'];
		} else {
			return null;
		}
	}
	
	private function isHaveTranferLimit($acctID)
	{
		if (RVProductLicenseDao::singleton()->getTransferLimitByAccid(array('acc_id'=>$accid)) < 2) {
			return true;
		} else {
			return false;
		}
	}

	public function changeip($params)
    {
        return $this->response(); // [TODO] ขาด change rvsitebuilder ip
        
		define('RVTRANFER_CPANEL_FREE_RVSKIN', true);
        $aRes = array();
        $this->serviceid = $params['server_id'];
		$acctID = $params['acc_id'];
		$changeTo = $params['to_ip'];
		
		/// BEGIN: Validation
		if ($this->isHaveTranferLimit($acctID) == false) {
			return $this->response(array(
				'res' => false,
				'msg' => "Maximum requests change IP per year.",
			));
		} 
		
		if ($this->isIPFormat($changeTo) === false) {
			return $this->response(array(
				'res' => false,
				'msg' => "IP Address ({$changeTo}) is invalid.",
			));
		} 
		
		$oldIPData = $this->getOldIPbyAcctId($acctID);
		
		if ($oldIPData === null) {
			return $this->response(array(
				'res' => false,
				'msg' => "Not found old IP Address in account id {$acctID}.",
			));
		}
		
		/// BEGIN: Tranfer cPanel License
		require_once APPDIR_MODULES . "/Hosting/rvcpanel_manage2/user/class.rvcpanel_manage2_controller.php";
		require_once APPDIR_MODULES . "/Hosting/rvcpanel_manage2/class.rvcpanel_manage2.php"; 
		$oCpanelManage2 = new rvcpanel_manage2_controller();
		$oCpanelManage2->module = new rvcpanel_manage2();
		$aChangeCpanel = $oCpanelManage2->changeip(array('acc_id' => $acctID,'to_ip' => $changeTo, 'old_ip' => $oldIPData), false, false);
		if (!preg_match('/^success:/', $aChangeCpanel['msg'], $aMatch)) {
			return $this->response(array(
				'res' => $aChangeCpanel['res'],
				'msg' => $aChangeCpanel['msg'],
			));
		}
		
		/// BEGIN: Tranfer RVSkin Licnese
		require_once APPDIR_MODULES . "/Hosting/rvskin_license/user/class.rvskin_license_controller.php";
		require_once APPDIR_MODULES . "/Hosting/rvskin_license/class.rvskin_license.php";
		$oRvskinLicense = new rvskin_license_controller();
		$oRvskinLicense->module = new rvskin_license();
		$aChangeRvskin = $oRvskinLicense->changeip(array('acc_id' => $acctID,'to_ip' => $changeTo, 'old_ip' => $oldIPData), false, false);
		
		
		if (!preg_match('/^success:/', $aChangeRvskin['msg'], $aMatch)) {
			return $this->response(array(
				'res' => $aChangeRvskin['res'],
				'msg' => $aChangeRvskin['msg'],
			));
		}
		
		$resSaveLimit = RVProductLicenseDao::singleton()->InsertTransferLimitByAccid($acctID);
	    $aRes['res'] = true; 
		if ($resSaveLimit == false || (int)$resSaveLimit < 2) {
			$aRes['msg'] = "Your Change IP Request exceeds limitation of {$resSaveLimit}/2 requests per year.";
		} else {
			$aRes['msg'] = 'Your requests change IP is maximum for this year'; 
			$aRes['countLimit'] = 'Your requests change IP is maximum for this year';
		}

		return $this->response($aRes);
		
	}

	private function response($aRes=array())
	{
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
		return true;
	}

	private function printrToString($params)
	{
		ob_start();
		#echo '<pre>';
		print_r($params);
		#echo '</pre>';
		$string = ob_get_contents();
		ob_end_clean();
		return $string;
	}
}