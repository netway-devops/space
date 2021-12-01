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
                } else {
                	$res['res'] = false;
                }
				//echo '<pre>';print_r($res);				
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
		
		if (preg_match("/(RVSkin leased|Cpanel License|RVSiteBuilder|RVLogin)/i", $request['tagproductname'], $aMatch) )
		{
			$aRes['status_product_license'] = true;
		
			$aIp = $this->get_ip($request['custom']);
		
			if ($aIp['res'] == false) {
		
				$aRes['formatip'] = false;
				$aRes['res'] = false;
				$aRes['msg'] = $aIp['msg'];
			} else {
				switch($aMatch[0]){
					case 'Cpanel License' : $aRes['main'] = $this->verify_license_cpanel($aIp['ip']);break;
					case 'RVSkin leased' : $aRes['main'] = $this->verify_license_rvskin($aIp['ip']);break;
					case 'RVSiteBuilder' : $aRes['main'] = $this->verify_license_rvsitebuilder($aIp['ip']);break;
					case 'RVLogin' : $aRes['main'] = $this->verify_license_rvlogin($aIp['ip']);break;
				}
				if ($aRes['main']['res'] == false) $aRes['res'] = false;
				// == ตรวจสอบ ของ subproduct
				if (isset($request['subproducts'])) {
					$aProductCpanel = array(63,64,65,68,69);
					$aProductSK = array(70,71);
					$aProductSB = array(66,67);
					$aProductRL = array(108);
					
					foreach ($request['subproducts'] as $productid => $chk) {

						if (in_array($productid, $aProductCpanel)) {
							$aRes['sub'][$productid] 			= $this->verify_license_cpanel($aIp['ip']);
							$aRes['sub'][$productid]['type'] 	= 'cpanel';
						} elseif (in_array($productid, $aProductSK)) {
							$aRes['sub'][$productid] 			= $this->verify_license_rvskin($aIp['ip']);
							$aRes['sub'][$productid]['type'] 	= 'sk';
						} elseif (in_array($productid, $aProductSB)) {
							$aRes['sub'][$productid] 			= $this->verify_license_rvsitebuilder($aIp['ip']);
							$aRes['sub'][$productid]['type'] 	= 'sb';
						} elseif (in_array($productid, $aProductRL)) {
							$aRes['sub'][$productid] 			= $this->verify_license_rvlogin($aIp['ip']);
							$aRes['sub'][$productid]['type'] 	= 'rl';
						}
						
						if ($aRes['sub'][$productid]['res'] == false) $aRes['res'] = false;
					}
					
				}
			}

            if(!$this->check_fraud_ip($aIp['ip'])){
                $aRes['isnotfraud'] = false;
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
		//echo $result;exit;
        // === curl ใช้งานไม่ได้ : ตรวจที่ api ของ manage2.cpanel.net
        if ($_SESSION['Cart'][1]['id'] == '109') 
        {
            $redirect_to = 'cPanel for dedicated server License Transfer + Free RVSkin';
            $redirect_pid = '68';
        }
        elseif ($_SESSION['Cart'][1]['id'] == '111')
        {
            $redirect_to = 'cPanel for VPS server License Transfer + Free RVSkin';
            $redirect_pid = '69';
        } 
        else {
            $redirect_to = 'cPanel for VPS server License Transfer + Free RVSkin';
            $redirect_pid = '69';
        }
        $formsubmit  = '<form name="redirect" action="index.php?/cart/licenses/" method="post">';
        $formsubmit .= '<input name="action" type="hidden" value="add">';
        $formsubmit .= '<input name="id" type="hidden" value="'.$redirect_pid.'">';
        $formsubmit .= '<input name="cycle" type="hidden" value="'.$_SESSION['Cart'][1]['recurring'].'">';
        $formsubmit .= '<input type="submit" value="Make a transfer order" style="font-weight:bold;" class="padded btn"/>';
        $formsubmit .= '</form>';
        
        if (empty($result)) {
        	$this->chkClassCpanelLicense();
            $result  = $this->cpl->fetchLicenseId(array('ip'=>$ip));
            $result = json_decode($result);
            if ($result->status == 0 ) { // 0 = ยังไม่มี license
                $aRes['msg'] = 'This IP is available. The order can be continued..';
                $aRes['res'] = true;
            } else {
            	$aRes['msg'] = "cPanel license for the IP {$ip} is currently active with the another provider!<br />
Please change your order for this IP to \"{$redirect_to}\" with the following button. {$formsubmit}";
                $aRes['res'] = false;
            }
        } elseif (preg_match('/(?:.*?)\s*<b>\s*active\s*<\/b>\s*(?:.*?)\s*/i', $result,$ans,PREG_OFFSET_CAPTURE)) {
            
            //เพิ่มเงื่อนไขในการเช็คว่าเป็น trial ถ้าเป็น trial จะสามารถสั่งซื้อได้ 
            $str1 =  substr($result,0,$ans[0][1]);
            preg_match_all('/(?:.*?)\s*<td align="center">(.*)<\/td>\s*(?:.*?)\s*/i', $str1,$ans2);
            if($ans2[1][2] == '15-DAY-TEST'){
                $aRes['message'] = 'This IP is available. The order can be continued.';
                $aRes['res'] = true; 
            }
            else{
                $aRes['msg'] = '';
                ob_start();
                print_r($_SESSION['Cart'][1]);
                //$aRes['msg'] .= '<pre>'.ob_get_contents().'<pre>';
                ob_end_clean();
                
                $aRes['msg'] .= "cPanel license for the IP {$ip} is currently active with the another provider!<br />
Please change your order for this IP to \"{$redirect_to}\" with the following button. {$formsubmit}";
                $aRes['res'] = false;
            }
        } else {
             $aRes['message'] = 'This IP is available. The order can be continued.';
             $aRes['res'] = true; 
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
		$db = hbm_db();
		$getIP  = $db->query("
                    SELECT 
	            		license_id,hb_acc
	        		FROM 
	            		rvsitebuilder_license
	        		WHERE
	            		primary_ip=:ip
	            		OR secondary_ip  =:ip
                    ", array(
                    ':ip' => $ip
                    ))->fetch();	
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
        	if (isset($product['email']) && $product['email'] != '') {
        		$aRes['res'] 	= false;
            	$aRes['msg'] 	= 'License RVSitebuilder IP:' . $ip . ' already exists in the system (' . $product['email'] . ')';
        	}
        } else { 
        	$aRes['res'] = true;
        } 
        return $aRes;
    	 
       
	}

	public function verify_license_rvskin($ip)
	{
		$res 		= array();
		$res['res'] = false;
		// หา ip 
		$db 	= hbm_db();
		$getIP  = $db->query("
                    SELECT 
	            		license_id,hb_acc,active
	        		FROM 
	            		rvskin_license
	        		WHERE
	            		main_ip=:ip
	            		OR second_ip=:ip 
                    ", array(
                    	':ip' => $ip
                    ))->fetch();
        $aProductPrepertual = array(81, 82, 92, 93, 88, 89);
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
        	// ถ้าเป็น product propertual แล้วเป็น suspend สามารถสั่งซื้อได้
        	// $getIP['active'] = (yes,no,'')
        	if (in_array($product['product_id'], $aProductPrepertual) && $getIP['active'] != 'yes') {
        		$aRes['res'] = true;
        	} else {
        		$aRes['res'] = false;
            	$aRes['msg'] = 'License RVSkin IP:' . $ip . ' already exists in the system (' . $product['email'] . ')';
        	}
        } else {
        	$aRes['res'] = true;
        }
        return $aRes;
	}


    public function check_fraud_ip($ip){
        $db     = hbm_db();
        $getIP  = $db->query("
                    SELECT 
                        id
                    FROM 
                        fraud_server_ip
                    WHERE
                        ip=:ip
                    ", array(
                        ':ip' => $ip
                    ))->fetch();    
        
       
        if(isset($getIP['id'])){
            return false;    
        }
        else if (self::isWhiteListIP($ip)) {
            return true;
        }
        else if (self::isIPinTHAILAND($ip)) {
            return false;
        }
        else{
            return true;      
        }            
        
    }
    
    /**
     * อ้างอิง https://rvglobalsoft.com/public_html/7944web/?cmd=geolocation&action=database
     */
    public function isIPinTHAILAND ($ip)
    {
        $db         = hbm_db();
        
        $ip2Long    = ip2long($ip);
        
        $result     = $db->query("
            SELECT
                *
            FROM
                hb_geo_ip_country
            WHERE
                ip_long_start   <= :ip2Long
                AND ip_long_end   >= :ip2Long
                AND country_code = 'TH'
            ", array(
                ':ip2Long'      => $ip2Long
            ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            return true;
        }
        
        return false;
    }
    
    public function isWhiteListIP ($ip)
    {
        $db         = hbm_db();
        
        $ip2Long    = ip2long($ip);
        
        $result     = $db->query("
            SELECT
                *
            FROM
                hb_geo_ip_country
            WHERE
                ip_start   = :ip2Long
                AND is_whitelist   = 1
            ", array(
                ':ip2Long'      => $ip2Long
            ))->fetch();
        
        if (isset($result['id']) && $result['id']) {
            return true;
        }
        
        return false;
    }
	
	public function verify_license_rvlogin($ip)
	{
		$res = array();
		$res['res'] = false;
		$db = hbm_db();
		$getIP  = $db->query("
			SELECT 
				license_id,hb_acc
			FROM 
				 rvlogin_license
			WHERE
				primary_ip=:ip
				OR secondary_ip  =:ip
		", array(
			':ip' => $ip
  		))->fetch();
		
        if ($getIP) 
        {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
        	if (isset($product['email']) AND $product['email'] != '') 
        	{
        		$aRes['res'] = false;
            	$aRes['msg'] = 'License RVLogin IP: '.$ip.' already exists in the system ('.$product['email'].')';
        	}
        } 
        else 
        { 
        	$aRes['res'] = true;
        } 
        return $aRes;
	}
}

