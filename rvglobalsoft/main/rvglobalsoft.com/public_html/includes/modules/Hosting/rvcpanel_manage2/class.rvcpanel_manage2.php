<?php
/*************************************************************
 *
 * Provisioning Module Class - Simple Example
 *
 * You can read more about the hosting modules development at:
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/
 *
 * This simple module is a basic implementation.
 * If you want to get more extended functionality
 * please download the Example 2 file from the article above
 *
 ************************************************************/
require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";

class rvcpanel_manage2 extends HostingModule {
    // class name MUST be the same like the filename. In this example class.simpleexample.php
    protected $modname = "RV cPanel Licnese Manage2";
    protected $description = 'RV cPanel Licnese Manage2 Module for Hostbill.';

    protected $options = array();
    protected $details = array();

    protected $cpl;
	//https://manage2.cpanel.net/
    public $server_username ='Rv97Pj3W';
    public $server_password = 'Z6)Hnb)/S48F';
    public $server_groupid  = '45025';

	/*
    public $server_username ='';
    public $server_password = '';
	*/

    public $server_hostname;
    private $server_ip;

    protected $serverFields = array(
        "hostname" => false,
        "ip" => false,
        "maxaccounts" => false,
        "status_url" => false,
        "username" => true,
        "password" => true,
        "hash" => false,
        "ssl" => false,
        "nameservers" => false
    );

    public $aPackage    = array(
        '63'           => array('name' => 'cPanel License (for dedicated server)', 'package' => '799'),
        '64'           => array('name' => 'cPanel License (for vps server)', 'package' => '800'),
        '65'           => array('name' => 'cPanel License (for vzzo server)', 'package' => ''),
        '96'           => array('name' => 'Free Cpanel License (for dedicated server)', 'package' => ''),
        '97'           => array('name' => 'Free Cpanel License (for vps server)', 'package' => ''),
        '109'          => array('name' => 'Cpanel License + Free RVSkin (for dedicated)', 'package' => ''),
        '100'          => array('name' => 'Cpanel License + Free RVSkin (for vps server)', 'package' => ''),
        '113'          => array('name' => 'Cpanel License + Free RVSkin (for vzzo server)', 'package' => ''),
        );

    private static  $instance;

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function verifyLicense ($ip, $moduleChk = false)
    {
        $db             = hbm_db();

        $oResult        = new stdClass;
        $oResult->available     = false;
        $oResult->type          = '';

//         require_once(APPDIR .'libs/cpanel/cpl-3.6/php/cpl.inc.php');

        $urlRequest = 'http://verify.cpanel.net/index.cgi?ip=' . $ip;
        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $result     = str_replace("\n", "", $result);

        // [TODO] ยังไม่มี license
        if (preg_match('/<b>Not\slicensed<\/b>/', $result)) {
            $oResult->available     = 'Register';
            return $oResult;
        }

        $this->connect(array());
        $oResult->risk_score = $this->getRiskScore($ip);

        // [TODO] license active
        preg_match('/\<table class=\"history table\"\>.*\<\/table\>/', $result, $specificClass);
        $specificClass = str_replace("\n", "", $specificClass[0]);
        $searchByTr = explode('<tr', $specificClass);
        foreach($searchByTr as $eachData){
        	$nowSearch = str_replace(' ', '', $eachData);
        	if(strpos($nowSearch, '</tr>')) $nowSearch = '<tr' . $nowSearch;
        	if(strpos($nowSearch, '<tdalign="center">cPanel/WHM</td><td><b>active<br/></b></td>')){
        		if(strpos($nowSearch, 'RVGlobalSoftCo.,Ltd</a></td>')){
        			$oResult->available = false;
        		} else if(strpos($nowSearch, '<tdalign="center"class="oldinfo">cPanel/WHM</td>') && strpos($nowSearch, '<tdalign="center"class="oldinfo">cPanel/WHM</td>')){
        			$oResult->available     = 'Register';
        		} else {
        			$oResult->available = 'Transfer';
	        			if(strpos($nowSearch, '-VPS</td>')){
	        				$oResult->type      = 'VPS';
	        			} else {
	        				$oResult->type      = 'Dedicated';
	        			}
        			}
        		return $oResult;
        	}
        }

        // [TODO] license หมดอายุ
        $oResult->available     = 'Register';
        return $oResult;
    }

    private function _isClientLicense ($ip)
    {
        $db             = hbm_db();

        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_accounts a,
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    a.id = c2a.account_id
                    AND c2a.rel_type = 'Hosting'
                    AND a.status = 'Active'
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                    AND a.client_id = :clientId
                    AND a.product_id IN (". implode(',', array_keys($this->aPackage)) .")
                    AND c2a.data = :ip
                ", array(
                    ':clientId'     => $clientId,
                    ':ip'           => $ip
                ))->fetch();

        if (isset($result['config_id']) && $result['config_id']) {
            return true;
        }

        return false;
    }


    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect)
    {
        // this is the method to load the Server Info configured at Apps Section.
       if (!class_exists('cPanelLicensing' , false)) {
            require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
       }

        /*$this->server_username = $connect['username'];
        $this->server_password = $connect['password'];
        $this->server_hostname = $connect['hostname'];
        $this->server_ip = $connect['ip'];*/
        $this->cpl = new cPanelLicensing($this->server_username, $this->server_password);
		return true;
    }


    /**
     * HostBill will call this method when admin clicks on "test Connection" in settings->apps
     * It should test connection to remote app using details provided in connect method
     *
     * Use $this->addError('message'); to provide errors details (if any)
     *
     * @see connect
     * @return boolean true if connection suceeds
     */
    public function testConnection()
    {
        $lisc = $this->cpl->fetchGroups();
        if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
            $this->addInfo('Test connect to manage2.cpanel.net has seccessfully.');
            return true;
        } else {
             $this->addError('Test connect to manage2.cpanel.net has problem.');
            return false;
        }
    }

    private function check_cpanel_license($ip)
    {
    	/*
		$lisc  = $this->cpl->fetchLicenseRaw(array('ip'=>$ip));
		if ($lisc instanceof SimpleXMLElement) {
			if ($lisc->attributes()->status == 1) {
				$aRes['message'] = "{$ip} already existed.";
				$aRes['res'] = false;
			} else {
				$aRes['message'] = "{$ip} can usage.";
				$aRes['res'] = true;
			}
		} else {
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
        	*/
        	// === curl ใช้งานไม่ได้ : ตรวจที่ api ของ manage2.cpanel.net
        	//if (preg_match('/(?:.*?)\s*<b>\s*active\s*<\/b>\s*(?:.*?)\s*/i', $result)) {
        	/*
            	$aRes['message'] = '{$ip} already existed.';
            	$aRes['res'] = false;
        	} else {
             $aRes['message'] = '{$ip} can usage.';
             $aRes['res'] = true;
        	}
        }
        return $aRes;
        */
    	$urlRequest = 'http://verify.cpanel.net/index.cgi?ip=' . $ip;
    	$ch         = curl_init();
    	curl_setopt($ch, CURLOPT_URL, $urlRequest);
    	curl_setopt($ch, CURLOPT_FAILONERROR, 1);
    	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    	curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
    	curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
    	$result     = curl_exec($ch);
    	curl_close($ch);

    	$result     = str_replace("\n", "", $result);

    	// [TODO] ยังไม่มี license
    	if (preg_match('/<b>Not\slicensed<\/b>/', $result)) {
    		$aRes['message'] = "{$ip} can usage.";
			$aRes['res'] = true;
			return $aRes;
    	}

    	// [TODO] license active
    	preg_match('/\<table class=\"history table\"\>.*\<\/table\>/', $result, $specificClass);
    	$specificClass = str_replace("\n", "", $specificClass[0]);
    	$searchByTr = explode('<tr', $specificClass);
    	foreach($searchByTr as $eachData){
    		$nowSearch = str_replace(' ', '', $eachData);
    		if(strpos($nowSearch, '</tr>')) $nowSearch = '<tr' . $nowSearch;
    		if(strpos($nowSearch, '<tdalign="center">cPanel/WHM</td><td><b>active<br/></b></td>')){
    			if(strpos($nowSearch, 'RVGlobalSoftCo.,Ltd</a></td>')){
    				$aRes['message'] = "{$ip} already existed.";
    				$aRes['res'] = false;
    				$aRes['exist'] = true; 
    			} else if(strpos($nowSearch, '<tdalign="center"class="oldinfo">cPanel/WHM</td>') && strpos($nowSearch, '<tdalign="center"class="oldinfo">cPanel/WHM</td>')){
    				$aRes['message'] = "{$ip} can usage.";
    				$aRes['res'] = true;
    			} else {
    				$aRes['message'] = "{$ip} already existed.";
    				$aRes['res'] = false;
    				$aRes['exist'] = true; 
    			}
    			return $aRes;
    		}
    	}
    	$aRes['message'] = "{$ip} can usage.";
    	$aRes['res'] = true;
    	return $aRes;
    }
  /**
   * cpanelId = product id ของ cpanel อะไรจะได้รูว่าเป็น vps รึ ded
   * itype = SK,SB
   * desc :
   * cpanel transfer ded : cp : 68 ,SK : 70,SB : 66
   * cpanel transfer vps ; cp : 69 ,SK : 71,SB : 67
   */
    private function getProductID($cpanelId)
    {
        $res = array();
    	switch ($cpanelId) {
			case 68 : $res = array('SK'=>70,'SB'=>66); break;
			case 69 : $res = array('SK'=>71,'SB'=>67); break;
    	}
		return $res;

    }
	/**
   * aAcc = account_detail
   * itype = SK,SB
   */
	private function createAccountLicense ($aAcc,$aDtl)
	{
		require_once(APPDIR . 'class.api.custom.php');
		$aP = $this->getProductID($aAcc['product_id']);
	    // [FIXME] Fixcode
        $adminUrl   = (isset($_SERVER['HTTPS']) ? 'https' : 'http://') . $_SERVER['HTTP_HOST']
                    . (preg_match('/^192\.168\.1/', $_SERVER['HTTP_HOST'])
                        ? '/demo/rvglobalsoft.com/public_html/admin/api.php'
                        : '/7944web/api.php');
		$apiCustom  = ApiCustom::singleton($adminUrl);
		$params = array(
				'call'      		=> 'addOrder',
	            'client_id'			=> $aAcc['client_id'],
	            'cycle'				=> strtolower(substr($aAcc['billingcycle'], 0,1)),
			    'confirm'			=> 0,
			    'invoice_generate'	=> 0,
			    'invoice_info'		=> '',
			    'product' 			=> $aP[$aDtl['itype']],
			    'ip'				=> $aDtl['ip']
				);
		return $apiCustom->request($params);

	}

	private function transfer($ip='')
	{
		$alistError = array();
		$alistOk = array();
		$alistip = explode(",", str_replace(" ", "", $ip));
		$txt_info = '';
		foreach ($alistip as $k => $ip) {
			$lisc = $this->cpl->fetchLicenseId(array('ip'=>$ip));
			if ($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
// 				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
// 					'account_id' => $this->account_details['id'],
// 					'licenseid' => $lisc->licenseid,
// 					'ip' => $ip,
// 					'reason' => $lisc->attributes()->reason,
// 					'action' => 'change provider'
// 				));
				array_push($alistOk, $ip);
			} elseif ($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  != 1) {
				array_push($alistError,$ip);
// 				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
// 					'account_id' => $this->account_details['id'],
// 					'licenseid' => $lisc->licenseid,
// 					'ip' => $ip,
// 					'reason' => $lisc->attributes()->reason,
// 					'action' => 'change provider'
// 				));
				$txt_info .= "cPanel Licnese Manage2 reason error: {$lisc->attributes()->reason} [{$ip}]\n";
			}else {
				array_push($alistError,$ip);
// 				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
// 					'account_id' => $this->account_details['id'],
// 					'licenseid' => '',
// 					'ip' => $ip,
// 					'reason' => "cpanel error: $ip\n",
// 					'action' => 'change provider'
// 				));
				$txt_info .= "cPanel Licnese Manage2 not have reason ({$ip})\n";
			}
		}

		// $aErrorSK = array();
		if (isset($this->account_config['qty_rvskin']['qty']) && $this->account_config['qty_rvskin']['qty'] !=0) {
			foreach($alistOk as $k1 => $ipskin){
				$result = $this->createAccountLicense($this->account_details,array('ip'=>$ipskin,'itype'=>'SK'));
				if (isset($result['success']) &&  $result['success'] == 1) {
				} else {
					//array_push($aErrorSK,$ipskin);
					$txt_info.='skin error:'.$ipskin."\n";
				}

			}
		}

		//$aErrorSB = array();
		if (isset($this->account_config['qty_rvsitebuilder']['qty']) && $this->account_config['qty_rvsitebuilder']['qty'] !=0) {
			foreach($alistOk as $k1 => $ipsb){
				$result = $this->createAccountLicense($this->account_details,array('ip'=>$ipsb,'itype'=>'SB'));
				if (isset($result['success']) &&  $result['success'] == 1) {
					//echo '<br>OK='.$ipsb;
				} else {
					//array_push($aErrorSB,$ipsb);
					$txt_info.='sb error:'.$ipsb."\n";
				}

			}
		}

		if (count($alistError) > 0) {
			RVCPanelDao::singleton()->insertAccountLog('Create Account', 'AccountCreate', $this->account_details['id'], "IP {$ip}: {$txt_info}");
			$this->addError($txt_info);
			return false;
		} else {
			if ($txt_info != ''){
				RVCPanelDao::singleton()->insertAccountLog('Create Account', 'AccountCreate', $this->account_details['id'], "IP {$ip}: {$txt_info}");
			}
			return true;
		}
	}

	private function getInputIP()
	{
		return trim(preg_replace('/\s\s+/', ' ', $this->account_config['ip']['value']));
	}

    /**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */
    public function Create()
	{
		$db         = hbm_db();

        $aDetail        = $this->account_details;

        if (preg_match('/transfer/i', $aDetail['status'])) {
            return $this->_transfer();
        }

        // ==== for product transerfer btn transferred

       	$ip = $this->getInputIP();

		if (empty($ip)) {
// 			RVCPanelDao::singleton()->insertAccountLog(
// 				'Create Account',
// 				'AccountCreate',
// 				$this->account_details['id'],
// 				"Not input ip field!!"
// 			);
        	$this->addError("[{$this->account_details['id']}]: Not submit IP Accress!!");
        	return false;
		} elseif (isset($_POST['is_product_form_transfer']) && $_POST['is_product_form_transfer'] == 1) {
        	return $this->transfer($ip);
        } else {
	        $priceCode = strtolower(substr($this->account_details['billingcycle'], 0, 1));
    		$aGetLinkCpanel = RVCPanelDao::singleton()->getDataPriceLinkCpanel(array(
    			'product_id' => $this->account_details['product_id']
    			, 'price_code' => $priceCode
			));
        	$aGetLinkCpanel = $aGetLinkCpanel[0];

			$aChkip = $this->check_cpanel_license($ip);

    	    if ($aChkip['res'] == false) {
    	    	
    	    	if(isset($aChkip['exist']) && $aChkip['exist'] == true) {
    	    		$this->addInfo($aChkip['message']);
    	    		return true;
    	    	}
    	    	
        	    $this->addError($aChkip['message']);
// 				RVCPanelDao::singleton()->insertAccountLog(
// 					'Create Account'
// 					, 'AccountCreate'
// 					, $this->account_details['id']
// 					, "IP {$ip}: {$aChkip['message']}"
// 				);
            	return false;
        	}

			$aRes  = array(
            	'ip' => $ip,
                'groupid' => $aGetLinkCpanel['cpl_group'],
                'packageid' => $aGetLinkCpanel['cpl_package'],
                "force" => 1,
                "reactivateok" => 1
            );

			$this->addInfo("Do activate cPanel License IP: {$ip}, groupid: {$aGetLinkCpanel['cpl_group']}, packageid: {$aGetLinkCpanel['cpl_package']}");

        	$lisc = $this->cpl->activateLicense($aRes);
        	if ($lisc instanceof SimpleXMLElement) {
        		if ($lisc->attributes()->status > 0) {
//             		$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
//                     	'account_id' => $this->account_details['id'],
//                     	'licenseid' => $lisc->attributes()->licenseid,
//                     	'ip' => $ip,
//                     	'reason' => $lisc->attributes()->reason,
//                     	'action' => 'activateLicense'
//                 	));
// 					RVCPanelDao::singleton()->insertAccountLog('Create Account', 'AccountCreate', $this->account_details['id'], "IP {$ip}: {$lisc->attributes()->reason}");
            		return true;
        		} else {
//         			RVCPanelDao::singleton()->insertAccountLog('Create Account', 'AccountCreate', $this->account_details['id'], "IP {$ip}: cPanel Licnese Manage2 reason error '{$lisc->attributes()->reason}'");
					$this->addError("[{$this->account_details['id']}]: " . 'cPanel Licnese Manage2 reason error: ' . $lisc->attributes()->reason);
            		return false;
				}
        	} else {
//         		RVCPanelDao::singleton()->insertAccountLog('Create Account', 'AccountCreate', $this->account_details['id'], "IP {$ip}: Cannot get reason from cPanel Licnese Manage2");
				$this->addError("[{$this->account_details['id']}]: " . 'Cannot get reason from cPanel Licnese Manage2.');
            	return false;
        	}
        }
		return false;
    }

    private function _transfer ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];

        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Pending Transfer',
                date_changed = NOW()
            WHERE
                status = 'Transfer Request'
                AND id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));

        if ($aDetail['status'] == 'Transfer Request') {
            $aLog       = array('serialized' => '1', 'data' => array(
                '0'     => array('name' => 'status', 'from' => 'Transfer Request', 'to' => 'Pending Transfer')
                ));
//             $db->query("
//                 INSERT INTO hb_account_logs (
//                     id, date, account_id, admin_login, module, manual, action,
//                     `change`, result, error, event
//                 ) VALUES (
//                     '', NOW(), :accountId, :admin, 'rvcpanel_manage2', '0', 'Transfer Account',
//                     :logs, '1', '', 'TransferAccount'
//                 )
//                 ", array(
//                     ':accountId'        => $accountId,
//                     ':admin'            => $aAdmin['username'],
//                     ':logs'             => serialize($aLog)
//                 ));
        }

        $ip             = $this->_findIPAddress();

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }


        $package        = $this->aPackage[$productId]['package'];

        $aParam         = array(
            'ip'        => $ip,
            'groupid'   => $this->server_groupid,
            'packageid' => $package
            );

        $result         = $this->cpl->requestTransfer($aParam);
        $json           = json_encode($result);
        $array          = json_decode($json,TRUE);

        if (! $array['status']) {
            $this->addError('Error:'. $array['reason']);
            return false;
        }

        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Active',
                date_changed = NOW()
            WHERE
                AND id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Pending Transfer', 'to' => 'Active')
            ));
//         $db->query("
//             INSERT INTO hb_account_logs (
//                 id, date, account_id, admin_login, module, manual, action,
//                 `change`, result, error, event
//             ) VALUES (
//                 '', NOW(), :accountId, :admin, 'rvcpanel_manage2', '0', 'Transfer Account',
//                 :logs, '1', '', 'TransferAccount'
//             )
//             ", array(
//                 ':accountId'        => $accountId,
//                 ':admin'            => $aAdmin['username'],
//                 ':logs'             => serialize($aLog)
//             ));

        $this->addInfo('Transfer account:'. $accountId .' succcess.');

        return true;
    }

    private function _findIPAddress ()
    {
        $aDetail        = $this->account_details;
        $ip             = '';

        if (! isset($aDetail['customforms'])) {
            return $ip;
        }

        foreach ($aDetail['customforms'] as $arr) {
            if ($arr['name'] == 'IP Address') {
                foreach ($arr['data'] as $v) {
                    return $v;
                }
            }
        }

        return $ip;
    }

     /**
     * This method is invoked automatically when suspending an account.
     *  $this->addError('vvvvvvvvvvvvvvvvvvvvvvvvv');
     * @return boolean true if suspend succeeds
     */
    public function Renewal()
    {
        //==== ทำเฉพาะรายปีเท่านั้น
        $billingCycle = $this->account_details['billingcycle'];
		$ip = $this->getInputIP();

        if (isset($billingCycle) && $billingCycle == 'Monthly') {
            return true;
        } else {
//             $aDataByLog = RVCPanelDao::singleton()->getDataLogCpanel(array('account_id'=>$this->account_details['id']));

            $dataLicense = $this->cpl->fetchLicenseId(array('ip'=>$this->account_config['ip']['value']));

            if($dataLicense instanceof SimpleXMLElement && $dataLicense->attributes()->status  == 1) {
				$licenseid = (string)$dataLicense->licenseid;
				$this->addInfo('cPanel licenseid: '.$licenseid);
			} else {
// 				RVCPanelDao::singleton()->insertAccountLog(
// 					'Renewal Account',
// 					'RenewalAccount',
// 					$this->account_details['id'],
// 					"IP {$ip}: Cannot get license id from cPanel Licnese Manage2"
// 				);

				$this->addError("[{$this->account_details['id']}] IP {$ip}: Cannot get license id from cPanel Licnese Manage2");
            	return false;
			}

            $lisc = $this->cpl->reactivateLicense(array('liscid'=>$licenseid));
            if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
//                 $resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
// 					'account_id' => $this->account_details['id'],
// 					'licenseid' => $lisc->attributes()->licenseid,
// 					'reason' => $lisc->attributes()->reason,
// 					'action' => 'renewal'
// 				));
// 				RVCPanelDao::singleton()->insertAccountLog(
// 					'Renewal Account',
// 					'RenewalAccount',
// 					$this->account_details['id'],
// 					"IP {$ip}: {$lisc->attributes()->reason}"
// 				);
                return true;
            }
// 			RVCPanelDao::singleton()->insertAccountLog(
// 				'Renewal Account',
// 				'RenewalAccount',
// 				$this->account_details['id'],
// 				"[{$this->account_details['id']}] IP {$ip}: license({$licenseid}) is active, cannot renewal."
// 			);
            $this->addError("[{$this->account_details['id']}] IP {$ip}: license({$licenseid}) is active, cannot renewal.");
            return false;
        }
    }

    private function api_getLicenseid($ip)
	{
		$lisc = $this->cpl->fetchLicenseId(array('ip' => $ip));
		if ($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
			$id = (string)$lisc->licenseid;
			return $id;
		} else {
			return false;
		}
	}

    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate()
    {
		$ip = $this->getInputIP();
		$licenseid = $this->api_getLicenseid($ip);
		if ($licenseid == false || $licenseid == '') {
// 			RVCPanelDao::singleton()->insertAccountLog(
// 				'Terminate Account',
// 				'TerminateAccount',
// 				$this->account_details['id'],
// 				"IP {$ip}: Cannot get license id from cPanel Licnese Manage2"
// 			);

			$this->addError("IP {$ip}: Cannot get license id from cPanel Licnese Manage2");
			// cpanel ไม่มี license นี้ ทาง hostbill ก็ complete ไม่ต้องทำอะไร
			return true;
		} else {
			$lisc = $this->cpl->expireLicense(array('liscid' =>$licenseid, "expcode" => "normal"));
			if ($lisc instanceof SimpleXMLElement && ($lisc->attributes()->status  == 1 || $lisc->attributes()->result == '')) {
// 				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
// 					'account_id' => $this->account_details['id'],
// 	                'licenseid' => $lisc->attributes()->licenseid,
// 	                'reason' => $lisc->attributes()->reason,
// 	                'action' => 'expireLicense'
// 				));
// 				RVCPanelDao::singleton()->insertAccountLog(
// 					'Terminate Account',
// 					'TerminateAccount',
// 					$this->account_details['id'],
// 					"IP {$ip}: {$lisc->attributes()->reason}"
// 				);
				return true;
			}
			$this->addError("IP {$ip}({$this->account_details['id']}): Expire license({$licenseid}) has failed.");
// 			RVCPanelDao::singleton()->insertAccountLog(
// 				'Terminate Account',
// 				'TerminateAccount',
// 				$this->account_details['id'],
// 				"IP {$ip}({$this->account_details['id']}): Expire license({$licenseid}) has failed."
// 			);

			$verifyLicense = $this->verifyLicense($ip);
			if($verifyLicense->available == 'Register') return true;
			return false;
		}
    }

    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Suspend()
    {
    	$isBoolean = $this->Terminate();
    	if ($isBoolean == true){
    		return true;
    	} else {
    		return false;
    	}

    }

	public function Unsuspend()
    {
		$ip = $this->getInputIP();
		$licenseid = $this->api_getLicenseid($ip);
		if ($licenseid == false || $licenseid == '') {
// 			RVCPanelDao::singleton()->insertAccountLog(
// 				'Unsuspend Account',
// 				'UnsuspendAccount',
// 				$this->account_details['id'],
// 				"IP {$ip}({$this->account_details['id']}): Cannot get license id from cPanel Licnese Manage2."
// 			);
			$this->addError("IP {$ip}({$this->account_details['id']}): Cannot get license id from cPanel Licnese Manage2.");
			return false;
		} else {
			$lisc_reactive = $this->cpl->reactivateLicense(array('liscid' => $licenseid));
			if($lisc_reactive instanceof SimpleXMLElement && $lisc_reactive->attributes()->status  == 1) {
// 				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
// 						'account_id' => $this->account_details['id'],
// 				        'licenseid' => $licenseid,
// 				        'ip' => $ip,
// 				        'reason' => $lisc_reactive->attributes()->reason,
// 				        'action' => 'Unsuspend'
// 				));
// 				RVCPanelDao::singleton()->insertAccountLog(
// 					'Terminate Account',
// 					'TerminateAccount',
// 					$this->account_details['id'],
// 					"IP {$ip}: {$lisc_reactive->attributes()->reason}"
// 				);
				return true;
			}
// 			RVCPanelDao::singleton()->insertAccountLog(
// 				'Unsuspend Account',
// 				'UnsuspendAccount',
// 				$this->account_details['id'],
// 				"IP {$ip}: Unsuspend license($licenseid) has failed."
// 			);
			$this->addError("IP {$ip}({$this->account_details['id']}): Unsuspend license({$licenseid}) has failed.");
			return false;
		}

    }

    /**
     * This method is OPTIONAL. in this example it is used to connect to the server and manage all the modules action with the API.
     * @ignore
     * @param <type> $action
     * @param <type> $post
     * @return <type>
     */
    private function Send($action, $post)
    {
        return true;
    }

    public function getRiskScore($ip)
    {
    	$this->connect(array());
    	$riskScore = $this->cpl->fetchLicenseRiskData(array("ip" => $ip));
    	if($riskScore instanceof SimpleXMLElement && $riskScore->attributes()->status  == 1) {
    		$riskScore = $this->xml2array($riskScore);
    		return $riskScore['@attributes']['riskscore.aggregate.score'];
    	}
    	return false;
    }

    public function xml2array($xmlObject, $out = array())
    {
    	foreach((array)$xmlObject as $index => $node)
    		$out[$index] = (is_object($node)) ? $this->xml2array($node) : $node;
    	return $out;
    }
}
