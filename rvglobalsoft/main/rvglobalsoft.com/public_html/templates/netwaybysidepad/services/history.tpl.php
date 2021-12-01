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


$page           = isset($_GET['p']) ? $_GET['p'] : 1;
$this->assign('page', $page);
$widgetId       = isset($_GET['wid']) ? $_GET['wid'] : 0;
$this->assign('widgetId', $widgetId);
$widgetName     = isset($_GET['widget']) ? $_GET['widget'] : '';
$this->assign('widgetName', $widgetName);

$aParam         = array(
    'page'      => $page,
    'accountId' => $aService['id'],
    );
$aHistory       = productlicensehandle_controller::singleton()->listHistory($aParam);
$this->assign('aHistory', $aHistory);


//echo '<pre>'. print_r($aService, true) .'</pre>';
