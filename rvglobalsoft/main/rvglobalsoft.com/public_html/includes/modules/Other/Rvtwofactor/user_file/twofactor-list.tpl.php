<?php 
#@LICENSE@#
?>
<?php 
$PRO_FILE_PATH = APPDIR_MODULES . "Other/Rvtwofactor";

define('RVGLOBALSTORE_API_URL', 'http://api.rvglobalsoft.com/apps');
define('RV_APPS_ID', 'hostbill');
set_include_path(HBFDIR_LIBS . 'pear' . PATH_SEPARATOR . $PRO_FILE_PATH. '/Lib-oAuthConnect/PHP/pear' . PATH_SEPARATOR . $PRO_FILE_PATH.'/Lib-oAuthConnect/PHP/RvLibs' . PATH_SEPARATOR . get_include_path());
if (!class_exists('PEAR',false)) {
	require_once 'PEAR.php';
}
require_once $PRO_FILE_PATH.'/Lib-oAuthConnect/PHP/RvLibs/RvGlobalStoreApi.php';

//if ($_SERVER['SERVER_NAME'] == 'netway.co.th')
if(preg_match('/netway.co.th$/i',$_SERVER['SERVER_NAME'])){
	$rv2factor_label = "Netway2Factor";
} else {
	$rv2factor_label = "RV2Factor";
}

Class TwofactorList {
	
	protected $dbh;

	public function TwofactorList()
	{
		$this->dbh = hbm_db();
	}
	
	public function quote_smart($value)
    {
        // Stripslashes
        if (get_magic_quotes_gpc()) {
            $value = stripslashes($value);
        }
        // Quote if not integer
        if (!is_numeric($value)) {
            $value = "'" .  $value . "'";
        }
        return $value;
    }

	public function get_vip_setting()
	{
		$sql = "SELECT * 
				FROM vip_setting
				WHERE setting_id = '1' ";
		$result = $this->dbh->query($sql)->fetch();
		return $result;
	}

	public function connect_rv_api($app_user_id, $app_access_key)
	{
		$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
		$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $app_user_id, $app_access_key);
		return $oUserConnect;
	}

	public function selectVipUserDetail($user_login, $UserType)
	{
		$sql = sprintf(" SELECT *
						 FROM %s
						 WHERE 
						 	user_login = %s
						 	AND user_type = %s
						 " 
						, 'vip_user_detail'
						, $this->quote_smart($user_login)
						, $this->quote_smart($UserType)
					);
		$res = $this->dbh->query($sql)->fetchAll();
		return $res;
	}
	
	public function getVipUserDetail($user_login)
	{
		$sql = sprintf(" SELECT *
						 FROM %s
						 WHERE 
						 	user_login = %s
						 " 
						, 'vip_user_detail'
						, $this->quote_smart($user_login)
					);
		$res = $this->dbh->query($sql)->fetch();
		return $res;
	}
	
	public function updateVipUserDetail($enable_vip, $user_login)
	{ 
		$sql = sprintf(" UPDATE 
								%s	
						  SET enable_status = %s
						  WHERE 
						  	user_login = %s
			 			"
			 			, 'vip_user_detail'
						, $this->quote_smart($enable_vip)
						, $this->quote_smart($user_login)
						);
		if($this->dbh->query($sql)) {
			return true;
		} else {
			return false;
		}
	}
	
	public function insertUserLogin($user_login, $enable_status) 
	{
		$sql = sprintf(" INSERT INTO %s
								( user_login 
								, enable_status
								)
							VALUES ( %s
							    , %s 
							    ) 
							" 
							, 'vip_user_detail'
							, $this->quote_smart($user_login)
							, $this->quote_smart($enable_status)
						 );
		if($this->dbh->query($sql)) {
		 	return true;
		} else {
		 	return false;
		}
	}

}


// --- hostbill helper ---
$db         = hbm_db();

$oTwoList = new TwofactorList();

$user_login = $_SESSION['AppSettings']['login']['id'];
$admin_login = $_SESSION['AppSettings']['admin_login']['id'];

$result = $oTwoList->get_vip_setting(); 
$vip_acct_id = $result['vip_user_prefix'].$result['app_user_id']."_".$user_login;
$vip_acct_fullname = $result['vip_user_prefix'].$result['app_user_id']."_".$user_login;
$vip_acct_name = $result['app_user_id']."_".$user_login;
$appsuser_id = $result['app_user_id'];
$enable_vip_service = $result['enable_vip_service'];

//$oAuth =& RvLibs_RvGlobalStoreApi::singleton();
//$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $result['app_user_id'], $result['app_access_key']);
$oTwoConnect = $oTwoList->connect_rv_api($result['app_user_id'], $result['app_access_key']);

$show_vip_acct_list_status = 1;

$UserType = "CLIENT";
$resultm = $oTwoList->selectVipUserDetail($user_login, $UserType);

// ==================== update status ==================
if ($_POST['change_status'] != '') {
	
	$enable_vip = $_POST['enable_vip_for_own'];
	if($oTwoList->updateVipUserDetail($enable_vip, $user_login)) {
		$err_comment = '<font color="green">Change '.$rv2factor_label.' status was successful</font><br />';
	} else {
		$err_comment = '<font color="red">Change '.$rv2factor_label.' status was not successful</font><br />';
	}

} 

// ==================== add vip acct =====================
if ($_POST['save_admin_vip_but'] != '') {
	$req_id = time();
	$userId = $vip_acct_name;
	$credential_type = "STANDARD_OTP";
	$friendlyName = $_POST['vip_acct_comment'];
	$credentialId = strtoupper($_POST['credentialId']);
	$vip_acct_comment = $user_login;
	
	// === add vip acct with cred =====//

	$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post', '/vipuserinfo', array(
																						'action_do' => 'addacct_with_cred_app' , 
																						'vip_cred' => $credentialId , 
																						'vip_cred_comment' => $friendlyName , 
																						'vip_acct_name' => $userId ,
																						'vip_acct_comment' => $vip_acct_comment ,
																						'appsuser_id' => $appsuser_id , 
																						'vip_cred_type' => $credential_type
																						)
									                     );
	$oResR = (array) $oRes;

	if( $oResR['status'] == 'success' ) {
		// add user to vip_user_detail
		$vip_acct_id = $oResR['vip_acct_id'];
		if ($oTwoList->insertUserLogin($user_login, 1)) {
			echo "<center> Add Credential ID success </center>";
			include 'twofactor-validate.tpl.php';
			$show_vip_acct_list_status = 0;
		}
	}
}

// ==================== add vip cred more =====================
if ($_POST['save_cred_more'] != '') {

	$credentialId = str_replace("'", "", strtoupper($_POST['credentialId']));
	$vip_cred_comment = str_replace("'", "", $_POST['vip_acct_comment']);

	$credentialId = str_replace('"', '', $credentialId);
	$vip_cred_comment = str_replace('"', '', $vip_cred_comment);

	//$vip_acct_id , $vip_cred , $vip_cred_type , $vip_cred_comment , $cpuser_id , $appsuser_id

	// ===== case has_acct = 1

	$oResN = RvLibs_RvGlobalStoreApi::singleton()->request('get', '/vipuserinfo', array(
																						'action_do' => 'get_vip_acct_by_vip_acct_name' , 
																						'vip_acct_name' => $vip_acct_fullname
																					    )
												          );
	$oResNData = (array) $oResN;
	$vip_acct_id = $oResNData['vip_acct_id'];
	$cpuser_id = $oResNData['cpuser_id'];
	$appsuser_id = $oResNData['appsuser_id'];

	$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post', '/vipuserinfo', array(
																							'action_do' => 'addcred_app' , 
																							'vip_cred' => $credentialId , 
																							'vip_cred_comment' => $vip_cred_comment ,
																							'vip_cred_type' => 'STANDARD_OTP' ,
																							'cpuser_id' => $cpuser_id ,
																							'appsuser_id' => $appsuser_id ,
																							'vip_acct_id' => $vip_acct_id
																						)
														 );
	$oResAdd = (array) $oRes;

	if( $oResAdd['status'] == 'success' ) {
		include 'twofactor-validate.tpl.php';
		$show_vip_acct_list_status = 0;
	}
}

// ==================== validate cred after add cred
if ($_POST['validate_cred_but']) {

	// validate credential
	$appsuser_id = $_POST['userId'];
	$vip_acct_id = $_POST['vip_acct_id'];
	$otp = $_POST['otp'];
	$vip_cred = $_POST['credentialId'];

	$otp = str_replace("'", "", $_POST['otp']);
	$otp = str_replace('"', '', $_POST['otp']);


	$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('post',
					 '/vipuserinfo', array(
											'action_do' => 'validate_cred_app' , 
											'vip_acct_id' => $vip_acct_id , 
											'appsuser_id' => $appsuser_id ,
											'otp' => $otp ,
											'vip_cred' => $vip_cred
	));
	$oResR = (array) $oRes;

	// return add account result from symantec
	if ($oResR['status'] == 'success') {

		// save to db
		$err_comment = '<font color="green">Add and validate Symantec VIP Credential ID : '.$vip_cred. ' was successful</font><br />';

	} else {

		$err_comment = "<font color='#FF0000'>".$oResR['comment']."</font>";
		$vip_cred_id = $oResR['vip_cred_id'];
		$oResx = RvLibs_RvGlobalStoreApi::singleton()->request('get',
						 '/vipuserinfo', array(
												'action_do' => 'deletecredential_app' , 
												'vip_cred_id' => $vip_cred_id , 
												'appsuser_id' => $appsuser_id 
										));
		$oResRx = (array) $oResx;
		 
	}
					
} 


//====================== delete cred =====================

if ($_GET['action_do'] == 'delete-credential') {
	
	$vip_cred = $_GET['vip_cred'];
	$vip_cred_id = $_GET['vip_cred_id'];

	$resx = $oTwoList->get_vip_setting(); 
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
		$err_comment = "<font color='green'><b>".$oResRx['comment']."</b></font>";
	} else {
		$err_comment = "<font color='red'><b>".$oResRx['comment']."</b></font>";
	}
}
// ==================== delete cred end ==================



// =========================== add cred more =========================//
if($_GET['action_do'] == 'add-cred-app') {
	
	include "twofactor-add.tpl.php";
	
} else if ($_GET['action_do'] == 'event-log') {
	
	include "twofactor-event-log.tpl.php";
	
} else if ($_GET['action_do'] == 'access-log') {
	
	include "twofactor-access-log.tpl.php";
	
} else {

//=========================== list credential ======================== //
$resultm2 = $oTwoList->getVipUserDetail($user_login);
if ($resultm2['enable_status'] == 0) {
	$sel0 = " selected='selected' ";
	$sel1 = " ";
} else if ($resultm2['enable_status'] == 1) {
	$sel0 = " ";
	$sel1 = " selected='selected' ";
}

if ($enable_vip_service > 0) {

	if($resultm2['user_login'] != $user_login) {
		
		// get vip_cred_list
		$oResLAcct = RvLibs_RvGlobalStoreApi::singleton()->request('get',
					 '/vipuserinfo', array(
											'action_do' => 'get_app_quota' ,
											'appsuser_id' => $appsuser_id 
									));
		$oResListAcct = (array) $oResLAcct; 
		
		
		
		// get vip_cred_list
		$oResLCnt = RvLibs_RvGlobalStoreApi::singleton()->request('get',
					 '/vipuserinfo', array(
											'action_do' => 'get_acct_app' ,  
											'appsuser_id' => $appsuser_id 
									));
		$oResCnt = $oResLCnt; 
		
		
	    //echo "quota=".$oResListAcct['quota_app_amount']." used ".$oResCnt;			
			

		if ($oResListAcct['quota_app_amount'] > $oResCnt) {
			echo "<center>You have not Credential ID, Please add your Credential ID</center>";
			// add vip with cred app form
			include "twofactor-add.tpl.php"; 
		} else {
			echo "<center>
						Your ".$rv2factor_label." accounts have proceeded the quota. 
						<br />
						Please contact your host provider.<br />
				  </center>";
		}

	} else {
			
			if($err_comment != '') { 
				echo "<center><div id='message' class='updated'>
							<p>".$err_comment."</p>
					   </div></center>";
			} 
			
			
			if ($show_vip_acct_list_status == 1) {
			
			echo "<h4>".$rv2factor_label." > Manage Credential</h4><br />";
			
			 	?>
		
			<form action='index.php?cmd=clientarea&action=rvlist&rvaction=twofactor&acton_do=enable_service' method='post' id='change_enable_frm' name='change_enable_frm'>
			<input type='hidden' name='change_status' value='1'>
			<table cellspacing="0" cellpadding="3" border="0">
				<TR>
					<TD><?php echo $rv2factor_label; ?> Status</TD>
					<TD align="center"><select name='enable_vip_for_own' onchange='document.change_enable_frm.submit()' style="margin:5px;">
							<option value='0' <?php echo $sel0; ?>>Disabled</option>
							<option value='1' <?php echo $sel1; ?>>Enabled</option>
						</select></td>
					<td> You can set "Enabled" status to active "<?php echo $rv2factor_label; ?>" for this account.</TD>
				</TR>
			</table>
			</form>
			
			<?php 
						// get vip_cred_list
						$oResL = RvLibs_RvGlobalStoreApi::singleton()->request('get',
									 '/vipuserinfo', array(
															'action_do' => 'listcred_app' , 
															'vip_acct_name' => $vip_acct_fullname , 
															'appsuser_id' => $appsuser_id 
													));
						$oResList = (array) $oResL; 
						
						$cnt_cred = count($oResList);
						
			?>
			
            <style>
				table.padtable{
					padding:0;
					margin:0;
				}
				table.padtable td{
					line-height:25px;
					padding:5px;
					border-bottom:1px solid #bebebe;
				}
				.btn, .btn:visited, .btn:hover, .btn:active{ 
					color:#fff; 
					text-decoration:none;
					background:#4f4f4f; 
					display:inline; 
					border:0;
					border-radius:3px; 
					padding:5px 15px; 
					margin-right:3px; 
					width:90px; 
					white-space:nowrap; 
					cursor:pointer;
				}
				.btn:hover, .btn:active{ 
					color:#fff; 
					background:#636363; 
				}
				.padtopbot10{padding:10px 0;}
			</style>
            
			<table width="100%" cellpadding="3"  cellspacing="0" border="0">
            <tr>
            	<td colspan="2" align="right"><?php if ($cnt_cred < 5 ) { ?> <a href='index.php?cmd=clientarea&action=rvlist&rvaction=twofactor&action_do=add-cred-app' class='btn'>Add Credential</a> <?php } else { echo "Add Credentail"; } ?></td>
            </tr>
			<tr>
					<td align="left" class="padtopbot10"> Credential ID used <?php echo $cnt_cred; ?> of 5 available</td>
					<td align="right"><a href='index.php?cmd=clientarea&action=rvlist&rvaction=twofactor&action_do=access-log'>Access Log</a> | <a href='index.php?cmd=clientarea&action=rvlist&rvaction=twofactor&action_do=event-log'>Event Log</a> </td>
			
			<br />
			
			<?php
				
					
						
						
							echo "<table width='100%' cellpadding='0'  cellspacing='0' border='0' class='padtable'>
									<tr>
											<td align='center' style='padding:0; border-bottom:0;'><div class='serv_head1'>Credential ID</div></td>
											<td align='center' style='padding:0; border-bottom:0;'><div class='serv_head1'>Note</div></td>
											<td align='center' style='padding:0; border-bottom:0;'><div class='serv_head1'>Action</div></td>
									</tr>";
						
							foreach($oResList as $res_c1 => $res_cc)
							{
								if (count($oResList) > 1) {
									$del_link = "<a href='index.php?cmd=clientarea&action=rvlist&rvaction=twofactor&action_do=delete-credential&vip_cred_id=".$res_cc->vip_cred_id."&vip_cred=".$res_cc->vip_cred."'
										 onclick='return confirm(\"&ldquo;Delete Credential&rdquo; will be functional once you have 2 credentials in minimum.\")'><img src='https://netway.co.th/templates/netwaybysidepad/images/icon_delete.png' alt='Delete' width='18' height='18' border='0' title='Delete' /></a> ";
								} else {
									$del_link = "<img src='https://netway.co.th/templates/netwaybysidepad/images/icon_delete.png' alt='Delete' width='18' height='18' border='0' title='Delete' />";
								}
								
					
								echo "<tr>
						               		<td> ".$res_cc->vip_cred." </td>
						               	    <td align='center'> ".$res_cc->vip_cred_comment." </td>
						               		<td align='center'> ".$del_link." </td>
						          	  </tr>";
							}
							
							echo "</table>";
						
						
					
		
			?>
			</table>
			
		
			
			<?php }
			
		}

	} // end if ($enable_vip_service > 0)
	else
	{
		//echo $rv2factor_label." is disabled by admin.";
		echo "Two factor authentication is disabled by admin.";
	}

}
	
	?>
	




 
 