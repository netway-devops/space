<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Site/searchhandle/admin/class.searchhandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aResults   = $this->get_template_vars('results');
$activetab  = $this->get_template_vars('activetab');
$aPost      = isset($_POST) ? $_POST : array();
// --- Get template variable ---


// --- load additional product configuration ---
if (isset($aAddon['id'])) {
    $aAddon['isReturn']     = true;
    $result     = producthandle_controller::singleton()->getConfigAddon($aAddon);
    $aAddon['aConfig']      = $result;
    $this->assign('addon', $aAddon);
}

$aResult    = array(
    'General'   => array(
        'count'     => 0,
        'results'   => array()
    )
);

$result     = searchhandle_controller::singleton()->search($aPost);
$aResult['General']['count']    = count($result);
$aResult['General']['results']  = count($result) ? $result : array();
foreach ($aResults as $k => $arr) {
    $aResult[$k]    = $arr;
}
$aResults   = $aResult;

$activetab  = 'General';
$this->assign('activetab', $activetab);
$this->assign('results', $aResults);

//echo '<pre>'. print_r($aResults, true) .'</pre>';
