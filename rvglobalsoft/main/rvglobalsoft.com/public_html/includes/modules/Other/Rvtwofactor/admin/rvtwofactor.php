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
$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
$admin_login = $_SESSION['AppSettings']['admin_login']['id'];
$admin_email = $_SESSION['AppSettings']['admin_login']['email'];
$admin_username = $_SESSION['AppSettings']['admin_login']['username'];
$module->template->assign('admin_login',$admin_login);
$module->template->assign('admin_email',$admin_email);
$module->template->assign('admin_username',$admin_username);
$module->doSetting();

if ($_POST['make_cp_file']) {
	$aMakeFile = $module->make_cp_file($_POST);
	$module->template->assign('aMakeFile',$aMakeFile);
}

if ($_GET['agree_li'] != '') {
	$module->template->assign('get_data',$module->process_agree($_GET));
}

$module->template->assign('get_data',$module->process_agree($_GET));

// get all vip_setting
$vip_setting = $module->get_vip_setting();

$module->template->assign('hbus', $vip_setting['enable_vip_service']);
$module->template->assign('hbas', $vip_setting['enable_vip_service_admin']);

if ($vip_setting['license_agreement_status'] == 0) {
	$_GET['action'] = 'showLicense';
}

// assign to template
$module->template->assign('moduleId',$_GET['module']);
$module->template->assign('setting_data',$module->get_connection_result());

$module->template->assign('show_license_page', false);
$module->template->assign('show_setup_page', false);
$module->template->assign('show_manager_page', false);
$module->template->assign('show_cred_page',false);
$module->template->assign('show_rv2factor_detail_page',false);
$module->template->assign('show_list_cred', false);

if($_GET['action'] == 'showRV2FactorInfo') {

	$module->template->assign('show_license_page', false);
	$module->template->assign('show_setup_page', false);
	$module->template->assign('show_manager_page', false);
	$module->template->assign('show_cred_page',false);
	$module->template->assign('show_rv2factor_detail_page',true);
	$module->template->assign('show_list_cred', false);

} else if($_GET['action'] == 'showLicense') { // step 1 show license

	$module->template->assign('show_license_page',true);
	$module->template->assign('show_setup_page', false);
	$module->template->assign('show_manager_page', false);
	$module->template->assign('show_cred_page',false);

	if($vip_setting['license_agreement_status'] == 0) {
		$license_agreement_status = false;
	} else if ($vip_setting['license_agreement_status'] == 1) {
		$license_agreement_status = true;
	}

	// license button show
	$module->template->assign('license_agreement_status', $license_agreement_status);


} else if ($_GET['action'] == 'showSetup') { // step 2 show setup page

	// run path file
	$module->patch_file_dashboard();
	$module->patch_file_menus();
	$module->copy_user_file();

    if ($_POST['action_do'] == 'enable_vip_status_by_admin') {

		$enable_vip_service = $_POST['enable_vip_service'];
		$enable_vip_service_admin = $_POST['enable_vip_service_admin'];
		$remember_device_status = $_POST['remember_device'];
		$remember_device_day = $_POST['remember_day'];

		if ($remember_device_status == "DISABLED") {
			$remember_device_day = 0;
		}

		$change_system_status = $module->setVIPSystemEnableServiceStatus($enable_vip_service , $enable_vip_service_admin , $remember_device_status , $remember_device_day);
		$module->template->assign('change_system_status',$change_system_status);

	}

	$version_text = $module->getLatestVersion();
	$version_text_local = $module->getLocalVersion();
	$can_update = false;
	$v_new = trim($version_text['app_version']);
	if ($v_new != $version_text_local) { //$version_text_local
		$can_update = true;
		$module->template->assign('version_text_version',$version_text['app_version']);
		$module->template->assign('version_text_changlog',$version_text['change_log_url']);
		$module->template->assign('version_text_download',$version_text['download_url']);
	} else {
		$module->template->assign('version_text_version',$version_text['app_version']);
	}
	$module->template->assign('can_update',$can_update);
	$module->template->assign('version_text_local',$version_text_local);

	// get all vip_setting
	$vip_setting2 = $module->get_vip_setting();

	if($vip_setting2['enable_vip_service'] == 0) {
		$open_service0 = true;
		$open_service1 = false;
		$open_service2 = false;
	} else if ($vip_setting2['enable_vip_service'] == 1) {
		$open_service0 = false;
		$open_service1 = true;
		$open_service2 = false;
	} else if ($vip_setting2['enable_vip_service'] == 2) {
		$open_service0 = false;
		$open_service1 = false;
		$open_service2 = true;
	}

	$module->template->assign('open_service0',$open_service0);
	$module->template->assign('open_service1',$open_service1);
	$module->template->assign('open_service2',$open_service2);


	if($vip_setting2['enable_vip_service_admin'] == 0) {
		$open_service_admin0 = true;
		$open_service_admin1 = false;
		$open_service_admin2 = false;
	} else if ($vip_setting2['enable_vip_service_admin'] == 1) {
		$open_service_admin0 = false;
		$open_service_admin1 = true;
		$open_service_admin2 = false;
	} else if ($vip_setting2['enable_vip_service_admin'] == 2) {
		$open_service_admin0 = false;
		$open_service_admin1 = false;
		$open_service_admin2 = true;
	}


	$remember_device0 = false;
	$remember_device1 = false;
	$remember_day = 0;

	if($vip_setting2['remember_device_status'] == "DISABLED") {
		$remember_device0 = true;
		$remember_device1 = false;
		$remember_day = 0;
	} else if ($vip_setting2['remember_device_status'] == "ENABLED") {
		$remember_device0 = false;
		$remember_device1 = true;
		$remember_day = $vip_setting2['remember_device_day'];
	}

	$module->template->assign('open_service_admin0',$open_service_admin0);
	$module->template->assign('open_service_admin1',$open_service_admin1);
	$module->template->assign('open_service_admin2',$open_service_admin2);

	$module->template->assign('remember_device0',$remember_device0);
	$module->template->assign('remember_device1',$remember_device1);
	$module->template->assign('remember_day',$remember_day);



	$module->template->assign('show_license_page',false);
	$module->template->assign('show_setup_page', true);
	$module->template->assign('show_manager_page', false);
	$module->template->assign('show_cred_page',false);

} else if ($_GET['action'] == 'update_rvtwofactor') {

	$module->template->assign('show_license_page',false);
	$module->template->assign('show_setup_page', false);
	$module->template->assign('show_manager_page', false);
	$module->template->assign('show_cred_page',false);
	$module->template->assign('show_update_page', true);


	$version_new = $module->getLatestVersion();
	$version_old_local = $module->getLocalVersion();
	$can_update = false;
	$v_new = trim($version_new['app_version']);
	if ($v_new != '') {
		$can_update = true;

		$url = $version_new['download_url'];//remote url to download
		$path = APPDIR_MODULES."Other/Rvtwofactor/temp/rvtwofactor_hostbill-".$v_new.".zip";//local file path

		$rest = substr(MAINDIR, 0, -1);

		$module->template->assign('url', $url);
		$module->template->assign('path', $path);

    	$con = file_get_contents($url);
    	//$module->template->assign('download_update_status', $con." ".$url);
		// 1. download file
		if ($con != '') {

			if(file_put_contents($path, $con)) {
				$module->template->assign('download_update_status', ' from '.$url.' to '.$path.' OK ');
			// 2. extract
				$zip = new ZipArchive;
				if ($zip->open($path) === TRUE) {
				    $zip->extractTo($rest);
				    $zip->close();
				    $resu = 'Extract file to '.$rest.' OK';
				    // get version from file
					$version_txt = file_get_contents(APPDIR_MODULES."Other/Rvtwofactor/Symantec/version.txt");
					$module->runUpdateVersion($version_txt);

				} else {
				    $resu = 'Extract file to '.$rest.' FAILED';
				}
				$module->template->assign('extract_file_status', $resu);
			}
		} else {
			$module->template->assign('download_update_status', 'Read update file Failed');
		}
	}

} else if($_GET['action'] == 'addacct_with_cred') {

	$aDataAdd = $module->addacct_with_cred($_POST);
	$module->template->assign('aDataAdd',$aDataAdd);

	if ($_POST['validate_cred_but_no'] != '') {

		$_POST['admin_login'] = $admin_login;
		$validate_res = $module->validateCredNoDelete($_POST);
		$module->template->assign('validate_res',$validate_res['comment']);

	}

	$vip_acct_list = $module->get_vip_acct_list($vip_setting['app_user_id']);
	$module->template->assign('vip_acct_list', $vip_acct_list);

	$cnt_vip_hb_admin = $module->get_admin_vip_on_hb($admin_login);
	if ($cnt_vip_hb_admin > 0) {
		$module->template->assign('has_vip_admin', true);
	} else {
		$module->template->assign('has_vip_admin', false);
	}

	$module->template->assign('cnt_quota_vip_acct',$module->getVIPAppsQuota($vip_setting['app_user_id']));

	$module->template->assign('cnt_vip_acct_all',$module->getVIPAcctAppsUse($vip_setting['app_user_id']));



	$module->template->assign('show_license_page',false);
	$module->template->assign('show_setup_page', false);
	$module->template->assign('show_manager_page', true);
	$module->template->assign('show_cred_page',false);

} else if ($_GET['action'] == 'add_cred') {

	if ($_POST['validate_cred_but_no'] != '') {

		$_POST['admin_login'] = $admin_login;
		$validate_res = $module->validateCredNoDelete($_POST);
		$module->template->assign('validate_res',$validate_res['comment']);

	} else {

		$aDataAdd = $module->add_cred($_POST);
		$module->template->assign('aDataAdd',$aDataAdd);


	}

	$vip_acct_list = $module->get_vip_acct_list($vip_setting['app_user_id']);
	$module->template->assign('vip_acct_list', $vip_acct_list);

	$cnt_vip_hb_admin = $module->get_admin_vip_on_hb($admin_login);
	if ($cnt_vip_hb_admin > 0) {
		$module->template->assign('has_vip_admin', true);
	} else {
		$module->template->assign('has_vip_admin', false);
	}

	$module->template->assign('cnt_quota_vip_acct',$module->getVIPAppsQuota($vip_setting['app_user_id']));

	$module->template->assign('cnt_vip_acct_all',$module->getVIPAcctAppsUse($vip_setting['app_user_id']));


	$module->template->assign('show_license_page',false);
	$module->template->assign('show_setup_page', false);
	$module->template->assign('show_manager_page', true);
	$module->template->assign('show_cred_page',false);

} else { // step 3 manage vip

	$module->patch_file_dashboard();
	$module->patch_file_menus();
	$module->copy_user_file();

	$module->template->assign('show_license_page',false);
	$module->template->assign('show_setup_page', false);
	$module->template->assign('show_manager_page', true);
	$module->template->assign('show_cred_page',false);

	$cnt_vip_hb_admin = $module->get_admin_vip_on_hb($admin_login);

	$module->template->assign('cnt_vip_hb_admin', $cnt_vip_hb_admin);

	if ($cnt_vip_hb_admin > 0) {
		$module->template->assign('has_vip_admin', true);
	} else {
		$module->template->assign('has_vip_admin', false);
	}



	$module->template->assign('cnt_quota_vip_acct',$module->getVIPAppsQuota($vip_setting['app_user_id']));

	$module->template->assign('cnt_vip_acct_all',$module->getVIPAcctAppsUse($vip_setting['app_user_id']));


	if ($_POST['validate_cred_but'] != '') {
		$_POST['admin_login'] = $admin_login;
		$validate_res = $module->validateCred($_POST);
		$module->template->assign('validate_res',$validate_res['comment']);

	}


	$module->template->assign('appsuser_id', $vip_setting['app_user_id']);


	if ($_GET['action_do'] == 'delete-acct') {

		$del_acct = $module->deleteAcct($_GET);
		$module->template->assign('del_acct',$del_acct);

	} else if ($_GET['action_do'] == 'view_access_log') {

		$cpPath = explode("/" , $_SERVER['DOCUMENT_ROOT']);
		$cpPathLog = "/".$cpPath[1]."/".$cpPath[2];

	    $path3 = $cpPathLog."/.rvglobalsoft/symantecvip/logs/vipAppsAccesslogs.log";

		$strFileName = $path3;

		$row_log = $module->readfile_chunked($strFileName , true);

		if($row_log != '') {
			$row_access_log = "<table class='padtable' width='100%' cellpadding='3' cellspacing=0 border='0'>
					<tr>
						<td class='serv_head1' align='center'>Log Date</td>
						<td class='serv_head1' align='center'>User Type</td>
						<td class='serv_head1' align='center'>ID</td>
						<td class='serv_head1' align='center'>Credential ID</td>
						<td class='serv_head1' align='center'>Login</td>
						<td class='serv_head1' align='center'>IP Address</td>
					</tr>";
			$row_access_log .= $row_log;
			$row_access_log .= "</table>";
		} else {
			$row_access_log = "Not has any access log";
		}

		$module->template->assign('show_access_log',true);
		$module->template->assign('show_manager_page',false);
		$module->template->assign('row_access_log',$row_access_log);

	} else if ($_GET['action_do'] == 'view_event_log') {

		$oResL = RvLibs_RvGlobalStoreApi::singleton()->request('get',
							 '/vipuserinfo', array(
													'action_do' => 'viewlog_app' ,
													'appsuser_id' => $vip_setting['app_user_id']
		));
		$oResList = (array) $oResL;
		//print_r($oResList);
		$cnt_log = count($oResList);



		if($cnt_log>0) {
			$event_log = "<table class='padtable' width='100%' cellpadding='3' cellspacing=0 border='0'>
			<tr>
				<td class='serv_head1' align='center'>Log Date</td>
				<td class='serv_head1' align='center'>Event</td>
				<td class='serv_head1' align='center'>IP Address</td>
			</tr>";
			foreach ($oResList as $kk => $vv) {

				$log_date = date("Y-m-d H:i:s" , $vv->log_date);

				$event_log .= "<tr>
					<td>".$log_date."</td>
					<td>".$vv->log_event."</td>
					<td>".$vv->log_ip."</td>
			  </tr>";
			}
			$event_log .= "</table>";
		} else {
			$event_log = "Not has any log";
		}

		$module->template->assign('show_access_log',false);
		$module->template->assign('show_manager_page',false);
		$module->template->assign('show_event_log',true);
		$module->template->assign('row_event_log',$event_log);


	} else 	if ($_GET['action_do'] == 'listcred_app') {


		// ========== change status ===============//
		if ($_POST['change_status'] != '') {

			$enable_vip_for_own = $_POST['enable_vip_for_own'];
			$user_login = $_GET['user_login'];
			$user_type = $_GET['user_type'];

			$aData = array (
								'enable_status' => $enable_vip_for_own,
								'user_login' => $user_login ,
								'user_type' => $user_type
							);

			$change_status = $module->setVIPEnableStatus($aData);
			$module->template->assign('change_status',$change_status);
		}

		if($_GET['action_do2'] == 'delete-credential') {
			$aData = array (
								'vip_cred' => $_GET['vip_cred'],
								'vip_cred_id' => $_GET['vip_cred_id']
							);
			$del_cred = $module->deleteCred($aData);
			$module->template->assign('del_cred',$del_cred);
		}




		$res = $module->get_vip_user_detail_by_id($_GET['user_login'],$_GET['user_type']);
		if ($res['enable_status'] == 0) {
			$sta0 = " selected = 'selected' ";
			$sta1 = "  ";
		} else if ($res['enable_status'] == 1) {
			$sta0 = "  ";
			$sta1 = " selected = 'selected' ";
		}

		$module->template->assign('sta0',$sta0);
		$module->template->assign('sta1',$sta1);

		$module->template->assign('show_license_page',false);
		$module->template->assign('show_setup_page', false);
		$module->template->assign('show_manager_page', false);
		$module->template->assign('show_cred_page',true);
		$module->template->assign('show_list_cred', true);

		$module->template->assign('user_email', $_GET['user_email']);
		$module->template->assign('user_type', $_GET['user_type']);
		$module->template->assign('user_login', $_GET['user_login']);
		$module->template->assign('vip_acct_name', $_GET['vip_acct_name']);
		$module->template->assign('vip_acct_id', $_GET['vip_acct_id']);

		$vip_acct_name = $_GET['vip_acct_name'];

		// get vip_cred_list
	    $oResL = RvLibs_RvGlobalStoreApi::singleton()->request('get',
							 '/vipuserinfo', array(
													'action_do' => 'listcred_app' ,
													'vip_acct_name' => $vip_acct_name ,
													'appsuser_id' => $appsuser_id
											));
		$oResList = (array) $oResL;

		$cnt_cred = count($oResList);

		$aData = array ();
		foreach ($oResList as $kk => $vv) {
			$key = $vv->vip_cred_id;
			$aData[$key][vip_cred_id] = $vv->vip_cred_id;
			$aData[$key][vip_acct_id] = $vv->vip_acct_id;
			$aData[$key][vip_cred] = $vv->vip_cred;
			$aData[$key][vip_cred_comment] = $vv->vip_cred_comment;
		}

		//return $oResList;
		$module->template->assign('credentail_list', $aData);
		$module->template->assign('cnt_cred',$cnt_cred);
		$module->template->assign('vip_acct_id', $_GET['vip_acct_id']);

	} else if ($_GET['action_do'] == 'add_credential') {

		$module->template->assign('show_license_page', false);
		$module->template->assign('show_setup_page', false);
		$module->template->assign('show_manager_page', false);
		$module->template->assign('show_cred_page',false);

		$module->template->assign('show_add_cred_form',true);
		$module->template->assign('user_email',$_GET['user_email']);
		$module->template->assign('vip_acct_id',$_GET['vip_acct_id']);

    }



// get all vip user
	$vip_acct_list = $module->get_vip_acct_list($vip_setting['app_user_id']);
	$module->template->assign('vip_acct_list', $vip_acct_list);

	// get admin vip user
	$cnt_vip_hb_admin = $module->get_admin_vip_on_hb($admin_login);
	if ($cnt_vip_hb_admin > 0) {
		$module->template->assign('has_vip_admin', true);
	} else {
		$module->template->assign('has_vip_admin', false);
	}


	$cnt_acct = count($vip_acct_list);
	if($cnt_acct<=0) {
		// show addacct_with_cred
	} else {
		// show list

	}



}
