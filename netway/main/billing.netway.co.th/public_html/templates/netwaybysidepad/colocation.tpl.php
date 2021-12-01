<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aSubmit    = $this->get_template_vars('submit');
// --- Get template variable ---

$result     = GeneralCustom::singleton()->getProductPrice (669);
$this->assign('colo1u', number_format($result['m'],'0','.',','));
$result     = GeneralCustom::singleton()->getProductPrice (668);
$this->assign('colo2u', number_format($result['m'],'0','.',','));
$result     = GeneralCustom::singleton()->getProductPrice (670);
$this->assign('colo3u', number_format($result['m'],'0','.',','));
$result     = GeneralCustom::singleton()->getProductPrice (671);
$this->assign('colo4u', number_format($result['m'],'0','.',','));
$result     = GeneralCustom::singleton()->getProductPrice (672);
$this->assign('colo20u', number_format($result['m'],'0','.',','));
$result     = GeneralCustom::singleton()->getProductPrice (673);
$this->assign('colo42u', number_format($result['m'],'0','.',','));

//echo '<pre>'. print_r($result, true) .'</pre>';

