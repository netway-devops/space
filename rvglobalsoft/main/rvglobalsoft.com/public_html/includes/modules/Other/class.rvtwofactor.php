<?php 
# WebSite:  https://rvglobalsoft.com/rv2factor
# Unauthorized copying is strictly forbidden and may result in severe legal action.
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
#
# =====YOU MUST KEEP THIS COPYRIGHTS NOTICE INTACT AND CAN NOT BE REMOVE =======
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
# This Agreement is a legal contract, which specifies the terms of the license
# and warranty limitation between you and RV Global Soft Co.,Ltd. and RV2Factor for Apps Product for RV Global Soft.
# You should carefully read the following terms and conditions before
# installing or using this software.  Unless you have a different license
# agreement obtained from RV Global Soft Co.,Ltd., installation or use of this software
# indicates your acceptance of the license and warranty limitation terms
# contained in this Agreement. If you do not agree to the terms of this
# Agreement, promptly delete and destroy all copies of the Software.
#
# =====  Grant of License =======
# The Software may only be installed and used on a single host machine.
#
# =====  Disclaimer of Warranty =======
# THIS SOFTWARE AND ACCOMPANYING DOCUMENTATION ARE PROVIDED "AS IS" AND
# WITHOUT WARRANTIES AS TO PERFORMANCE OF MERCHANTABILITY OR ANY OTHER
# WARRANTIES WHETHER EXPRESSED OR IMPLIED.   BECAUSE OF THE VARIOUS HARDWARE
# AND SOFTWARE ENVIRONMENTS INTO WHICH RV SITE BUILDER MAY BE USED, NO WARRANTY OF
# FITNESS FOR A PARTICULAR PURPOSE IS OFFERED.  THE USER MUST ASSUME THE
# ENTIRE RISK OF USING THIS PROGRAM.  ANY LIABILITY OF RV GLOBAL SOFT CO.,LTD. WILL BE
# LIMITED EXCLUSIVELY TO PRODUCT REPLACEMENT OR REFUND OF PURCHASE PRICE.
# IN NO CASE SHALL RV GLOBAL SOFT CO.,LTD. BE LIABLE FOR ANY INCIDENTAL, SPECIAL OR
# CONSEQUENTIAL DAMAGES OR LOSS, INCLUDING, WITHOUT LIMITATION, LOST PROFITS
# OR THE INABILITY TO USE EQUIPMENT OR ACCESS DATA, WHETHER SUCH DAMAGES ARE
# BASED UPON A BREACH OF EXPRESS OR IMPLIED WARRANTIES, BREACH OF CONTRACT,
# NEGLIGENCE, STRICT TORT, OR ANY OTHER LEGAL THEORY. THIS IS TRUE EVEN IF
# RV GLOBAL SOFT CO.,LTD. IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO CASE WILL
# RV GLOBAL SOFT CO.,LTD.'S LIABILITY EXCEED THE AMOUNT OF THE LICENSE FEE ACTUALLY PAID
# BY LICENSEE TO RV GLOBAL SOFT CO.,LTD.
# ===============================

?>
<?php 
//require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
//require_once HBFDIR_LIBS . 'RvLibs/oAuth/RSA_SHA1.php';

define("VIP_MOD_DIR","Rvtwofactor");
define('RVGLOBALSTORE_API_URL', 'http://api.rvglobalsoft.com/apps');
define('RV_APPS_ID', 'hostbill');
set_include_path(HBFDIR_LIBS. 'pear' . PATH_SEPARATOR . dirname(__FILE__) . '/' . VIP_MOD_DIR . '/Lib-oAuthConnect/PHP/pear' . PATH_SEPARATOR . dirname(__FILE__) . '/' . VIP_MOD_DIR . '/Lib-oAuthConnect/PHP/RvLibs' . PATH_SEPARATOR . get_include_path());

if (!class_exists('PEAR',false)) {
	require_once 'PEAR.php';
}

require_once dirname(__FILE__) . '/' . VIP_MOD_DIR . '/Lib-oAuthConnect/PHP/RvLibs/RvGlobalStoreApi.php';

class rvtwofactor extends OtherModule
{
	protected $info = array(
			'haveadmin' => true,    //is module accessible from adminarea
			'haveuser' => true,     //is module accessible from client area
			'havelang' => false,     //does module support multilanguage
			'havetpl' => true,      //does module have template
			'havecron' => false,     //does module support cron calls
			'haveapi' => false,      //does module have functions accessible via api
			'needauth' => false,     //does module needs authorisation by clients to use it
			'isobserver' => false,   //is module an observer - must implement Observer interface!
			'clients_menu' => false, //should module be listed in adminarea->clients menu
			'support_menu' => false,  //should module be listed in adminarea->support menu
			'payment_menu' => false,  // should module be listed in adminarea->payments menu
			'orders_menu' => false,   //should module be listed in adminarea->orders menu
			'extras_menu' => true,    //should module be listed in extras menu
			'mainpage' => false,       //should module be listed in admin home screen and/or clientarea root screen
			'header_js' => false,     //does module have getHeaderJS function - add header javascript code to admin/clientarea
	);

	//const NAME = '2factor_authentication';

	protected $filename='class.rvtwofactor.php';
	protected $description='RV2Factor - 2 Factor Authentication by RV Globalsoft Co., Ltd.';
	protected $modname = 'RV2Factor';
	protected $moddirname = 'Rvtwofactor';
	
	private function testAPIConnection()
	{   
		// --- hostbill helper ---
		$db         = hbm_db();
		
	}
	
	public function show_info($message='')
	{
		$this->addInfo($message);	
	}
	
	public function doSetting() 
	{
		/* old code
		$db         = hbm_db();
		
		$sql_setup = "CREATE TABLE IF NOT EXISTS `vip_setting` (
						  `setting_id` int(4) NOT NULL AUTO_INCREMENT,
						  `license_agreement_status` int(4) NOT NULL DEFAULT '0',
						  `enable_vip_service` int(4) NOT NULL DEFAULT '0',
						  `enable_vip_service_admin` int(4) NOT NULL DEFAULT '0',
						  `vip_user_prefix` varchar(32) DEFAULT NULL,
						  `app_user_id` text NOT NULL,
						  `app_access_key` text NOT NULL,
						  `certificate_file_content_p12` text NOT NULL,
						  `certificate_file_password_p12` varchar(100) NOT NULL,
						  `remember_device_status` varchar(20) NOT NULL DEFAULT 'DISABLED',
	  					  `remember_device_day` int(4) NOT NULL DEFAULT '0',
						  `app_version` varchar(100) NOT NULL DEFAULT '1.0.0',
						  `created_date` int(11) NOT NULL,
						  `updated_date` int(11) NOT NULL,
						  PRIMARY KEY (`setting_id`)
						) ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
		
		if ($db->query($sql_setup)) {
			$sql_s = "SELECT * FROM vip_setting where setting_id = 1 ";
			$res = $db->query($sql_s)->fetch();
			if($res['setting_id'] == '') {
				
				$version_txt = file_get_contents(APPDIR_MODULES."Other/Rvtwofactor/Symantec/version.txt");
								
								
				$sql_ins = "INSERT INTO vip_setting (license_agreement_status , 
													 enable_vip_service , 
													 enable_vip_service_admin ,
													 app_version ,
													 created_date ,
													 updated_date) 
										VALUES ( 0 , 
												 0 ,
												 0 ,
												 '".$version_txt."' ,
												 ".time()." ,
												 ".time()."
										)";
				$db->query($sql_ins);
			}
		}
		
		$sql_setup2 = "CREATE TABLE IF NOT EXISTS `vip_user_detail` (
					  `user_detail_id` int(11) NOT NULL AUTO_INCREMENT,
					  `user_login` varchar(60) NOT NULL,
					  `enable_status` int(4) NOT NULL DEFAULT '0',
					  `user_type` varchar(20) NOT NULL DEFAULT 'CLIENT' COMMENT 'CLIENT,ADMIN',
					  PRIMARY KEY (`user_detail_id`)
					) ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
		$db->query($sql_setup2);
		
		
		$sql_setup3 = "CREATE TABLE IF NOT EXISTS `vip_user_access` (
					  `acc_id` int(20) NOT NULL AUTO_INCREMENT,
					  `session_id` varchar(100) NOT NULL,
					  `client_ip` varchar(50) NOT NULL,
					  `user_login` varchar(100) NOT NULL,
					  `http_user_agent` varchar(200) NOT NULL,
					  `cookie_expire` int(11) NOT NULL DEFAULT '0',
					  PRIMARY KEY (`acc_id`)
					) ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
		$db->query($sql_setup3);
		*/
		
		if ($this->doSetting_create_table1()) {
			if($this->doSetting_select_table1() == 0) {
				$this->doSetting_insert_table1();
			}
		}
		
		$this->doSetting_create_table2();
		$this->doSetting_create_table3();

	}
	
	
	//========= extract form doSetting() =====================
	public function doSetting_create_table1()
	{
		$db         = hbm_db();
		$sql_setup = "CREATE TABLE IF NOT EXISTS `vip_setting` (
						  `setting_id` int(4) NOT NULL AUTO_INCREMENT,
						  `license_agreement_status` int(4) NOT NULL DEFAULT '0',
						  `enable_vip_service` int(4) NOT NULL DEFAULT '0',
						  `enable_vip_service_admin` int(4) NOT NULL DEFAULT '0',
						  `vip_user_prefix` varchar(32) DEFAULT NULL,
						  `app_user_id` text NOT NULL,
						  `app_access_key` text NOT NULL,
						  `certificate_file_content_p12` text NOT NULL,
						  `certificate_file_password_p12` varchar(100) NOT NULL,
						  `remember_device_status` varchar(20) NOT NULL DEFAULT 'DISABLED',
	  					  `remember_device_day` int(4) NOT NULL DEFAULT '0',
						  `app_version` varchar(100) NOT NULL DEFAULT '1.0.0',
						  `created_date` int(11) NOT NULL,
						  `updated_date` int(11) NOT NULL,
						  PRIMARY KEY (`setting_id`)
						) ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
		
		if ($db->query($sql_setup)) {
			return true;
		} else {
			return false;
		}
	}
	
	public function doSetting_select_table1()
	{
		//$db         = hbm_db();
		//$sql_s = "SELECT * FROM vip_setting where setting_id = '1' ";
		$res = $this->get_vip_setting(); //$db->query($sql_s)->fetch();
		if(isset($res['setting_id']) && ($res['setting_id'] != '')) {
			return $res['setting_id'];
		} else {
			return 0;
		}
	}
	
	public function doSetting_insert_table1()
	{
		$db         = hbm_db();
		// get version from file
		$version_txt = file_get_contents(APPDIR_MODULES."Other/Rvtwofactor/Symantec/version.txt");		
		$sql_ins = "INSERT INTO vip_setting (license_agreement_status , 
											 enable_vip_service , 
											 enable_vip_service_admin ,
											 app_version ,
											 created_date ,
											 updated_date) 
								VALUES ( 0 , 
										 0 ,
										 0 ,
										 '".$version_txt."' ,
										 ".time()." ,
										 ".time()."
								)";
		if($db->query($sql_ins)) {
			return true;
		} else {
			return false;
		}
	}
	
	public function doSetting_create_table2()
	{
		$db         = hbm_db();
		$sql_setup2 = "CREATE TABLE IF NOT EXISTS `vip_user_detail` (
					  `user_detail_id` int(11) NOT NULL AUTO_INCREMENT,
					  `user_login` varchar(60) NOT NULL,
					  `enable_status` int(4) NOT NULL DEFAULT '0',
					  `user_type` varchar(20) NOT NULL DEFAULT 'CLIENT' COMMENT 'CLIENT,ADMIN',
					  PRIMARY KEY (`user_detail_id`)
					) ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
		if($db->query($sql_setup2)) {
			return true;
		} else {
			return false;
		}
	}
	
	public function doSetting_create_table3()
	{
		$db         = hbm_db();
		$sql_setup3 = "CREATE TABLE IF NOT EXISTS `vip_user_access` (
					  `acc_id` int(20) NOT NULL AUTO_INCREMENT,
					  `session_id` varchar(100) NOT NULL,
					  `client_ip` varchar(50) NOT NULL,
					  `user_login` varchar(100) NOT NULL,
					  `http_user_agent` varchar(200) NOT NULL,
					  `cookie_expire` int(11) NOT NULL DEFAULT '0',
					  PRIMARY KEY (`acc_id`)
					) ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
		if($db->query($sql_setup3)) {
			return true;
		} else {
			return false;
		}
	}
	
	//================ process_agree($Array) ====================
	public function process_agree($Array) 
	{
		$aData = $Array;
		$db = hbm_db();
		if($Array['agree_li'] != '') {
			$sql_up = "UPDATE vip_setting 
						SET license_agreement_status = '".$Array['agree_li']."' 
						WHERE setting_id = '1' ";
			$db->query($sql_up);
		}
	}
	
	//================ get_license_agree() ====================
	public function get_license_agree()
	{
		$db = hbm_db();
		//$sqln = "SELECT * FROM vip_setting WHERE setting_id = 1";
		$res_set = $this->get_vip_setting(); // $db->query($sqln)->fetch();
		if ($res_set['license_agreement_status'] == 0) {
			$show_license = true;
		} else {
			$show_license = false;
		}
		return $show_license;
    }
    
    //================ get_vip_setting() ====================
    public function get_vip_setting()
	{
		$db = hbm_db();
		$sqln = "SELECT * FROM vip_setting WHERE setting_id = '1' ";
		$res_set = $db->query($sqln)->fetch();
		return $res_set;
    }
    
    
    public function get_cp_from_file()
    {
    	$doc_root = explode("/" , $_SERVER['DOCUMENT_ROOT']);
		$doc_root_home_cpuser = "/".$doc_root[1]."/".$doc_root[2]."/.rvglobalsoft";
		
		$f1 = $doc_root_home_cpuser."/cp_authorizeid.pub";
		$f2 = $doc_root_home_cpuser."/cp_authorizekey.pub";
		
		$cpuser_id = "";
		$cp_public_key = "";
		
		if ( file_exists($f1) && file_exists($f2) ) {
			$cpuser_id = file_get_contents($f1);
			$cp_public_key = file_get_contents($f2);
		}
		$aData = array();
		$aData['cpuser_id'] = $cpuser_id;
		$aData['cp_public_key'] = $cp_public_key;
		return $aData;
    }
    
	public function get_connection_result()
	{
		/*
		$doc_root = explode("/" , $_SERVER['DOCUMENT_ROOT']);
		$doc_root_home_cpuser = "/".$doc_root[1]."/".$doc_root[2]."/.rvglobalsoft";
		
		$f1 = $doc_root_home_cpuser."/cp_authorizeid.pub";
		$f2 = $doc_root_home_cpuser."/cp_authorizekey.pub";
		
		$cpuser_id = "";
		$cp_public_key = "";
		*/
		//if ( file_exists($f1) && file_exists($f2) ) {
		
		$aCp = $this->get_cp_from_file();
		

		$cpuser_id = $aCp['cpuser_id'];
		$cp_public_key = $aCp['cp_public_key'];
			
		$authurize_user_id = "";
		$api_access_key = "";	
		// --- hostbill helper ---
		$db = hbm_db();

		if (($cpuser_id != '') && ($cp_public_key != '') ) {
				
			//if (($cpuser_id != '') && ($cp_public_key != '')) {
					
				$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
				$oAuthAPI = RvLibs_RvGlobalStoreApi::request_authorizekey(RVGLOBALSTORE_API_URL, $cpuser_id, $cp_public_key);

				$authurize_user_id = $oAuthAPI['authorizeid'];
				$api_access_key = $oAuthAPI['authorizekey'];

				//=====================
				if (($authurize_user_id != '') && ($api_access_key != '')) {

					$date2 = time();

					$sqlt = "UPDATE
								vip_setting
				  			 SET 
					  			app_user_id = '".$authurize_user_id."'
					  			, app_access_key = '".$api_access_key."' 
					  			, updated_date = ".$date2." 
				  			 WHERE setting_id = '1' ";

					$db->query($sqlt);
				}

				$ress = $this->get_vip_setting();
				$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $ress['app_user_id'], $ress['app_access_key']);

				$aData = array();
				$aData['cpuser_id'] = $cpuser_id;
				$aData['cp_public_key'] = $cp_public_key;

				$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('get', '/serverinfo', array());
		
				if (isset($oRes) && ($oRes != '')) {
					$conn_res = "<font color='#0B9E1F'><strong>Connected</strong></font>";
					$save_button = "<input type='Submit' value='Save'  disabled  />";
					$oRes_cert = RvLibs_RvGlobalStoreApi::singleton()->request('get'
																				, '/vipuserinfo'
																				, array( 'action_do' => 'get_cert_file_by_apps' ,
																		  				'appsuser_id' => $authurize_user_id 
																			            )
																			   );


					$res_c = (array)$oRes_cert;

					if ($res_c['status'] == 'success') {

						$aData['con_result'] = "<font color='#0B9E1F'><strong>Connected</strong></font>";
						// save cer file + password to db
						$sqlcc = "UPDATE
										vip_setting
							  		SET 
							  		    vip_user_prefix = 'vip".$res_c['usr_id']."_'
							  			, certificate_file_content_p12 = '".$res_c['data_content']."'
							  			, certificate_file_password_p12 = '".$res_c['cer_password_p12']."' 
							  		WHERE setting_id = '1' ";

						$db->query($sqlcc);

						$PRO_FILE_PATH = dirname(__FILE__) . '/' . $this->moddirname;

						$path_cer_temp = $PRO_FILE_PATH."/temp";
						if (!is_dir($path_cer_temp)) {
							mkdir($path_cer_temp, 0777);
						}

						$path_cer_file = $PRO_FILE_PATH."/temp/vip_cert.pem";

						if (file_exists($path_cer_file)) {
							unlink($path_cer_file);
						}

						$handle = fopen($path_cer_file , 'w');
						fwrite ($handle, $res_c['data_content_pem']);
						fclose ($handle);

						$path_cer_pass_file = $PRO_FILE_PATH."/temp/cerPasswd.txt";

						if (file_exists($path_cer_pass_file)) {
							unlink($path_cer_pass_file);
						}
						$handle = fopen($path_cer_pass_file , 'w');
						fwrite ($handle, $res_c['cer_password_pem']);
						fclose ($handle);

						$aData['save_but'] = "<input type='Submit' name='make_cp_file' value='Save' class='new_control greenbtn' />";
						$aData['show_next_step3'] = true;
						$aData['show_save_but_step2'] = true;

					} else {
						$aData['con_result'] = "<font color='#FF0000'><strong>Disconnected</strong></font>";
						$aData['save_but'] = "<input type='Submit' name='make_cp_file' value='Save' class='new_control greenbtn' />
								<br />Please go to cPanel -> Security -> RV2Factor -> cPanel Apps Management -> Access Key, to copy Security ID and Security Key to insert here.";
						$aData['show_save_but_step2'] = true;
					}

				} else {
					$aData['con_result'] = "<font color='#FF0000'><strong>Disconnected</strong></font>";
					$aData['save_but'] = "<input type='Submit' name='make_cp_file' value='Save' class='new_control greenbtn'  /><br />
								Please go to cPanel -> Security -> RV2Factor -> cPanel Apps Management -> Access Key, to copy Security ID and Security Key to insert here.";
					$aData['show_save_but_step2'] = true;
				}
				//==========
			//}

			return $aData;

		} else {
			$aData['con_result'] = "<font color='#FF0000'><strong>Disconnected</strong></font>";
			$aData['save_but'] = "<input type='Submit' name='make_cp_file' value='Save' class='new_control greenbtn' /><br />
				Please go to cPanel -> Security -> RV2Factor -> cPanel Apps Management -> Access Key, to copy Security ID and Security Key to insert here.";
			$aData['show_save_but_step2'] = true;
			
			return $aData;
		}
	}
	
	//============== make_cp_file($aData) ==================
	public function make_cp_file($aData) {
		
		$doc_root = explode("/" , $_SERVER['DOCUMENT_ROOT']);
		$doc_root_home_cpuser = "/".$doc_root[1]."/".$doc_root[2]."/.rvglobalsoft";
		
		$f1 = $doc_root_home_cpuser."/cp_authorizeid.pub";
		$f2 = $doc_root_home_cpuser."/cp_authorizekey.pub";
		
		$handle = fopen($f1 , 'w');
		fwrite ($handle, $aData['cpuser_id']);
		fclose ($handle);
		
		$handle2 = fopen($f2 , 'w');
		fwrite ($handle2, $aData['cppublic_key']);
		fclose ($handle2);
	}
	
	//================ get_admin_vip_on_hb($admin_login) ====================
	public function get_admin_vip_on_hb($admin_login)
	{
		$db = hbm_db();
		$sqln = "SELECT COUNT(user_login) AS cnt_login 
					FROM vip_user_detail
					WHERE user_type = 'ADMIN' 
					AND user_login = '".$admin_login."' ";
		$result = $db->query($sqln)->fetch();
		//$cntRow = count($result);
		return $result['cnt_login'];
	}
	
	//============== get_vip_user_detail_by_id($client_id,$user_type) ==================
	public function get_vip_user_detail_by_id($client_id,$user_type)
	{
		$db = hbm_db();
		$sqln = "SELECT * 
					FROM vip_user_detail 
					WHERE user_login = '".$client_id."' 
					AND user_type = '".$user_type."' ";
		$result = $db->query($sqln)->fetch();
		return $result;
	}
	
	
	public function addacct_with_cred($aPOST)
	{
		$db = hbm_db();
		$ress = $this->get_vip_setting();
		$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
		$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $ress['app_user_id'], $ress['app_access_key']);

		$aData = array();
		//$aData['cpuser_id'] = $cpuser_id;
		//$aData['cp_public_key'] = $cp_public_key;

		$appsuser_id = $ress['app_user_id'];
		$admin_login = $_SESSION['AppSettings']['admin_login']['id'];
			
		//======================== process add vip start ====================
		$req_id = time();
		$userId = $appsuser_id."_admin_".$admin_login;
		$credential_type = "STANDARD_OTP";
		$friendlyName = $aPOST['vip_acct_comment'];
		$credentialId = strtoupper($aPOST['credentialId']);
		$vip_acct_comment = $admin_login;

		// === add vip acct with cred =====//

		$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post',
						 '/vipuserinfo', array(
												'action_do' => 'addacct_with_cred_app' , 
												'vip_cred' => $credentialId , 
												'vip_cred_comment' => $friendlyName , 
												'vip_acct_name' => $userId ,
												'vip_acct_comment' => $vip_acct_comment ,
												'appsuser_id' => $appsuser_id , 
												'vip_cred_type' => $credential_type
		));
		$oResR = (array) $oRes;

		if( $oResR['status'] == 'success' ) {
			// add user to vip_user_detail
			$vip_acct_id = $oResR['vip_acct_id'];

			if($this->add_vip_user_detail($admin_login)) { 
				$add_status = true;
				$validate_form = '
									<div class="wrap">
									
									<center>
									<br /><br />
									
									<strong>Validate Credential ID</strong>
									
									<br />Insert your security code to confirm adding credential.
									
									<br />
									
									<script type="text/javascript">
										function chk_val_frm(frm) {
											if(frm.otp.value=="") {
												alert("Please type Security Code");
												frm.otp.focus();
												return false;
											}
											return true;
										}
									</script>
								
									<script type="text/javascript">
										window.onload = function() {
									  		document.getElementById("otp").focus();
										};
									</script> 							
								
									
									<form name="validate_cred" method="post" action="" onsubmit="return chk_val_frm(this)">
									
									<input type="hidden" name="userId" value="'.$appsuser_id.'">
									<input type="hidden" name="vip_acct_id" value="'.$vip_acct_id.'">
									<input type="hidden" name="credentialId" value="'.$credentialId.'">
									
									<table class="widefat page fixed" cellspacing="0">
									<tr>
										<td align=right>Credential ID : </td>
										<td>'.$credentialId.'</td>
									</tr>
									
									<tr>
										<td align=right>Security Code : </td>
										<td><input type="text" name="otp" id="otp" MAXLENGTH="6"></td>
									</tr>
									
									<tr>
										<td> </td>
										<td><input type="submit" name="validate_cred_but" value="Validate" class="new_control greenbtn"></td>
									</tr>
									
									</table>
									
									</form>
									
									</div>
									</center>';
			}
		}
			
		//======================= end process
		$aData = array ();
		$aData['validate_form'] = $validate_form;
		$aData['add_status'] = $add_status;
		return $aData;
	}
	
	
	//============== add_vip_user_detail($admin_login) ==================
	public function add_vip_user_detail($admin_login) 
	{
		$db = hbm_db();
		$sql_IN = "INSERT INTO vip_user_detail
						 (user_login 
						 , enable_status 
						 , user_type)
					VALUES ('".$admin_login."'
						 , 0 
						 , 'ADMIN') ";
		if ($db->query($sql_IN)) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public function add_cred($PPOST)
	{
		$db = hbm_db();
		$ress = $this->get_vip_setting();
		$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
		$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $ress['app_user_id'], $ress['app_access_key']);

		
		$appsuser_id = $ress['app_user_id'];		
		/*			
		$doc_root = explode("/" , $_SERVER['DOCUMENT_ROOT']);
		$doc_root_home_cpuser = "/".$doc_root[1]."/".$doc_root[2]."/.rvglobalsoft";
		
		$f1 = $doc_root_home_cpuser."/cp_authorizeid.pub";

		$cpuser_id = "";
		
		if ( file_exists($f1)) {
			$cpuser_id = file_get_contents($f1);
		}
		*/
		
		$aCp = $this->get_cp_from_file();
		$cpuser_id = $aCp['cpuser_id'];
		$cp_public_key = $aCp['cp_public_key'];
					
	    //======================== process add vip start
					
		$req_id = time();
		//$userId = $appsuser_id."_admin_".$admin_login;
		$credential_type = "STANDARD_OTP";
		//$friendlyName = $PPOST['vip_acct_comment'];
		$credentialId = strtoupper($PPOST['credentialId']);
		$vip_cred_comment = $PPOST['vip_cred_comment'];
		$vip_acct_id = $PPOST['vip_acct_id'];
		$user_email = $PPOST['user_email'];	
				// === add vip acct with cred =====//
				
		$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post',
						 '/vipuserinfo', array(
												'action_do' => 'addcred_app' , 
												'vip_cred' => $credentialId , 
												'vip_cred_comment' => $vip_cred_comment ,
												'vip_cred_type' => 'STANDARD_OTP' ,
												'cpuser_id' => $cpuser_id ,
												'appsuser_id' => $appsuser_id ,
												'vip_acct_id' => $vip_acct_id
							));
		$oResR = (array) $oRes;

		if( $oResR['status'] == 'success' ) {
			
			$add_status = true;
					
			$validate_form = '

	<div class="wrap">
	
	<center>
	<br /><br />
	
	<strong>Validate Credential ID</strong>
	
	<br />Insert your security code to confirm adding credential.
	
	<br />
	
	
	<script type="text/javascript">
	function chk_val_frm(frm) {
		if(frm.otp.value=="") {
			alert("Please type Security Code");
			frm.otp.focus();
			return false;
		}
		return true;
	}
</script>

<script type="text/javascript">
	window.onload = function() {
  document.getElementById("otp").focus();
};
</script> 							

	
	<form name="validate_cred" method="post" action="" onsubmit="return chk_val_frm(this)">
	
	<input type="hidden" name="userId" value="'.$appsuser_id.'">
	<input type="hidden" name="vip_acct_id" value="'.$vip_acct_id.'">
	<input type="hidden" name="credentialId" value="'.$credentialId.'">
	

	
	<table class="widefat page fixed" cellspacing="0">
	<tr>
		<td align=right>Credential ID : </td>
		<td>'.$credentialId.'</td>
	</tr>
	
	<tr>
		<td align=right>Security Code : </td>
		<td><input type="text" name="otp" id="otp" MAXLENGTH="6"></td>
	</tr>
	
	<tr>
		<td> </td>
		<td><input type="submit" name="validate_cred_but_no" value="Validate" class="new_control greenbtn"></td>
	</tr>
	
	</table>
	
	</form>
	
	</div>
	</center>
	
	';
		} else {
			
			$validate_form = $oResR['comment']."<br />
			<br />
			<a href='?cmd=module&module=".$_GET['module']."&action_do=add_credential&user_email=".$user_email."&vip_acct_id=".$vip_acct_id."'>Click here</a> to add another Credential ID.";
			$add_status = true;
			
		}	
					
	    $aData = array ();
	    $aData['validate_form'] = $validate_form;
	    $aData['add_status'] = $add_status;
		return $aData;
		
	}
	
	//============== get_vip_acct_list($appsuser_id) ==================
	public function get_vip_acct_list($appsuser_id) 
	{
		
		$oResApp = RvLibs_RvGlobalStoreApi::singleton()->request('get',
						 '/vipuserinfo', array(
												'action_do' => 'listacct_app' ,
												'appsuser_id' => $appsuser_id
										));
		$oResRApp = (array) $oResApp; 
		$acctlist = $oResRApp['acctlist'];
		
		$db = hbm_db();
		$aData = array();
		
		foreach ($acctlist as $k => $v) {
			$vip_acct = explode("_" , $v->vip_acct_name);
			if($vip_acct[3] == 'admin') {
				$user_type = 'ADMIN';
				$sql_m = "SELECT A.* , B.enable_status
								 FROM ".HBF_DBPREFIX."admin_access A
							inner join vip_user_detail B
							on A.id=B.user_login
							where A.id = '".$v->vip_acct_comment."' 
							and B.user_type = 'ADMIN'  ";
				$res_m = $db->query($sql_m)->fetch(); 
				$hb_user = $res_m['username'];
				$enable_status = $res_m['enable_status'];
			} 
			else 
			{
				$user_type = 'CLIENT';
				$sql_m = "SELECT A.* , B.enable_status
							 FROM ".HBF_DBPREFIX."client_access A
							 inner join vip_user_detail B
							 on A.id=B.user_login
							 where A.id = '".$v->vip_acct_comment."' 
							 and B.user_type = 'CLIENT'  ";
				$res_m = $db->query($sql_m)->fetch(); 
				$hb_user = $res_m['email'];
				$enable_status = $res_m['enable_status'];
			}
			$key = $v->vip_acct_id;
			$aData[$key]['user_type'] = $user_type;
			$aData[$key]['vip_acct_id'] = $v->vip_acct_id;
			$aData[$key]['vip_acct_name'] = $v->vip_acct_name;
			$aData[$key]['vip_acct_comment'] = $v->vip_acct_comment;
			$aData[$key]['cred_count'] = $v->cred_count;
			$aData[$key]['can_add_cred'] = $v->can_add_cred;
			$aData[$key]['cpuser_id'] = $v->cpuser_id;
			$aData[$key]['appsuser_id'] = $v->appsuser_id;
			$aData[$key]['vip_acct_status'] = $v->vip_acct_status;
			$aData[$key]['cp_apps_service_status'] = $v->cp_apps_service_status;
			$aData[$key]['hb_user'] = $hb_user;
			$aData[$key]['enable_status'] = $enable_status;
		}
		return $aData;
	}

	//============== deleteAcct($aData) ==================
	public function deleteAcct($aData) 
	{
		$db = hbm_db();
		
		$vip_acct_name = $aData['vip_acct_name'];
		$appsuser_id = $aData['app_user_id'];
		$user_login = $aData['user_login'];
		$user_type = $aData['user_type'];
		
		if($vip_acct_name != '') {
			
			$ress = $this->get_vip_setting();
			$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
			$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $ress['app_user_id'], $ress['app_access_key']);
			
			// ============== delete on symantec vip ============================
			$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('get',
							 '/vipuserinfo', array(
													'action_do' => 'deleteacct_app' , 
													'vip_acct_name' => $vip_acct_name , 
													'appsuser_id' => $appsuser_id 
												   ));
			$oResR = (array) $oRes; 
			
			//print_r($oResR);
				
			if ($oResR['del_status'] == 'success') {
				
				$comment = "<br /><font color='#0B9E1F'>Delete VIP Account ".$vip_acct_name." ".$oResR['del_status']."</font><br />";
				// then delete vip_user_detail in db
				$xData = array();
				$xData['user_login'] = $user_login;
				$xData['user_type'] = $user_type;
				$this->delete_vip_user_detail($xData);
			
			} else {
				$comment = "<br /><font color='#FF0000'>Delete VIP Account ".$vip_acct_name." ".$oResR['del_status']."</font><br />";
			}
			
			// ================== end delete on symantec vip ========================	
		}
		
		$aData = array();
		$aData['del_status'] = $oResR['del_status'];
		$aData['comment'] = $comment; 
		return $aData;							
	}
	
	//================== delete_vip_user_detail($aData) ====================
	public function delete_vip_user_detail($aData)
	{
		$db = hbm_db();
		$user_login = $aData['user_login'];
		$user_type = $aData['user_type'];
		$sqld0 = "DELETE FROM vip_user_detail 
							WHERE user_login = '".$user_login."' 
							AND user_type = '".$user_type."'  ";
		if($db->query($sqld0)) {
			return true;
		} else {
			return false;
		}
	}
	
	//============== setVIPEnableStatus($aData) ==================
	public function setVIPEnableStatus($aData) 
	{
		$db = hbm_db();
		$sql = "UPDATE vip_user_detail 
					SET 	enable_status = '".$aData['enable_status']."'
					WHERE 	user_login = '".$aData['user_login']."' 
					AND		user_type = '".$aData['user_type']."'
				"; 
		if($db->query($sql)) {
			$res = "<font color='#339900'>RV2Factor status was successfully changed.</font><br />";
		} else {
			$res = "<font color='#FF0000'>Failed to change RV2Factor status. Please try again.</font><br />";
		}
		return $res;
	}
	
	//============== deleteCred($aData) ==================
	public function deleteCred($aData)
	{
		$db = hbm_db();
		
		$vip_cred = $aData['vip_cred'];
		$vip_cred_id = $aData['vip_cred_id'];
		
		$resx = $this->get_vip_setting();
	    $appsuser_id = $resx['app_user_id'];
	
		$oResx = RvLibs_RvGlobalStoreApi::singleton()->request('get',
							 '/vipuserinfo', array(
													'action_do' => 'deletecredential_app' , 
													'vip_cred_id' => $vip_cred_id , 
													'appsuser_id' => $appsuser_id 
											));
		$oResRx = (array) $oResx; 
		
		//print_r($oResRx);
		if ($oResRx['del_status'] == 'success') {
			$del_comment = "<font color='green'><b>".$oResRx['comment']."</b></font><br /><br />";
		} else {
			$del_comment = "<font color='red'><b>".$oResRx['comment']."</b></font><br /><br />";
		}
		return $del_comment;
	}
	
	//============== setVIPSystemEnableServiceStatus($status,$status_admin,$remember_device_status,$remember_device_day) ==================
	public function setVIPSystemEnableServiceStatus($status,$status_admin,$remember_device_status,$remember_device_day)
	{
		$db = hbm_db();
		$sql = " UPDATE vip_setting 
				 SET 
						enable_vip_service = '".$status."' , 
						enable_vip_service_admin = '".$status_admin."' , 
						remember_device_status = '".$remember_device_status."' , 
						remember_device_day = '".$remember_device_day."'
				 WHERE setting_id = '1'
				";
		if($db->query($sql)) {
			$ret = "<font color='#339900'>Change RV2Factor service status is successful.</font><br /><br />";
		} else {
			$ret = "<font color='#FF0000'>Change RV2Factor service status is failed.</font><br /><br />";
		}
		return $ret;
	}
	
	//============== validateCred($aData) ===============
	public function validateCred($aData) 
	{
		// validate credential
		$appsuser_id = $aData['userId'];
		$vip_acct_id = $aData['vip_acct_id'];
		$otp = $aData['otp'];
		$vip_cred = $aData['credentialId'];
	
		$otp = str_replace("'", "", $aData['otp']);
		$otp = str_replace('"', '', $aData['otp']);
		$admin_login = $aData['admin_login'];
	
		$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post',
						 '/vipuserinfo', array(
												'action_do' => 'validate_cred_app' , 
												'vip_acct_id' => $vip_acct_id , 
												'appsuser_id' => $appsuser_id ,
												'otp' => $otp ,
												'vip_cred' => $vip_cred
		));
		$oResR = (array) $oRes;
		
		$err = array();
	
		// return add account result from symantec
		if ($oResR['status'] == 'success') {
			$err['status'] = 'success';
			$err['comment'] = 'Add and validate Credential ID : '.$vip_cred. ' is successful<br />';
		} else {
			$err['comment'] = $oResR['comment'];
			$vip_cred_id = $oResR['vip_cred_id'];
			
			$db = hbm_db();
			$xData = array();
			$xData['user_login'] = $admin_login;
			$xData['user_type'] = 'ADMIN';
			$this->delete_vip_user_detail($xData);
						
			$oResx = RvLibs_RvGlobalStoreApi::singleton()->request('get',
							 '/vipuserinfo', array(
													'action_do' => 'deletecredential_app' , 
													'vip_cred_id' => $vip_cred_id , 
													'appsuser_id' => $appsuser_id 
											));
			$oResRx = (array) $oResx; 
			if ($oResRx['del_status'] == 'success') {
				$err['status'] = 'delete';
			}
		}
		
		return $err;
	}
	
	//============ validateCredNoDelete($aData) ===============
	public function validateCredNoDelete($aData) 
	{
		// validate credential
		$appsuser_id = $aData['userId'];
		$vip_acct_id = $aData['vip_acct_id'];
		$otp = $aData['otp'];
		$vip_cred = $aData['credentialId'];
	
		$otp = str_replace("'", "", $aData['otp']);
		$otp = str_replace('"', '', $aData['otp']);
		$admin_login = $aData['admin_login'];	
	
		$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post',
						 '/vipuserinfo', array(
												'action_do' => 'validate_cred_app' , 
												'vip_acct_id' => $vip_acct_id , 
												'appsuser_id' => $appsuser_id ,
												'otp' => $otp ,
												'vip_cred' => $vip_cred
		));
		$oResR = (array) $oRes;
		
		$err = array();
	
		// return add account result from symantec
		if ($oResR['status'] == 'success') {	
			$err['status'] = 'success';
			$err['comment'] = '<font color="#339900">Add and validate Credential ID : '.$vip_cred. ' is successful</font>';
		} else {
			$err['status'] = 'failed';
			$err['comment'] = "<font color='#FF0000'>".$oResR['comment']."</font>";
			$vip_cred_id = $oResR['vip_cred_id'];
		}
		return $err;
	}
	
	//============ readfile_chunked( $filename,$retbytes=true) ===============
	public function readfile_chunked( $filename,$retbytes=true)
	{
		$chunksize = 1*(1024*1024); // how many bytes per chunk
		$buffer = '';
		$cnt =0;
		// $handle = fopen($filename, 'rb');
		$handle = fopen($filename, 'rb');
		if ($handle === false) {
			return false;
		}
		while (!feof($handle)) {
			$buffer = fread($handle, $chunksize);
			$bufferz = explode("\r\n" , $buffer);
			 
			//print_r($bufferz);
			$cnt_row = count($bufferz);
			for($ii=0;$ii<$cnt_row;$ii++) {
				$buff = explode("," , $bufferz[$ii]);
					 if ($buff[0] != '') {
				$row_log .= "<tr>
						   <td>".date("Y-m-d H:i:s" ,$buff[0])."</td>
						   <td>".$buff[10]."</td>
						   <td>".$buff[8]."</td>
       		 			   <td>".$buff[6]."</td>
       		 			   <td>".$buff[2]."</td>
       		 			   <td>".$buff[9]."</td>
       		 		  </tr>";
					 }
			}
			 
			ob_flush();
			flush();
			if ($retbytes) {
				$cnt += strlen($buffer);
			}
		}
		$status = fclose($handle);
		return $row_log;
	}
	
	public function patch_file_dashboard()
	{
		$db = hbm_db();
		$sql = "SELECT * 
					FROM ".HBF_DBPREFIX."configuration 
					WHERE setting = 'UserTemplate' ";
		$res = $db->query($sql)->fetch();
		$file_original = MAINDIR."templates/".$res['value']."/clientarea/dashboard.tpl";
		$file_code = APPDIR_MODULES."Other/Rvtwofactor/patch_file/patch-dashboard-head.txt";
		$file_code2 = APPDIR_MODULES."Other/Rvtwofactor/patch_file/patch-dashboard-foot.txt";
		//print_r($this->_tpl_vars);
		//echo "<pre>"; print_r($this);echo "</pre>";
		// get content from $file_original
		
		$content_original = file_get_contents($file_original);
		
		
		if (((strpos($content_original,'<rvtwofactorcode>') === false)) && (strpos($content_original,'<rvtwofactorcodefoot>') === false)) {
	
			$content_head = file_get_contents($file_code);
			$content_foot = file_get_contents($file_code2);
			
			$handle = fopen($file_original.".bak", "w+");
			//echo "<br />file_ori=".$file_original;
			//echo "<br />file_code=".$file_code;
			fwrite($handle, $content_original);
			fclose($handle);
			
		    $handle2 = fopen($file_original, "w+");
			fwrite($handle2, $content_head." ".$content_original." ".$content_foot);
			fclose($handle2);
		}
	}
	
	public function patch_file_menus()
	{
		$db = hbm_db();
		$sql = "SELECT * 
					FROM  ".HBF_DBPREFIX."configuration 
					WHERE setting = 'UserTemplate' ";
		$res = $db->query($sql)->fetch();
		$file_original = MAINDIR."templates/".$res['value']."/menus/menu.main.logged.tpl";
		$file_code = APPDIR_MODULES."Other/Rvtwofactor/patch_file/patch-menu-head.txt";
		
		$content_original = file_get_contents($file_original);
		
		if (strpos($content_original,'<rvtwofactorcode>') === false) {
	
			$content_head = file_get_contents($file_code);
			
			$handle = fopen($file_original.".bak", "w+");
			fwrite($handle, $content_original);
			fclose($handle);
			
		    $handle2 = fopen($file_original, "w+");
			fwrite($handle2, $content_head." ".$content_original);
			fclose($handle2);
		}
	}
	
	public function copy_user_file()
	{
		$db = hbm_db();
		$sql = "select * from ".HBF_DBPREFIX."configuration where setting = 'UserTemplate' ";
		$res = $db->query($sql)->fetch();
		$file_dest_path = MAINDIR."templates/".$res['value']."/twofactor";
		if (!is_dir($file_dest_path)) {
			mkdir($file_dest_path , 0777);
		}
		
		$files1 = APPDIR_MODULES."Other/Rvtwofactor/user_file/twofactor-access-log.tpl.php";
		$files2 = APPDIR_MODULES."Other/Rvtwofactor/user_file/twofactor-add.tpl.php";
		$files3 = APPDIR_MODULES."Other/Rvtwofactor/user_file/twofactor-event-log.tpl.php";
		$files4 = APPDIR_MODULES."Other/Rvtwofactor/user_file/twofactor-list.tpl.php";
		$files5 = APPDIR_MODULES."Other/Rvtwofactor/user_file/twofactor-validate.tpl.php";
		
		$filed1 = $file_dest_path."/twofactor-access-log.tpl.php";
		$filed2 = $file_dest_path."/twofactor-add.tpl.php";
		$filed3 = $file_dest_path."/twofactor-event-log.tpl.php";
		$filed4 = $file_dest_path."/twofactor-list.tpl.php";
		$filed5 = $file_dest_path."/twofactor-validate.tpl.php";
		

		if (!file_exists($filename1)) {
			copy($files1,$filed1);
		}
		if (!file_exists($filename2)) {
			copy($files2,$filed2);
		}
		if (!file_exists($filename3)) {
			copy($files3,$filed3);
		}
		if (!file_exists($filename4)) {
			copy($files4,$filed4);
		}
		if (!file_exists($filename5)) {
			copy($files5,$filed5);
		}
	}

	public function getLatestVersion() 
	{
		$doc_root = explode("/" , $_SERVER['DOCUMENT_ROOT']);
		$doc_root_home_cpuser = "/".$doc_root[1]."/".$doc_root[2]."/.rvglobalsoft";
		
		$f1 = $doc_root_home_cpuser."/cp_authorizeid.pub";
		$f2 = $doc_root_home_cpuser."/cp_authorizekey.pub";
		
		//$cpuser_id = "";
		//$cp_public_key = "";
		
		if ( file_exists($f1) && file_exists($f2) ) {
			$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('get',
							 '/vipuserinfo', array(
													'action_do' => 'getlatestversion' , 
													'app_name' => 'hostbill'
			));
			$oResR = (array) $oRes;
			
	
			$version_str_ex = explode(" : ", $oResR['app_version']);
			
			$latest_version_no = $version_str_ex[1];
			$latest_version_no = str_replace("<br>", "", $latest_version_no);
			//$latest_version_no = str_replace("<br />", "", $latest_version_no);
			
			$aData = array();
			$aData['app_version'] = $latest_version_no;	
			$aData['download_url'] = $oResR['download_url'];
			$aData['change_log_url'] = $oResR['change_log_url'];
			return $aData;
		}
	}
	
	public function getLocalVersion()
	{
		$res = $this->get_vip_setting();
		return $res['app_version'];	
	}
	
	public function runSql($sql)
	{
		$db = hbm_db();
		if ($sql != '') {
			if($res = $db->query($sql)) {
				$res = 'OK';
			} else {
				$res = 'FAILED';
			}
		} else {
			$res = 'No sql for update';
		}
		return $res;
	}
	
	public function runUpdateVersion($version)
	{
		$db = hbm_db();
		if ($version != '') {
			$sql = "UPDATE vip_setting 
						SET app_version = '".$version."'
						WHERE setting_id = '1' ";
			if($res = $db->query($sql)) {
				$resx = 'OK';
			} else {
				$resx = 'FAILED';
			}
		} else {
			$resx = 'No sql for update';
		}
		return $resx;
	}
	
	
	public function getVIPAppsQuota($appsuser_id)
	{
		$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
		$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('get',
						 '/vipuserinfo', array(
												'action_do' => 'get_app_quota' , 
												'appsuser_id' => $appsuser_id
		));
		$oResR = (array) $oRes;
		
		$aData = array();
		$aData['quota_app_amount'] = $oResR['quota_app_amount'];	
		$aData['quota_cp_amount'] = $oResR['quota_cp_amount'];
		return $aData;
	}
	
	public function getVIPAcctAppsUse($appsuser_id)
	{
		
		$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('get',
						 '/vipuserinfo', array(
												'action_do' => 'get_acct_app' , 
												'appsuser_id' => $appsuser_id
		));
		return $oRes;
	}
	
}