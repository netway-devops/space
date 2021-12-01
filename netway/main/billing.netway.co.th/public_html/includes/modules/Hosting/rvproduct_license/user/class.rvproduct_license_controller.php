<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvproduct_license_controller extends HBController 
{
	protected $moduleName = 'rvproduct_license';
	public $module;
	public $cpl;
	public function view($request) 
	{
	
	}
	
	public function accountdetails($params) 
	{
		$db	= hbm_db();
		
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
			$isIp = RVProductLicenseDao::singleton()->getNameVariable($aData);
			if ($isIp == true) {
				$getConfigId = array_keys($config_id);
                $ip = $aParam[$config_cat][$getConfigId[0]];
                if (preg_match("/^\d*\.\d*\.\d*\.\d*$/", $ip)) {
                	$res['res'] = true;
					$res['ip'] = $ip;
                }				
			} else {
				$res['msg'] = 'ไม่ใช่ product ที่ต้องการ input IP';
			}
		}
		return $res;
	}
	
	public function verify_license($request)
	{
		$aRes = array();
		$aRes['status_product_license'] = false;
		$aRes['res'] = true;
		$aIp = $this->get_ip($request['custom']);
		if ($aIp['res'] == false) {
			$aRes['formatip'] = false;
			$aRes['msg'] = $aIp['msg'];
		} else {
			if (preg_match("/(RVSkin leased|Cpanel License|RVSiteBuilder)/i", $request['tagproductname'], $aMatch) ){
				$aRes['status_product_license'] = true;
				switch($aMatch[0]){
					case 'Cpanel License' : $aRes['main'] = $this->verify_license_cpanel($aIp['ip']);break;
					case 'RVSkin leased' : $aRes['main'] = $this->verify_license_rvskin($aIp['ip']);break;
					case 'RVSiteBuilder' : $aRes['main'] = $this->verify_license_rvsitebuilder($aIp['ip']);break;
				}
					if ($aRes['main']['res'] == false) $aRes['res'] = false;
				// == ตรวจสอบ ของ subproduct
				if (isset($request['subproducts'])) {
					$aProductCpanel = array(63,64,65,68,69);
					$aProductSK = array(70,71);
					$aProductSB = array(66,67);
					foreach ($request['subproducts'] as $productid => $chk) {
						if (in_array($productid, $aProductCpanel)) {
							$aRes['sub'][$productid] = $this->verify_license_cpanel($aIp['ip']);
							$aRes['sub'][$productid]['type'] = 'cpanel';
						} elseif (in_array($productid, $aProductSK)) {
							$aRes['sub'][$productid] = $this->verify_license_rvskin($aIp['ip']);
							$aRes['sub'][$productid]['type'] = 'sk';
						} elseif (in_array($productid, $aProductSB)) {
							$aRes['sub'][$productid] = $this->verify_license_rvsitebuilder($aIp['ip']);
							$aRes['sub'][$productid]['type'] = 'sb';
						}
						if ($aRes['sub'][$productid]['res'] == false) $aRes['res'] = false;
					}
					
				}
			}
		}
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
	}

	public function verify_license_cpanel($ip)
   	{
		$urlRequest = 'http://verify.cpanel.net/index.cgi?ip=' . $ip;
        $aRes = array();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'http://www.rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result = curl_exec($ch);
        curl_close($ch);
		//echo $result;
        // === curl ใช้งานไม่ได้ : ตรวจที่ api ของ manage2.cpanel.net
        if (empty($result)) {
        	$this->chkClassCpanelLicense();
            $result  = $this->cpl->fetchLicenseId(array('ip'=>$ip));
            $result = json_decode($result);
            if ($result->status == 0 ) { // 0 = ยังไม่มี license
                $aRes['msg'] = 'ip ok ใช้ได้ ตรวจจาก mange2.cpanel.net';
                $aRes['res'] = true;
            } else {
            	$aRes['msg'] = 'Cpanel IP already exists in thesystem.';
                $aRes['res'] = false;
            }
        } elseif (preg_match('/Not licensed/i', $result)) {
			$aRes['msg'] = 'ip ok ใช้ได้ ตรวจจาก verify.cpanel.net';
			$aRes['res'] = true;
        } else {
			$aRes['msg'] = 'License Cpanel IP:'.$ip.' already exists in thesystem.';
			$aRes['res'] = false;
        }
		if ($aRes['res'] == false) {
	 		$aData = array('name'=>'Cpanel for dedicated server License Transfer');
			$aRes['product_dedicated_id']= RVProductLicenseDao::singleton()->getProductTransfer($aData);
			$aData = array('name'=>'Cpanel for VPS server License Transfer');
			$aRes['product_vps_id']= RVProductLicenseDao::singleton()->getProductTransfer($aData);
		}
        return $aRes;
	}

	public function chkClassCpanelLicense()
    {
        if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing', false))) {
            require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/cpl-3.6/php/cpl.inc.php";
        }
		$aConfigs       = $this->module->aCpanel;
        if (isset($aServerDtl['success']) && $aServerDtl['success'] == 1) {
            $this->cpl = new cPanelLicensing($aConfigs['user'], $aConfigs['pwd']);
        }
       // $this->cpl = new cPanelLicensing($this->server_username, $this->server_password);
	}
   	
   	public function verify_license_rvsitebuilder($ip)
	{
		$res = array();
		$res['res'] = false;
			
		$aConfigs       = $this->module->aDBSB;
		
        try {
            $connsb = new PDO ("mysql:host=" . $aConfigs['host'] . ";dbname=" . $aConfigs['dbname'], $aConfigs['user'], $aConfigs['pwd']);
        } catch (PDOException $e) {
            $res['msg'] = $e->getMessage();
            return $res;
        }
		$sql = "
			SELECT 
	            license_id,hb_acc
	        FROM 
	             rv_license
	        WHERE
	            primary_ip='" . $ip . "'
		";
		$getIP = $connsb->query($sql)->fetch();
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
        	if (isset($product['email']) && $product['email'] != '') {
        		$aRes['res'] = false;
				//$aRes['mail'] = $product['email'];
            	$aRes['msg'] = 'License RVSitebuilder IP:' . $ip . ' already exists in thesystem (' . $product['email'] . ')';
        	}
        } else { 
        	$aRes['res'] = true;
        } 
        return $aRes;
    	 
       
	}
	public function verify_license_rvskin($ip)
	{
		$res = array();
		$res['res'] = false;
			
		$aConfigs       = $this->module->aDBSK;
		
        try {
            $connskin = new PDO ("mysql:host=" . $aConfigs['host'] . ";dbname=" . $aConfigs['dbname'], $aConfigs['user'], $aConfigs['pwd']);
        } catch (PDOException $e) {
            $res['msg'] = $e->getMessage();
            return $res;
        }
		$sql = "
			SELECT 
	            license_id,hb_acc,active
	        FROM 
	            license_user
	        WHERE
	            main_ip='" . $ip . "'
	            OR second_ip='" . $ip . "' 
		";
		$getIP = $connskin->query($sql)->fetch();
        $aProductPrepertual = array(81, 82);
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
        	// ถ้าเป็น product propertual แล้วเป็น suspend สามารถสั่งซื้อได้
        	// $getIP['active'] = (yes,no,'')
        	if (in_array($product['product_id'], $aProductPrepertual) && $getIP['active'] != 'yes') {
        		$aRes['res'] = true;
        	} else {
        		$aRes['res'] = false;
            	$aRes['msg'] = 'License RVSkin IP:' . $ip . ' already exists in thesystem (' . $product['email'] . ')';
        	}
        } else {
        	$aRes['res'] = true;
        } 
        return $aRes;
	}
}

