<?php 
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvsitebuilder_license extends HostingModule
{
    protected $description = 'rvsitebuilder_license';
    
    protected $options = array(
    'Server Type' =>array (
                    'name'=> 'server_type',
                    'type'=> 'select',
                    'default'=>array('Dedicated','VPS')
            )
            
    );
    
    /**
     * You can choose which fields to display in Settings->Apps section
     * by defining this variable
     * @var array
     */
    protected $serverFields = array( //
            'hostname' 		=> false,
            'ip' 			=> false,
            'maxaccounts' 	=> false,
            'status_url' 	=> false,
            'field1' 		=> false,
            'field2' 		=> false,
            'username' 		=> false,
            'password' 		=> false,
            'hash' 			=> false,
            'ssl' 			=> false,
            'nameservers' 	=> false,
    );
    
    protected $serverFieldsDescription = array(
            'ip' 		=> 'Database IP',
            'hostname' 	=> 'Database Name',
            'username' 	=> 'Database Username',
            'password' 	=> 'Database Password'
    );
    
    /**
     * HostBill will replace default labels for server fields
     * with this variable configured
     * @var array
     */
    protected $details = array();
  
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function verifyLicense ($ip , $pb_ip)
    {
        $db             = hbm_db();
        
        $oResult        = new stdClass;
        $oResult->available     = false;
        
		if($pb_ip == '-'){
			$pb_ip = $ip;
		}
		
        $result         = $db->query("
                SELECT
                    rl.license_id
                FROM
                     rvsitebuilder_license rl
                WHERE
                    (rl.primary_ip = :ip
                    AND rl.secondary_ip = :pb_ip)
                ", array(
                    ':ip'       => $ip ,
                    ':pb_ip'	=> $pb_ip
                ))->fetch();
        
        if (isset($result['license_id']) && $result['license_id']) {
            return $oResult;
        }
        
        // [XXX] license หมดอายุ
        $oResult->available     = 'Register';
        $oResult->type          = 'VPS';
        return $oResult;
    }
  
    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) {
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
    public function testConnection() {
    	return true;
    }
    
     /**
      * Monthly: 1 เดือน,Quarterly3เดือน,Semi-Annually6เดือน,Annually1ปั
      *
      */
    private function calExpireDate($next_due_date = '') {
        date_default_timezone_set('UTC');
		if ($next_due_date == '0000-00-00')  $next_due_date = '2030-01-07';
        $aDate['exp'] = strtotime($next_due_date);
        $aDate['eff'] = mktime(
                                date('H', $aDate['exp'])+23,
                                date('i', $aDate['exp']),
                                date('s', $aDate['exp']),
                                date('n', $aDate['exp']),
                                date('j', $aDate['exp'])+3,
                                date('Y', $aDate['exp'])
                            );
        return $aDate;
    }
    
    public function sendmail ($msg) {
        $to      = 'darawan@rvglobalsoft.com';
        $subject = 'the subject DEBuG';

        $headers = 'From: webmaster@example.com' . "\r\n" .
            'Reply-To: webmaster@example.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();

        mail($to, $subject.'::::'.$msg, $msg, $headers);
    
    } 
    
/**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */
    public function Create() {
    	$db         = hbm_db();
        $api        = new ApiWrapper();

        $aDetail        = $this->account_details;
        
        $productId      = $this->product_details['id'];
        if (in_array($productId, array(161,162))) {
            # RVsitebuilder Developer License
            $_POST['ip']    = $aDetail['domain'];
        }
        
        
        if (preg_match('/transfer/i', $aDetail['status'])) {
            return $this->_transfer();
        }
        
        if ($aDetail['status'] == 'Terminated') {
            $this->addError('Account is Terminated');
            return false;
        }
        
    	if(isset($_POST['ip']) && $_POST['ip'] != '') {
			$sqlUpdateAcc = RVProductLicenseDao::singleton()->updateAccountByAccid($this->account_details['id'],$_POST['ip']);
			$this->account_config['ip']['value'] = $_POST['ip'];
		}
        $db_ip 		= $this->account_config['ip']['value'];
		$db_pb_ip	= $this->account_config['public_ip']['value'];
		if($db_pb_ip == '') $db_pb_ip = $db_ip;
        $aProduct 	= $this->product_details['options'];
        $billing 	= $this->account_details['billingcycle'];
        
        if (isset($db_ip) && $db_ip != '' && isset($db_pb_ip) && $db_pb_ip != '') {
            if (isset($aProduct['Server Type']) && $aProduct['Server Type'] != '') {
                $db_license_type = ($aProduct['Server Type'] == 'VPS' ) ? 11 : 9;
                $accid = $this->account_details['id'];
                $aDate = $this->calExpireDate($this->account_details['next_due']);
                
                if ($productId == 162) {
                    $expire         = strtotime('+1 month');
                    $expireDate     = date('Y-m-d', $expire);
                    $aDate['exp']   = $expire;
                    $aDate['eff']   = $expire;

                    $nextDue        = date('Y-m-d', strtotime('+30 day', strtotime($this->account_details['next_due'])));
                    $nextInvoice    = date('Y-m-d', strtotime('+30 day', strtotime($this->account_details['next_invoice'])));

                    $aData  = array(
                        'id'        => $accid,
                        'next_due'      => $nextDue,
                        'next_invoice'  => $nextInvoice,
                    );
                    $api->editAccountDetails($aData);

                }

				$query = $db->query("
					INSERT INTO	
						rvsitebuilder_license
						(license_type, client_id,primary_ip, secondary_ip, expire,active,email_installation,rvskin_user_snd,hb_acc,effective_expiry)
					VALUES
						(:db_license_type, :client_id, :primary_ip,:secondara_ip,:exp,:active,:email_install,:rvskin_user_snd,:hb_acc,:eff_exp)
				",array(
					':db_license_type'	=> $db_license_type,
					':client_id'		=> 1,
					':primary_ip'		=> $db_ip,
					':secondara_ip'		=> $db_pb_ip,
					':exp'				=> $aDate['exp'],
					':active'			=> 1,
					':email_install'	=> 1,
					':rvskin_user_snd'	=> '0',
					':hb_acc'			=> $accid,
					':eff_exp'			=> $aDate['eff']
				));
                
                require_once(APPDIR . 'class.general.custom.php');
                
                $result     = $db->query("
                    SELECT *
                    FROM rvsitebuilder_license
                    WHERE 1
                    ORDER BY license_id DESC
                    LIMIT 1
                    ")->fetch();
                if (isset($result['license_id'])) {
                    GeneralCustom::singleton()->addRvsitebuilderLicenseLog('add_license', $result);
                }
                
                if ($query) {
                      return true;
                }
            } else {
                $this->addError('หาค่า Server Type ไม่เจอ (Dedicate/Vps)');
                return false;
            }
        } else {
            $this->addError('หาค่า IP ไม่เจอ');
            return false;
        }
        
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
            $db->query("
                INSERT INTO hb_account_logs (
                    id, date, account_id, admin_login, module, manual, action, 
                    `change`, result, error, event
                ) VALUES (
                    '', NOW(), :accountId, :admin, 'rvsitebuilder_license', '0', 'Transfer Account', 
                    :logs, '1', '', 'TransferAccount'
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':admin'            => $aAdmin['username'],
                    ':logs'             => serialize($aLog)
                ));
        }
        
        $ip             = $this->_findIPAddress();
        
        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }
        
        $result         = $db->query("
                SELECT
                    rl.license_id, rl.hb_acc
                FROM
                     rvsitebuilder_license rl
                WHERE
                    (rl.primary_ip = :ip
                    OR rl.secondary_ip = :ip)
                ", array(
                    ':ip'       => $ip
                ))->fetch();
        
        if (! isset($result['license_id'])) {
            $this->addError('License is not existed.');
            return false;
        }
        
        $licenseId      = $result['license_id'];
        $oldAccountId   = $result['hb_acc'];
        
        $db->query("
            UPDATE
                rvsitebuilder_license 
            SET
                hb_acc = :accountId
            WHERE
                license_id = :licenseId
            ", array(
                ':accountId'    => $accountId,
                ':licenseId'    => $licenseId
            ));
        
        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'Account Id', 'from' => $oldAccountId , 'to' => $accountId)
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action, 
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, '-', '1', 'Change Owner', 
                :logs, '1', '', ''
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog)
            ));
        
        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Terminated',
                date_changed = NOW()
            WHERE
                AND id = :accountId
            ", array(
                ':accountId'    => $oldAccountId
            ));
        
        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'Account Id', 'from' => $oldAccountId , 'to' => $accountId)
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action, 
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, '-', '1', 'Change Owner', 
                :logs, '1', '', ''
            )
            ", array(
                ':accountId'        => $oldAccountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog)
            ));
        
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
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action, 
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'rvsitebuilder_license', '0', 'Transfer Account', 
                :logs, '1', '', 'TransferAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog)
            ));
        
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
     * @return boolean true if suspend succeeds
     */
    public function Suspend()
    {
        	
		$db 	= hbm_db();
		$accid 	= $this->account_details['id'];
		$res 	= $db->query("
			UPDATE
				rvsitebuilder_license
			SET
				active = 0
			WHERE
				hb_acc = :accid
			",array(':accid'=>$accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvkin sql = ' . $sql);
            return false;
        }
    }
    
    public function Unsuspend()
    {
        $db 	= hbm_db();
		$accid 	= $this->account_details['id'];
		$res 	= $db->query("
			UPDATE
				rvsitebuilder_license
			SET
				active = 1
			WHERE
				hb_acc = :accid
			",array(':accid'=>$accid));
        if ($res) {
            $renewal = $this->Renewal();
            return true;
        } else {
            $this->addError('Error delete rvkin sql = ' . $sql);
            return false;
        }
    }
  
    
    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate() 
    {
        $db = hbm_db();
        if (!isset($this->account_details['id']) || $this->account_details['id'] == '' || $this->account_details['id'] == 0) {
            $this->addError('ไม่มีค่า account id');
            return false;
        }
			 
        $accid =  $this->account_details['id'];
		
        require_once(APPDIR . 'class.general.custom.php');
        
        $result     = $db->query("
            SELECT *
            FROM rvsitebuilder_license
            WHERE hb_acc = '{$accid}'
            ")->fetchAll();
        if (count($result)) {
            foreach ($result as $arr) {
                GeneralCustom::singleton()->addRvsitebuilderLicenseLog('terminate_account', $arr);
            }
        }
        
		$sql = "DELETE FROM rvsitebuilder_license WHERE hb_acc=:accid";
		$res = $db->query($sql, array(':accid' => $accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvkin sql = ' . $sql);
            return false;
        }
    }
    
    public function Renewal()
    {
        $db 	= hbm_db();
        $aDate 	= $this->calExpireDate($this->account_details['next_due']);
		$accid 	= $this->account_details['id'];
		$res 	= $db->query("
			UPDATE
				rvsitebuilder_license
			SET
				active = 1,
				expire = :exp,
				effective_expiry = :exp_eff
			WHERE
				hb_acc = :accid
			",array(':accid'=>$accid,':exp'=>$aDate['exp'],':exp_eff'=>$aDate['eff']));
			
        require_once(APPDIR . 'class.general.custom.php');
        
        $result     = $db->query("
            SELECT *
            FROM rvsitebuilder_license
            WHERE hb_acc = '{$accid}'
            ")->fetchAll();
        if (count($result)) {
            foreach ($result as $arr) {
                GeneralCustom::singleton()->addRvsitebuilderLicenseLog('renew_account', $arr);
            }
        }
			
        if ($res) {
            return true;
        } else {
            $this->addError('Error renewal rvkin sql = ' . $sql);
            return false;
        }
    }
	
    /**
     * This method is invoked when account should have password changed
     * @param string $newpassword New password to set account with
     * @return boolean true if action succeeded
     */
    public function ChangePasswordddd($newpassword)
    {
        return true;
    }
    
    /**
     * This method is invoked when account should be upgraded/downgraded
     * $options variable is loaded with new package configuration
     * @return boolean true if action succeeded
     */
    public function ChangePackage ()
    {
        return true;
    }
    
    
    /**
     * Auxilary method that HostBill will load to get plans from server:
     * @see $options variable above
     * @return array - list of plans to display in product configuration
     */
    public function getPlansccc() 
    {
        $return = array();
        return $return;
    }
    
}
