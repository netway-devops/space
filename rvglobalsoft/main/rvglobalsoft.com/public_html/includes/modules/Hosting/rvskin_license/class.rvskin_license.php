<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvskin_license extends HostingModule
{
	protected $description = 'rvskin_license';

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
			'hostname' => false,
			'ip' => false,
			'maxaccounts' => false,
			'status_url' => false,
			'field1' => false,
			'field2' => false,
			'username' => false,
			'password' => false,
			'hash' => false,
			'ssl' => false,
			'nameservers' => false,
	);

	protected $serverFieldsDescription = array(
	        'ip' => 'Database IP',
            'hostname' => 'Database Name',
            'username' => 'Database Username',
            'password' => 'Database Password'
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
                     rvskin_license rl
                WHERE
                    (rl.main_ip = :ip
                    AND rl.second_ip = :pb_ip)
                ", array(
                    ':ip'       => $ip,
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


    private function calExpireDate($billingCycle,$next_due_date=''){
        //24/09/2013
        date_default_timezone_set('UTC');
		$res = array();
        if ($next_due_date != '') {
            $res['exp'] = strtotime($next_due_date);
			$res['eff_exp'] = mktime(
                                date('H', $res['exp']),
                                date('i', $res['exp']),
                                date('s', $res['exp']),
                                date('n', $res['exp']),
                                date('j', $res['exp'])+3,
                                date('Y', $res['exp'])
                            );
			return $res;
        } else {
            $startDate = time();
        }
        $expiredate = '';
        $addMonth=0;
        $addYear=0;
        switch ($billingCycle) {
            case 'Monthly' :
                $addMonth = 1;
                break;
                 case 'Quarterly' :
                $addMonth = 3;
                break;
                 case 'Semi-Annually' :
                $addMonth = 6;
                break;
                 case 'Annually' :
                $addYear = 1;
                break;
        }
        $res = array();
        $res['exp'] = mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate) + $addMonth,
                                date('j', $startDate),
                                date('Y', $startDate) + $addYear
                            );
	    $res['eff_exp'] = mktime(
                                date('H', $res['exp']),
                                date('i', $res['exp']),
                                date('s', $res['exp']),
                                date('n', $res['exp']),
                                date('j', $res['exp'])+3,
                                date('Y', $res['exp'])
                            );
		return $res;
    }

	private function calActivatedate($next_due_date = '', $billingCycle)
	{
        //24/09/2013
        date_default_timezone_set('UTC');
        if ($next_due_date != '') {
            $startDate = strtotime($next_due_date);
        } else {
            $startDate = time();
        }
        $addMonth 	= 0;
        $addYear  	= 0;
        switch ($billingCycle) {
            case 'Monthly' :
                $addMonth = 1;
                break;
                 case 'Quarterly' :
                $addMonth = 3;
                break;
                 case 'Semi-Annually' :
                $addMonth = 6;
                break;
                 case 'Annually' :
                $addYear = 1;
                break;
        }

        return mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate)- $addMonth,
                                date('j', $startDate),
                                date('Y', $startDate)- $addYear
                            );
    }
    public function sendmail ($msg) {
        $to      = 'paisarn@netway.co.th';
        $subject = 'the subject DEBuG';

        $headers = 'From: webmaster@example.com' . "\r\n" .
            'Reply-To: webmaster@example.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();

        mail($to, $subject, $msg, $headers);

    }

    public function check_ip_update_na($ip)
	{
		$db = hbm_db();
		$sql = "
			SELECT
	            license_id,hb_acc,active
	        FROM
	            rvskin_license
	        WHERE
	            main_ip=:ip
	            OR second_ip=:ip
		";
		$getIP = $db->query($sql, array(':ip' => $ip))->fetch();
        $aProductPrepertual =  array(81, 82,92,93,88,89);
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
			//echo '<pre>';print_r($product);
			if (in_array($product['product_id'],$aProductPrepertual) && $getIP['active'] != 'yes') {
        		$sql2 = "
					UPDATE
			            rvskin_license
			        SET
			            main_ip = 'n/a.',
			            second_ip = 'n/a.',
			            pre_na_main_ip = :ip,
			            pre_na_second_ip = :ip
			        WHERE
			            license_id=:license_id
				";
				$getIPres 	= $db->query($sql2, array(':ip' => $ip,':license_id' => $getIP['license_id']));
				$aa 		= RVProductLicenseDao::singleton()->UpdateIpToNAFormCustomByAccid(
								array(
									'data'			=>'n/a.',
									'account_id' 	=> $getIP['hb_acc'],
									'ip_old'		=>$ip
									));
        	}
        }
	}

	private function creationChecker()
	{
		$aDetail        = $this->account_details;
		$db = hbm_db();

		$productId = $aDetail["product_id"];
		$acctId = $aDetail["id"];
		$status = $aDetail["status"];

		$productIdList = array(109, 111, 113);

		if(in_array($productId, $productIdList) && $status == "Pending Transfer"){
			$ip = $this->_findIPAddress();

			if($ip != ''){
				$chk = $db->query("
	        			SELECT
	        				*
	        			FROM
	        				rvskin_license
	        			WHERE
	        				main_ip = :ip
	        			", array(
	        				":ip" => $ip
	        			)
				)->fetchAll();

        		if(count($chk) > 0){
        			if($chk[0]["hb_acc"] != $acctId){
        				return true;
        			}
        			return false;
        		} else {
        			return false;
        		}
			}
		}

		return true;
	}


	/**
	 * This method is invoked automatically when creating an account.
	 * @return boolean true if creation succeeds
	 */
	public function Create() {
		$db 	= hbm_db();

        $aDetail        = $this->account_details;

        if (preg_match('/transfer/i', $aDetail['status']) && $this->creationChecker()) {
            return $this->_transfer();
        }

		if(isset($_POST['ip']) && $_POST['ip'] != '') {
			$sqlUpdateAcc = RVProductLicenseDao::singleton()->updateAccountByAccid($this->account_details['id'],$_POST['ip']);
			$this->account_config['ip']['value'] = $_POST['ip'];
		}
        $db_ip 		= $this->account_config['ip']['value'];
        $db_pb_ip	= $this->account_config['public_ip']['value'];
		if($db_pb_ip == '') $db_pb_ip = $db_ip;
        $aProduct 	= $this->product_details['options'];
        $billing 	=  $this->account_details['billingcycle'];
        if (isset($db_ip) && $db_ip != '') {
			if (isset($aProduct['Server Type']) && $aProduct['Server Type'] != '') {
				$db_license_type= ($aProduct['Server Type'] == 'VPS' ) ? 'VPS' : '';
				$db_acc_id 		= $this->account_details['id'];
				//edit for buy cpanel +free rvskin +free rvsitebuilder 20/04/2018 Arnut เพื่อให้ expire ตรงกับ rvsb เพิ่มตัวแปร next_due
				//$aExp 			= $this->calExpireDate($billing);
				$aExp 			= $this->calExpireDate($billing,$this->account_details['next_due']);
				$expiredate 	= $aExp['exp'];

				$resChk 	= $this->check_ip_update_na($db_ip);
				$eff_exp 	= $aExp['eff_exp'];
				$query  	= $db->query("
					INSERT INTO rvskin_license
						(license_type, user_id,hb_acc , main_ip, second_ip,   active,expire,effective_expiry)
					VALUES
					    (:license_type, :userid, :hb_acc, :main_ip, :second_ip, :active, :expire,:effect_exp)
					", array(
					':license_type' => $db_license_type,
					':userid' => '0',
					':hb_acc' => $db_acc_id,
					':main_ip' => $db_ip,
					':second_ip' => $db_pb_ip,
					':active' => 'yes',
					':expire' => $expiredate,
					':effect_exp' => $eff_exp
					));
                if ($query) {
                	return true;
                } else {
                     $this->addError('Error insert to rvskin : license_user');
                     return false;
                }
            } else {
                $this->addError('หาค่า Server Type ไม่เจอ (Dedicate/Vps)');
                return false;
            }

        } else {
            $this->addError('หาค่า ip ไม่เจอ');
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
                    '', NOW(), :accountId, :admin, 'rvskin_license', '0', 'Transfer Account',
                    :logs, '1', '', 'TransferAccount'
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':admin'            => isset($aAdmin['username']) ? $aAdmin['username'] : '',
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
                     rvskin_license rl
                WHERE
                    (rl.main_ip = :ip
                    OR rl.second_ip = :ip)
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
                rvskin_license
            SET
                hb_acc = :accountId
            WHERE
                license_id = :licenseId
            ", array(
                ':accountId'        => $accountId,
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
                '', NOW(), :accountId, :admin, 'rvskin_license', '0', 'Transfer Account',
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
            if ($arr['name'] == 'Server IP Address') {
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
		$db = hbm_db();
	   	if (!isset($this->account_details['id']) || $this->account_details['id']=='' || $this->account_details['id']==0) {
            $this->addError('ไม่มีค่า account id');
            return false;
        }
	    $accid =  $this->account_details['id'];
		$sql = "update rvskin_license set active='no' where hb_acc=:accid";
        $res = $db->query($sql,array(':accid'=>$accid));
	    if ($res) {
	        return true;
	    } else {
	        $this->addError('Error delete rvkin sql = ' . $sql);
	        return false;
	    }
	}

    public function Unsuspend()
    {
		$db = hbm_db();
       	if (!isset($this->account_details['id']) || $this->account_details['id']=='' || $this->account_details['id']==0) {
            $this->addError('ไม่มีค่า account id');
            return false;
        }
        $accid =$this->account_details['id'];

		$sql = "update rvskin_license set active='yes' where hb_acc=:accid";
        $res = $db->query($sql,array(':accid'=>$accid));
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
	    if (!isset($this->account_details['id']) || $this->account_details['id']=='' || $this->account_details['id']==0) {
                $this->addError('ไม่มีค่า account id');
                return false;
        }
	    $accid = $this->account_details['id'];

		$sql = "DELETE FROM rvskin_license WHERE hb_acc=:accid";
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
        $db = hbm_db();
        if ($this->account_details['next_due'] == '0000-00-00')  $this->account_details['next_due'] = '2030-01-07';
        $aExp 		= $this->calExpireDate($this->account_details['billingcycle'], $this->account_details['next_due']);
		$expiredate = $aExp['exp'];
		$eff_exp 	= $aExp['eff_exp'];
        $actdate 	= $this->calActivatedate($this->account_details['next_due'],$this->account_details['billingcycle']);

        $accid = $this->account_details['id'];

		$sql = "update rvskin_license set active='yes' , expire=:exp,effective_expiry=:eff_exp where hb_acc=:accid";
        $res = $db->query($sql,array(':exp'=>$expiredate,':eff_exp'=>$eff_exp,':accid'=>$accid));
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
	public function ChangePasswordff($newpassword)
	{
		return true;
	}

	/**
	 * This method is invoked when account should be upgraded/downgraded
	 * $options variable is loaded with new package configuration
	 * @return boolean true if action succeeded
	 */
	public function ChangePackageddd()
	{
		return true;
	}


	/**
	 * Auxilary method that HostBill will load to get plans from server:
	 * @see $options variable above
	 * @return array - list of plans to display in product configuration
	 **/
	public function getPlansdd()
	{
		$return = array();
		return $return;
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
