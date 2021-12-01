<?php
if ( ! defined('HBF_APPNAME')) {
    exit;
}
require_once APPDIR . 'libs/rv_partner/rv_partner.php';

$oPartnet = new rv_partner();
$aPartnetInfo = $oPartnet->getPatrnetInfomationbyCid($_SESSION['AppSettings']['login']['id']);

if (count($aPartnetInfo) <= 0) 
{
	$this->assign('isNotConvert', true);
} /// endif
else 
{
	$this->assign('isError', false);
    
	$quota_id = $aPartnetInfo[0]['quota_id'];
    
	if ($_POST['rvcallaction'] == 'add') 
	{
		$email            = $oPartnet->getPartnerEmail($_SESSION['AppSettings']['login']['id']);
		$main1            = trim($_POST['remote_main_1']);
		$main2            = trim($_POST['remote_main_2']);
		$main3            = trim($_POST['remote_main_3']);
		$mainIP           = "{$main1}.{$main2}.{$main3}";
		$subFirstIP       = trim($_POST['remote_sub_first']);
		$subLastIP        = (empty($_POST['remote_sub_last']) OR trim($_POST['remote_sub_last']) == '')
			? $_POST['remote_sub_first'] 
			: $_POST['remote_sub_last'];
            
		if ($main1 != '' &&  $main2 != '' && $main3 != '' && $subFirstIP != '' && $subLastIP != '') 
		{
			if ($oPartnet->addRemoveIssue($quota_id, $email, $mainIP, $subFirstIP, $subLastIP)) 
			{
				$this->assign('isSuccess', true);
				$this->assign('SuccessMsg', 'Add new remote issue has success.');
			} /// endif
			else 
			{
				$this->assign('isError', true);
				$this->assign('ErrorMsg', 'Add new remote issue has problem.');
			} /// endelse
		} /// endif
		else 
		{
			$this->assign('isError', true);
			$this->assign('ErrorMsg', 'Sorry, some field has empty.');
		} /// endelse
	} /// endif
	elseif ($_POST['rvcallaction'] == 'delete') 
	{
		$delQuota_id  = $_POST['quota_id'];
		$mainIP       = $_POST['main_ip'];
		$subFirstIP   = $_POST['remote_sub_first'];
		$subLastIP    = $_POST['remote_sub_last'];
        
		if ($oPartnet->deleteRemoveIssue($delQuota_id, $mainIP, $subFirstIP, $subLastIP)) 
		{
			$this->assign('isSuccess', true);
			$this->assign('SuccessMsg', 'Delete remote issue has success.');
		} /// endif
		else 
		{
			$this->assign('isError', true);
			$this->assign('ErrorMsg', 'Delete remote issue has problem.');
		} /// endelse
	} /// endelseif
	
	$aRemoteList = $oPartnet->getRemoveIssueList($quota_id);
	$this->assign('aRemoteList', $aRemoteList);
    
} /// endelse
