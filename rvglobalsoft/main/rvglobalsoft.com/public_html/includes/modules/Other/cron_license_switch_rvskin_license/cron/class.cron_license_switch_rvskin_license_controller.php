<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
 * function call_Hourly() will be executed by HostBill every hour
 * function call_Daily() will be executed by HostBill once a day
 * function call_Weekly() will be executed by HostBill once a week
 * function call_Monthly() will be executed by HostBill once a month
 */
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class cron_license_switch_rvskin_license_controller extends HBController {

    public $module;
    public $connsk;
    public $connsb;

    public $db = null;

    function call_Daily()
    {
    	$this->db = hbm_db();

    	$cat_id = $this->db->query("SELECT id FROM hb_categories WHERE name = 'Licenses'")->fetch();
    	$cat_id = $cat_id["id"];

    	$product_id_list = $this->db->query("SELECT * FROM hb_products WHERE category_id = :cat", array(":cat" => $cat_id))->fetchAll();

    	$rvskin_main_id_list = array(70, 71);
    	$rvskin_cpanel_id_list = array(109, 111, 113);

    	$success = 0;
    	$failed = 0;

    	$aList = array();
    	foreach($product_id_list as $eProduct){
    		$pid = $eProduct["id"];
    		if(in_array($pid, $rvskin_cpanel_id_list) || in_array($pid, $rvskin_main_id_list)){
    			$acctList = $this->db->query("
    					SELECT
    						a.id AS acct_id
    						, a.client_id
    						, a.order_id
    						, a.product_id
    						, a.next_due
    						, a.status
    						, c.data AS server_ip
    					FROM
    						hb_accounts AS a
    						, hb_config2accounts AS c
    						, hb_config_items_cat AS t
    					WHERE
    						a.product_id = :pid
    						AND c.account_id = a.id
    						AND a.product_id = t.product_id
    						AND t.name = 'Server IP Address'
    						AND c.config_cat = t.id
    			", array(":pid" => $pid))->fetchAll();
    			foreach($acctList as $eAcct){
    				$aList[$eAcct["server_ip"]][$eAcct["client_id"]][] = $eAcct;
    			}
    		}
    	}

    	foreach($aList as $server_ip => $sData){
    		foreach($sData as $client_id => $aData){
	    		foreach($aData as $eAData){
	    			if(
	    				(in_array($eAData["product_id"], $rvskin_main_id_list))
	    				&& ($eAData["status"] == "Active" || $eAData["status"] == "Suspended")
	    				&& strtotime($eAData["next_due"]) > strtotime('now')
	    			){
	    				$createResult = $this->activeRVSkin($eAData["acct_id"]);
	    				($createResult) ? $success++ : $failed++;
	    				continue 3;
	    			}
	    		}

	    		foreach($aData as $eAData){
	    			if(
    					(in_array($eAData["product_id"], $rvskin_cpanel_id_list))
    					&& ($eAData["status"] == "Active" || $eAData["status"] == "Suspended")
    					&& strtotime($eAData["next_due"]) > strtotime('now')
	    			){
	    				$createResult = $this->activeRVSkin($eAData["acct_id"]);
	    				($createResult) ? $success++ : $failed++;
	    				continue 3;
	    			}
	    		}
    		}
    	}

    	echo <<<EOF
Success : {$success} account.
Failed  : {$failed} account.
EOF;
    }

    private function activeRVSkin($acct_id)
    {
    	$api = new ApiWrapper();
    	$accountDetail = $api->getAccountDetails(array("id" => $acct_id));
    	if($accountDetail["success"]){

    		$detail = $accountDetail["details"];
    		$server_type = (isset($detail["options"]["Server Type"]) && $detail["options"]["Server Type"] == "VPS") ? "VPS" : "";
    		$billing_cycle = $detail["billingcycle"];
//     		$aExp = $this->calExpireDate($billing_cycle);
    		$dueDate = $detail["next_due"];
    		$aExp = $this->generateDueData($dueDate, $detail["product_id"]);
    		$expiredate = $aExp['exp'];
    		$eff_exp = $aExp['eff_exp'];
    		$client_id = $this->getUserSnd($detail["client_id"]);

    		foreach($detail["custom"] as $eCustom){
    			if(trim($eCustom["name"]) == "Server IP Address"){
    				foreach($eCustom["data"] as $eData){
    					$server_ip = $eData;
    				}
    			} else if(trim($eCustom["name"]) == "Public IP Address"){
    				foreach($eCustom["data"] as $pData){
    					$public_ip = $pData;
    				}
    			}
    		}

    		if(isset($server_ip)){
    			$resChk 	= $this->check_ip_update_na($server_ip);
    			$this->db->query("DELETE FROM rvskin_license WHERE main_ip = :mip", array(":mip" => $server_ip));
    			$getlicense = $this->db->query("SELECT * FROM rvskin_license WHERE main_ip = :ip", array(":ip" => $server_ip))->fetchAll();
    			if(!$getlicense){
	    			$query  	= $this->db->query("
						INSERT INTO rvskin_license
							(
	    						license_type
	    						, user_id
	    						, hb_acc
	    						, main_ip
	    						, second_ip
	    						, active
	    						, expire
	    						, effective_expiry
	    					)
						VALUES
						    (
	    						:license_type
	    						, :userid
	    						, :hb_acc
	    						, :main_ip
	    						, :second_ip
	    						, :active
	    						, :expire
	    						, :effect_exp
	    					)
						", array(
							':license_type' => $server_type,
	    					':userid' => $client_id,
	    					':hb_acc' => $acct_id,
	    					':main_ip' => $server_ip,
	    					':second_ip' => isset($public_ip) ? $public_ip : $server_ip,
	    					':active' => 'yes',
	    					':expire' => $expiredate,
	    					':effect_exp' => $eff_exp
	   				));
    			} else {
    				$this->db->query("
    						UPDATE
    							rvskin_license
    						SET
    							license_type = :type
    							, hb_acc = :acct
    							, second_ip = :second_ip
    							, active = 'yes'
    							, expire = :expire
    							, effective_expiry = :effect_exp
    						WHERE
    							main_ip = :main_ip
    				", array(
    						":type" => $server_type
    						, ":acct" => $acct_id
    						, ":second_ip" => isset($public_ip) ? $public_ip : $server_ip
    						, ":expire" => $expiredate
    						, ":effect_exp" => $eff_exp
    						, ":main_ip" => $server_ip
    				));
    			}

    			return true;
    		}
    	}
    	return false;
    }

    private function generateDueData($due, $pid)
    {
    	// SUSPEND - AutoSuspensionPeriod
    	// TERMINATE - AutoTerminationPeriod
    	$auto = $this->db->query("
    			SELECT
    				value
    			FROM
    				hb_automation_settings
    			WHERE
	    			item_id = :pid
	    			AND type = :type
	    			AND setting = :setting
    	", array(
    			":pid" => $pid
    			, ":type" => 'Hosting'
    			, ":setting" => 'AutoSuspensionPeriod'
    	))->fetch();
    	return array("exp" => strtotime($due), "eff_exp" => strtotime($due) + (60*60*24*$auto["value"]));
    }

    private function calExpireDate($billingCycle,$next_due_date='')
    {
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

    private function check_ip_update_na($ip)
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
        $aProductPrepertual =  array(81, 82, 92, 93, 88, 89);
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
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

	private function getUserSnd($client_id)
	{
		$getEmail = $this->db->query("SELECT email FROM hb_client_access WHERE id = :cid", array(":cid" => $client_id))->fetch();
		$email = $getEmail["email"];
		$aResult = $this->db->query('
			SELECT
				user_snd
			FROM
				snd_user
			WHERE
				user_email = :user_email
		', array(
					':user_email' => $email
			))->fetch();
			return isset($aResult['user_snd']) ? $aResult['user_snd'] : '0';
	}
}
