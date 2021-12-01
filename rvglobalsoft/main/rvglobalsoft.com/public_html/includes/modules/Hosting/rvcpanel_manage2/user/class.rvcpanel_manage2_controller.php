<?php

/*************************************************************
 *
 * Hosting Module Class - Symantecvip
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/client-area/
 * 
 ************************************************************/
require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvcpanel_manage2_controller extends HBController {
    
    protected $moduleName = "rvcpanel_manage2";
    public $serviceid,$cpl;
    public function accountdetails($params) {
    }
        
    public function view($request) {
    }
    
    
    /****************************************
     * return boolean 
     * : true แสดงว่าใช้ได้
     * : false แสดงว่ามีใช้แล้ว ใช้ไม่ได้
     * 
     ****************************************/
    public function check_cpanel_license($ip)
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
        // === curl ใช้งานไม่ได้ : ตรวจที่ api ของ manage2.cpanel.net
        if (empty($result)) {

            
            $result  = $this->cpl->fetchLicenseId(array('ip'=>$ip));
            $result = json_decode($result);
            if ($result->status == 0 ) { // 0 = ยังไม่มี license
                //$aRes['message'] = 'ip ok ใช้ได้ ตรวจจาก mange2.cpanel.net';
                $aRes['res'] = true;
            }
			// ทำไมจะต้องเอาตัว b ด้วยเพราะว่าคำว่า active มีเยอะ
        } elseif (preg_match('/(?:.*?)\s*<b>\s*active\s*<\/b>\s*(?:.*?)\s*/i', $result)) {
            $aRes['message'] = 'This already existed. ';
            $aRes['res'] = false;
        } else {
             $aRes['message'] = 'license ใช้ได้ OK';
             $aRes['res'] = true; 
        }
        return $aRes;
    }

    private function _chkValidate($ip='', $accid)
    {
        $aRes = array();
        $aRes['res'] = true;
        if(!preg_match("/^\d*\.\d*\.\d*\.\d*$/", $ip)) {
            $aRes['res'] = false;
            $aRes['msg'] = 'format ip invalid';
			if($ip == ''){
				$aRes['msg'] = 'You did not enter a server ip';
			}
        } else {
            $aGetIp = RVProductLicenseDao::singleton()->getIpByAccountId($accid);
            if ((count($aGetIp) > 0)) {
                $aRes['ip'] =  $aGetIp;
                $aChkLicense = $this->check_cpanel_license($ip);
                if ($aChkLicense['res']  == false) {
                    $aRes['res'] = false;
                    $aRes['msg'] = $aChkLicense['message'];
                }
            
            } else {
                $aRes['res'] = false;
                $aRes['msg'] = 'ไม่พบข้อมูลบน hostbill ip='.$ip;
            }
        }
        
       
       
        return $aRes;
    }
    public function chkClassCpanelLicense()
    {
        if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing',false))) {
            require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
        }
        $this->cpl = new cPanelLicensing($this->module->server_username, $this->module->server_password);  
    }
    public function changeip($params, $jsonRespont=true, $limitCount=true)
    {
        $aRes = array();
        $this->serviceid = $params['server_id'];
        $txt = '';
		$this->chkClassCpanelLicense();
        
        $aChkValidate = $this->_chkValidate($params['to_ip'],$params['acc_id']);
        $aRes['res'] = true;
        if ( $aChkValidate['res']  == true) {
            $ipnew = $params['to_ip'];
            $userId = 'hb_acc_'.$params['acc_id'];
            $aGetIp = $aChkValidate['ip'];
            $aCpl = array(
                    'oldip' => $aGetIp['data'],
                    'newip' => $params['to_ip']
                );           
            $lisc = $this->cpl->changeip($aCpl);
            if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
                $licenseid = $resUpdateIp = RVCPanelDao::singleton()->getDataLogCpanel(array('ip'=>$aGetIp['data']));
                $licenseid = $licenseid[0]['licenseid'];
                $resUpdateIp = RVProductLicenseDao::singleton()->UpdateIpFormCustom(array(
                                'data' =>  $params['to_ip'],
                                'account_id' =>$params['acc_id'],
                                'config_cat' => $aGetIp['config_cat'],
                                'config_id' => $aGetIp['config_id']
                                ));
                if ($resUpdateIp == false)  $txt .= ' Error : update ip ใน custom ';
                $resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
                            'account_id' => $params['acc_id'],
                            'licenseid' => $licenseid,
                            'ip' => $params['to_ip'],
                            'reason' => $lisc->attributes()->reason,
                            'action' => 'changeip'
                            ));  
                if ($resLog == false)  $txt .= ' Error : update log ';
				if ($limitCount == true) {
	                $resInsertLogIp = RVProductLicenseDao::singleton()->InsertLogTransferIp(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
						'from_ip' => $aGetIp['data'],
						'acc_id' => $params['acc_id'],
						'to_ip' => $params['to_ip'],
						'active_by' => 'user',
						'active_id' => $params['acc_id'],
						'product_type' => 'cp'
					));
    	             if ($resInsertLogIp == false)  $txt .= ' Error : update Transfer limit log ';
				}
				 
                $aRes['msg'] = 'success:'.$txt;   
            } else {
                $aRes['res'] = false;
                $aRes['msg'] = '' .$lisc->attributes()->reason;
            }               
             
           
        } else {
            $aRes['res'] = false;
            $aRes['msg'] = $aChkValidate['msg'];
        }
        
        if ($aRes['res'] == true && $limitCount == true) {
            $resSaveLimit = RVProductLicenseDao::singleton()->InsertTransferLimitByAccid($params['acc_id']);
            if ($resSaveLimit == false) {
            	$aRes['res'] = true;
                $aRes['msg'] = 'Your Change IP Request exceeds limitation of 2 requests per year.';
            } else {
                $aRes['countLimit'] = $resSaveLimit;
            }
        }

		if ($jsonRespont == true) {
	        $this->loader->component('template/apiresponse', 'json');
    	    $this->json->assign("aResponse", $aRes);
        	$this->json->show();
		} else {
			return $aRes;
		}
    }
}