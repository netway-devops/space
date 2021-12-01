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

class rvcpanel_manage2 extends HostingModule {  
    // class name MUST be the same like the filename. In this example class.simpleexample.php
    protected $modname = "RV cPanel Licnese Manage2";
    protected $description = 'RV cPanel Licnese Manage2 Module for Hostbill.'; 
    
    protected $options = array();
    protected $details = array();

    protected $cpl;
    public $server_username ='Rv97Pj3W';
    public $server_password = ',o^db0wl;';
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

    public function isConnected ()
    {

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

        $this->server_username = $connect['username'];
        $this->server_password = $connect['password'];
        $this->server_hostname = $connect['hostname'];
        $this->server_ip = $connect['ip'];
        $this->cpl = new cPanelLicensing($this->server_username, $this->server_password);

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
                $aRes['message'] = 'ip ok ใช้ได้ ตรวจจาก mange2.cpanel.net';
                $aRes['res'] = true;
            }
        } elseif (preg_match('/Not licensed/i', $result)) {
            $aRes['message'] = 'ip ok ใช้ได้ ตรวจจาก verify.cpanel.net';
            $aRes['res'] = true;
        } else {
             $aRes['message'] = 'license มีแล้ว ใช้ไม่ได้';
             $aRes['res'] = false; 
        }
        return $aRes;
    }
    
    /**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */
    public function Create() 
    {
    	require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
        // ==== for product transerfer btn transferred
        if (isset($_POST['is_product_form_transfer']) && $_POST['is_product_form_transfer'] == 1) {
        	$ip = $this->account_config['ip']['value'];
			$lisc = $this->cpl->fetchLicenseId(array('ip'=>$ip));
	        if ($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
	            $resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
	                    'account_id' => $this->account_details['id'],
	                    'licenseid' => $lisc->licenseid,
	                    'ip' => $ip,
	                    'reason' => $lisc->attributes()->reason,
	                    'action' => 'change provider'
	                    ));
	        }
			return true;
        }

        $priceCode = strtolower(substr($this->account_details['billingcycle'],0,1));
        $aGetLinkCpanel = RVCPanelDao::singleton()->getDataPriceLinkCpanel(array('product_id'=>$this->account_details['product_id'],'price_code'=>$priceCode));
        $aGetLinkCpanel = $aGetLinkCpanel[0];
        $ip = $this->account_config['ip']['value'];
		$aChkip = $this->check_cpanel_license($ip);
        if ($aChkip['res'] == false) {
            $this->addError($aChkip['message']);
            return false;
        }
		$aRes  = array(
                    'ip'=>$ip,
                    'groupid'=>$aGetLinkCpanel['cpl_group'],
                    'packageid'=>$aGetLinkCpanel['cpl_package']
                    );
        $lisc = $this->cpl->activateLicense($aRes);
        if ($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
            $resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
                    'account_id' => $this->account_details['id'],
                    'licenseid' => $lisc->attributes()->licenseid,
                    'ip' => $ip,
                    'reason' => $lisc->attributes()->reason,
                    'action' => 'activateLicense'
                    ));
            return true;
        } else {
            $this->addError('cpanel error='.$lisc->attributes()->reason);
            return false;
        }
        
        $this->addError('หา field ip ไม่เจอ');
        return false;  
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
        if (isset($billingCycle) 
            && ($billingCycle != 'Annually'
            && $billingCycle != 'Biennially'
             && $billingCycle != 'Triennially')
        ) {
            return true;
        } else {
            require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
            $aDataByLog = RVCPanelDao::singleton()->getDataLogCpanel(array('account_id'=>$this->account_details['id']));
            $lisc = $this->cpl->reactivateLicense(array('liscid'=>$aDataByLog['0']['licenseid']));
            if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
                $resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
                        'account_id' => $this->account_details['id'],
                        'licenseid' => $lisc->attributes()->licenseid,
                        'reason' => $lisc->attributes()->reason,
                        'action' => 'renewal'
                        ));
                return true;
            }
            $this->addError('license ยัง active อยู่ที่ cpanel ไม่สามารถ renewal ได้');
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
        require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
		$ip = $this->account_config['ip']['value'];
		$licenseid = $this->api_getLicenseid($ip);
		if ($licenseid == false || $licenseid == '') {
			$this->addError('api ไม่พบ license id ของ ip : ' . $ip);
			// cpanel ไม่มี license นี้ ทาง hostbill ก็ complete ไม่ต้องทำอะไร
			return true;
		} else {
			$lisc = $this->cpl->expireLicense(array('liscid' =>$licenseid));
			if ($lisc instanceof SimpleXMLElement && ($lisc->attributes()->status  == 1 || $lisc->attributes()->result == '')) {
				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
	                'account_id' => $this->account_details['id'],
	                'licenseid' => $lisc->attributes()->licenseid,
	                'reason' => $lisc->attributes()->reason,
	                'action' => 'expireLicense'
	                ));
				return true;
			}
			$this->addError('api expireLicense('.$licenseid.') ไม่สำเร็จ ip : ' . $ip);
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
    	} else{
    		return false;
    	}
       
    }
	
	public function Unsuspend()
    {
		require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
		$ip = $this->account_config['ip']['value'];
		$licenseid = $this->api_getLicenseid($ip);
		if ($licenseid == false || $licenseid == '') {
			$this->addError('api ไม่พบ license id ของ ip : ' . $ip);
			return false;
		} else {
			$lisc_reactive = $this->cpl->reactivateLicense(array('liscid' => $licenseid));
			if($lisc_reactive instanceof SimpleXMLElement && $lisc_reactive->attributes()->status  == 1) {
				$resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
						'account_id' => $this->account_details['id'],
				        'licenseid' => $licenseid,
				        'ip' => $ip,
				        'reason' => $lisc_reactive->attributes()->reason,
				        'action' => 'Unsuspend'
				));
				return true;
			}
			$this->addError('api reactivateLicense ไม่สำเร็จ ip : ' . $ip);
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

}