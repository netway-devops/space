<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
 * function call_Hourly() will be executed by HostBill every hour
 * function call_Daily() will be executed by HostBill once a day
 * function call_Weekly() will be executed by HostBill once a week
 * function call_Monthly() will be executed by HostBill once a month
 */
class rv_symantecvip_controller extends HBController {

    public $module;
    public $connsk;
    public $connsb;

    function call_Daily(){
     	$db = hbm_db();
     	$nowMinus45 = date('Y-m-d', strtotime('-45 days'));
     	$accountList = $db->query("
     								SELECT
     									id
     									, date_created
     								FROM
     									hb_accounts
     								WHERE
     									product_id = 58
     									AND status != 'Terminated'
     									AND date_created < :nowMinus45
     									ORDER BY id ASC
     								", array(
     									':nowMinus45' => $nowMinus45
     								)
     	)->fetchAll();

		if(sizeof($accountList) > 0){
			require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

			//$accountList = array();
			$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
			foreach($accountList as $k => $v){
				$VipItemInfo = $db->query("
    									SELECT
    										va.vip_acct_id AS vip_acct_id
											, usr_id
    									FROM
    										hb_vip_info AS vi,
    										hb_vip_acct AS va
    									WHERE
    										vi.vip_info_id = va.vip_info_id
    										AND vi.account_id = :account_id
										", array(
    										':account_id' => $v['id'],
    									)
				)->fetchAll();
    			if (count($VipItemInfo) > 0) {
					foreach ($VipItemInfo as $k2 => $v2) {
						/// Delete VIP Account
						$_SESSION['AppSettings']['login']['cron_login'] = $v2['usr_id'];
						$rvAddApi = $oAuth->request('post', '/vipmanageuser',
    						array(
    								'vip_acct_id' => $v2['vip_acct_id'] ,
    								'action_do' => 'deletevipacct'
    						)
    					);
						unset($_SESSION['AppSettings']['login']['cron_login']);
					}
					$accountList[] = $v['id'];
				}
				$this->updateTerminateStatus($v['id']);

				$parentList = $db->query("
										SELECT
											id
											, client_id
										FROM
											hb_accounts
										WHERE
											parent_id = :parent_id
											AND product_id IN (60, 61)
										", array(
											':parent_id' => $v['id']
										)
				)->fetchAll();
				foreach($parentList as $k3 => $v3){
					$VipItemInfoCpApp = $db->query("
											SELECT
												va.vip_acct_id AS vip_acct_id
												, va.vip_info_cp_apps_id
												, usr_id
											FROM
												hb_vip_info_cp_apps AS vc,
						    					hb_vip_acct AS va
						    				WHERE
						    					vc.vip_info_cp_apps_id = va.vip_info_cp_apps_id
						    					AND vc.account_id = :account_id
											", array(
												':account_id' => $v3['id'],
											)
					)->fetchAll();
					if (count($VipItemInfoCpApp) > 0) {
						foreach ($VipItemInfoCpApp as $k4 => $v4) {
							/// Delete VIP Account
							$_SESSION['AppSettings']['login']['cron_login'] = $v3['client_id'];
							$rvAddApiCpApp = $oAuth->request('post', '/vipmanageuser',
															array('vip_acct_id' => $v4['vip_acct_id'] ,
																	'action_do' => 'deletevipacct' ,
																	'vip_info_cp_apps_id' => $v4['vip_info_cp_apps_id']
															)
							);
							unset($_SESSION['AppSettings']['login']['cron_login']);
						}
					}
					$this->updateTerminateStatus($v3['id']);
				}
    		}
    		if(sizeof($accountList) > 0){
    			$this->createTickets($accountList);
    		}
		}
	}

	function updateTerminateStatus($accountId){
		$db = hbm_db();
		$db->query("
					UPDATE
						hb_accounts
					SET
						status = 'Terminated'
						,date_changed = :dateChange
					WHERE
						id = :acctId
				", array(
					':acctId' => $accountId,
					':dateChange' => date('Y-m-d H:i:s', strtotime('now'))
				)
		);
	}

	function createTickets($accountList){
		require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');

		$db = hbm_db();

		$url = 'https://rvglobalsoft.com/7944web/?cmd=accounts&action=edit&id=';
		$content = 'RV2Factor trial account terminated revoke list : <br /><br />';

		$i = 1;
		foreach($accountList as $v){
			$vipCertName = $db->query("
					SELECT
						hvi.certificate_file_name AS whm
						, hvi.account_id AS whm_acct_id
						, hca.certificate_file_name AS cpApp
						, hca.account_id AS cpApp_acct_id
					FROM
						hb_vip_info AS hvi
						, hb_vip_info_cp_apps AS hca
					WHERE
						hvi.account_id = :acctId
						AND hvi.usr_id = hca.usr_id
				", array(
									':acctId' => $v,
							)
			)->fetchAll();
			$content .= $i++ . '. <br /><a href="' . $url . trim($vipCertName[0]['whm_acct_id']) . '" target="_blank">' . trim($vipCertName[0]['whm']) . '</a><br />';
			foreach($vipCertName as $kk => $vv){
				$content .= '<a href="' . $url . trim($vv['cpApp_acct_id']) . '" target="_blank">' . trim($vv['cpApp']) . '</a><br />';
			}
			$content .= '<br />';
		}

		$mail = new PHPMailerNew();
		$mail->From = 'rvtwofactorteam@rvglobalsoft.com';                       // Sender Email
		$mail->FromName = 'RV2Factor Team';                                   // Sender Name
		$mail->AddAddress('rv2factor@tickets.rvglobalsoft.com');                                         // To
		$mail->Subject = 'RV2Factor : Trial product terminated by cron';                                  	// Subject
		//      $mail->AddCC($email_1);                                     	// Cc
		$mail->Body = $content;

		$mail->ISHTML(true);

		$mail->Send();
	}
}
?>