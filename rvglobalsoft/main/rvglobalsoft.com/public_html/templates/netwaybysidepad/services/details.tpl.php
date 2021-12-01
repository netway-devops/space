<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/productlicensehandle/user/class.productlicensehandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aService       = $this->get_template_vars('service');
$aWidget        = $this->get_template_vars('widget');
// --- Get template variable ---

$accountId      = $aService['id'];
$aService['ip'] = productlicensehandle_controller::singleton()->getIPAddress($accountId);

$chkServIP = $db->query("SELECT data FROM hb_config2accounts WHERE account_id = '{$accountId}' AND config_cat ='200' AND data != ''")->fetch();
if($chkServIP){
	$aService['pub_ip'] = $chkServIP['data'];
}
$aService['expire']     = productlicensehandle_controller::singleton()->getExpireDate (
                            $aService['id'], $aService['product_id'], $aService['ip'],
                            $aService['next_due'], $aService['status']
                            );
$this->assign('aService', $aService);

$aCommand       = array('changeip', 'cancel');
$this->assign('aCommand', $aCommand);

//echo '<pre>'. print_r($aService, true) .'</pre>';
