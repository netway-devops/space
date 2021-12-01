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
$aDetails       = $this->get_template_vars('details');
// --- Get template variable ---

$status         = isset($_GET['s']) ? $_GET['s'] : '';
$this->assign('status', $status);
$page           = isset($_GET['p']) ? $_GET['p'] : 1;
$this->assign('page', $page);
$keyword        = isset($_GET['keyword']) ? trim($_GET['keyword']) : '';
$this->assign('keyword', $keyword);

$aTotal         = array(
    'All'       => productlicensehandle_controller::singleton()->countLicense(array('status' => 'All')),
    'Pending'   => productlicensehandle_controller::singleton()->countLicense(array('status' => 'Pending')),
    'Active'    => productlicensehandle_controller::singleton()->countLicense(array('status' => 'Active')),
    'Suspended' => productlicensehandle_controller::singleton()->countLicense(array('status' => 'Suspended')),
    'Expired'   => productlicensehandle_controller::singleton()->countLicense(array('status' => 'Expired')),
    );
$this->assign('aTotal', $aTotal);

$aParam         = array(
    'status'    => $status,
    'page'      => $page,
    'keyword'   => $keyword,
    );
$aLicenses      = productlicensehandle_controller::singleton()->listLicense($aParam);
$bLicenses = $aLicenses;
foreach($bLicenses['lists'] as $key => $eachService){
	$chkServIP = $db->query("SELECT account_id FROM hb_config2accounts WHERE data = '{$eachService['ip']}' AND config_cat ='22'")->fetch();
	if($chkServIP){
		$getPub = $db->query("SELECT data FROM hb_config2accounts WHERE account_id = '{$chkServIP['account_id']}' AND config_cat = '200'")->fetch();
		if($getPub){
			$mainIP = $getPub['data'];
			foreach($aLicenses['lists'] as $aKey => $beService){
				if($beService['ip'] == $mainIP && $aKey != $key){
					foreach($eachService['items'] as $eachItem){
						$aLicenses['lists'][$aKey]['items'][] = $eachItem;
					}
					unset($aLicenses['lists'][$key]);
				}
			}
		}
	}
}
$this->assign('aLicenses', $aLicenses);

//echo '<pre>'. print_r($_GET, true) .'</pre>';
