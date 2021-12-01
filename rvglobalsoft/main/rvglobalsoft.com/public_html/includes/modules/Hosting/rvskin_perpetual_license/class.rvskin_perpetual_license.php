<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvskin_perpetual_license extends HostingModule
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

	private function fixFormIP()
	{
		if (isset($this->account_details['parent_id']) && $this->account_details['parent_id'] > 0) {
			$api = new ApiWrapper();
			$params = array(
				'id'=> $this->account_details['parent_id']
			);
			$aParentAcct = $api->getAccountDetails($params);
			$data = $qty = null;
			if (isset($aParentAcct['details']['custom'])) {
				foreach ($aParentAcct['details']['custom'] as $k => $v) {
					if (strtolower($v['variable']) == 'ip') {
						$data = $v['data'][$v['items'][0]['id']];
						$qty = $v['qty'];
					}
				}
			}

			if ($data != null) {
				// Update Data from bundle to this acct
				if (isset($this->account_details['customforms']) && $this->account_details['customforms'] != array()) {
					$customformsId = null;
					foreach ($this->account_details['customforms'] as $k => $v) {
						if (strtolower($v['variable']) == 'ip') {
							$customformsId = $k;
						}
					}
					if ($customformsId != null) {
						$config_cat = $this->account_details['customforms'][$customformsId]['items'][0]['category_id'];
						$config_id = $this->account_details['customforms'][$customformsId]['items'][0]['id'];
						$db = hbm_db();
						$query  	= $db->query('
							INSERT INTO hb_config2accounts
								(rel_type, account_id, config_cat, config_id, qty, data)
							VALUES
								(:rel_type, :account_id, :config_cat, :config_id, :qty, :data)
						', array(
							':rel_type' => 'Hosting',
							':account_id' => $this->account_details['id'],
							':config_cat' => $config_cat,
							':config_id' => $config_id,
							':qty' => $qty,
							':data' => $data,
						));
						$this->account_details['customforms'][$customformsId]['values'] = array($config_id => $config_id);
						$this->account_details['customforms'][$customformsId]['data'] = array($config_id => $data);
						$this->account_details['customforms'][$customformsId]['qty'] = $qty;
						$this->account_config['ip']['value'] = $data;
					}
				}
			}
		}
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




    public function sendmail ($msg,$accid) {
        $to      = 'paisarn@netway.co.th';
        $subject = 'the subject DEBuG='.$accid;

        $headers = 'From: webmaster@example.com' . "\r\n" .
            'Reply-To: webmaster@example.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();

        mail($to, $subject, $msg, $headers);

    }

    public function check_ip_update_na($ip)
	{
		$db 	= hbm_db();
		$sql 	= "
			SELECT
	            license_id,hb_acc,active
	        FROM
	            rvskin_license
	        WHERE
	            (main_ip=:ip
	            OR second_ip=:ip )
                AND hb_acc IS NOT NULL
		";
		$getIP 				= $db->query($sql, array(':ip' => $ip))->fetch();
        $aProductPrepertual =  array(81, 82,92,93,88,89);
		$res 		= array();
		$res['res'] = true;
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
			//=== มี ip แต่ว่า เป็น supend ก็เอาให้คนอื่นไปเลย
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
				$getIPres = $db->query($sql2,array(':ip'=>$ip,':license_id'=>$getIP['license_id']));
				return $res;
        	} elseif($product == false) {
				   $sql3 = "
					DELETE FROM
			            rvskin_license
			        WHERE
			            main_ip = :ip
				";
				$testDelete = $db->query($sql3, array(':ip' => $ip));
				return $res;
        	} else {
				$res['res'] = false;
				$res['msg'] = 'ip มีแล้ว active อยู่';
			}
        }
        return $res;
	}

	private function fixFormIPinBundles()
	{
		if (isset($this->account_details['parent_id']) && $this->account_details['parent_id'] > 0) {
			$api = new ApiWrapper();
			$params = array(
				'id'=> $this->account_details['parent_id']
			);
			$aParentAcct = $api->getAccountDetails($params);
			$data = $qty = null;
			if (isset($aParentAcct['details']['custom'])) {
				foreach ($aParentAcct['details']['custom'] as $k => $v) {
					if (strtolower($v['variable']) == 'ip') {
						$data = $v['data'][$v['items'][0]['id']];
						$qty = $v['qty'];
					}
				}
			}

			if ($data != null) {
				// Update Data from bundle to this acct
				if (isset($this->account_details['customforms']) && $this->account_details['customforms'] != array()) {
					$customformsId = null;
					foreach ($this->account_details['customforms'] as $k => $v) {
						if (strtolower($v['variable']) == 'ip') {
							$customformsId = $k;
						}
					}
					if ($customformsId != null) {
						$config_cat = $this->account_details['customforms'][$customformsId]['items'][0]['category_id'];
						$config_id = $this->account_details['customforms'][$customformsId]['items'][0]['id'];
						$db = hbm_db();
						$query  	= $db->query('
							INSERT INTO hb_config2accounts
								(rel_type, account_id, config_cat, config_id, qty, data)
							VALUES
								(:rel_type, :account_id, :config_cat, :config_id, :qty, :data)
						', array(
							':rel_type' => 'Hosting',
							':account_id' => $this->account_details['id'],
							':config_cat' => $config_cat,
							':config_id' => $config_id,
							':qty' => $qty,
							':data' => $data,
						));
						$this->account_details['customforms'][$customformsId]['values'] = array($config_id => $config_id);
						$this->account_details['customforms'][$customformsId]['data'] = array($config_id => $data);
						$this->account_details['customforms'][$customformsId]['qty'] = $qty;
						$this->account_config['ip']['value'] = $data;
					}
				}
			}
		}
	}

	/**
	 * This method is invoked automatically when creating an account.
	 * @return boolean true if creation succeeds
	 */
	public function Create()
	{
		$this->fixFormIPinBundles();
		$db 			= hbm_db();
		$ip 			= (isset($_POST['ip']) && $_POST['ip'] != '') ? $_POST['ip'] : $this->account_config['ip']['value'];
		$sqlUpdateAcc 	= RVProductLicenseDao::singleton()->updateAccountByAccid($this->account_details['id'], $ip);

		$aChkip = $this->check_ip_update_na($ip);
		if ($aChkip['res'] == false) {
			$this->addError($aChkip['msg']);
			return false;
		} else {
			 $db_license_type 	= ($this->product_details['options']['Server Type'] == 'Dedicated') ? '' : 'VPS';
			 $accid     		= $this->account_details['id'];
			 $client_id 		= $this->account_details['client_id'];
			 $expiredate 		= 2068822800;//2035
			 $eff_date 			= 2068822800;//2035

             $sql_ins_license = "
                INSERT INTO rvskin_license
                    (license_type, user_id,hb_acc , main_ip, second_ip,   active,expire,effective_expiry)
                VALUES
                    ( :license_type , :userid ,:accid, :main_ip , :second_ip ,:active,:exp,:eff_date)
                ";
				$query = $db->query($sql_ins_license,array(
					':license_type'	=> $db_license_type,
					':userid'		=> '0',
					':accid'		=> $accid,
					':main_ip'		=> $ip,
					':second_ip'	=> $ip,
					':active'		=> 'yes',
					':exp'			=> $expiredate,
					':eff_date'		=> $eff_date
				));

                if ($query) {
                	$resupdateQuota = RVProductLicenseDao::singleton()->update_licenes_quota(
                		array(
                			'client' 	=> $client_id,
                			'itype'		=> $db_license_type,
                			'dt_update'	=> time()
							));
					return true;
                } else {
                	$this->addError('Error insert to rvskin add license');
                	return false;
                }
			return false;
		}
	}

	/**
	 * This method is invoked automatically when suspending an account.
	 * @return boolean true if suspend succeeds
	 */
	public function Suspend()
	{
		// ทำเพื่อให้ปรับ วันที่ 	activate date ที่เคยผิด
		$db = hbm_db();
		$next_due_date = $this->account_details['next_due'];
		date_default_timezone_set('UTC');
        if ($next_due_date != '') {
            $startDate = strtotime($next_due_date);
        }
		$aDate['activate_date'] = mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate),
                                date('j', $startDate),
                                date('Y', $startDate) - 1
                            );
		$id = $this->account_details['id'];
		$ip 			=  $this->account_config['ip']['value'];
		$res = $this->testConnection();
		if ($res == false) {
			return false;
		}

		$sql 			= "update rvskin_license set active='no' where hb_acc=:accid AND main_ip = :ip";
        $res_updateSK 	= $db->query($sql,array(':accid' => $id, ':ip' => $ip));
		if ($res_updateSK) {
			return true;
		} else {
			$this->addError('มีปัญหากับ database rvskin');
			return false;
		}
		return true;
	}

    public function Unsuspend()
    {
        $this->Renewal();
    	return true;
    }

	/**
	 * This method is invoked automatically when terminating an account.
	 * @return boolean true if termination succeeds
	 */
	public function Terminate()
	{
	    return true;
	}
	 private function calExpiredate($next_due_date=''){
        //24/09/2013
        date_default_timezone_set('UTC');
        if ($next_due_date != '') {
            $startDate = strtotime($next_due_date);
        }
		if ($startDate < time()) {
			$startDate = time();
		}

        $aDate['exp'] = mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate),
                                date('j', $startDate),
                                date('Y', $startDate) + 1
                            );
		 $aDate['act'] = $startDate;
	     $aDate['eff'] = mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate),
                                date('j', $startDate)+3,
                                date('Y', $startDate) + 1
                            );
		$aDate['due_date'] = date("Y-m-d",$aDate['exp']);
		return $aDate;
    }

    public function Renewal()
    {
        // ดูวัน due_date ถ้าน้อยกว่าวันปัจจุบัน ก็เอาวัน ปัจจุบัน + 1 ปี
        $db 		= hbm_db();
        $due_date 	= $this->account_details['next_due'];
		$accid 		= $this->account_details['id'];
		$ip 		= $this->account_config['ip']['value'];
		$aDate 		= $this->calExpiredate($due_date);

		$res_updateSK = $db->query("
			UPDATE
				rvskin_license l
			SET
				l.active = 'yes'
		        , l.main_ip = :main_ip
		        , l.expire  = :expire
		        , l.effective_expiry = :effective_expiry
			WHERE
			    l.hb_acc = :accid
			", array(
			    ':accid' => $accid
			    , ':main_ip' => $ip
			    , ':expire' => $aDate['exp']
			    , ':effective_expiry' => $aDate['eff']
			)
		);

		if ($res_updateSK) {
			$datenow 		= time();
			$resAddInvItem 	= RVProductLicenseDao::singleton()->save_log_renew(
				array(
					'account_id'	=> $accid,
					'itype'			=> 'renewaled',
					'dt_update'		=> $datenow
					));

			$resUpDueDate = RVProductLicenseDao::singleton()->updateNextDueAccount(array('id' => $accid, 'next_due' => $aDate['due_date']));
        	if ($resUpDueDate==true) {
				return true;
        	} else {
        		$this->addError('update SK complete , error update hostbill due_date for account = '.$accid);
        		return false;
        	}

		} else {
        	$this->addError('error update expire rvskin for account = '.$accid);
        	return false;
        }
        // ถ้า มากกกว่า วันปัจจุบัน ก็เอา วัน due_date +1 ปี
        return true;
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

}
