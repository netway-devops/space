<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/productlicensehandle/user/class.productlicensehandle_controller.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$step       = $this->get_template_vars('step');
// --- Get template variable ---

$result     = productlicensehandle_controller::singleton()->listProduct(array());
$this->assign('aProducts', $result);

$result     = productlicensehandle_controller::singleton()->isPartner(array());
$this->assign('isPartner', $result);

//echo '<pre>'. print_r($_GET, true) .'</pre>';


