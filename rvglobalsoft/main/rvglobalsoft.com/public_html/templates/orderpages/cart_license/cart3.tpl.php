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
$aProduct   = $this->get_template_vars('product');
// --- Get template variable ---

$productId  = $aProduct['id'];
$this->assign('productId', $productId);

$currentIp  = isset($_SESSION['aCart']['ip']) ? $_SESSION['aCart']['ip'] : '';
if (isset($_SESSION['Stack']['ip'])) {
    $currentIp      = $_SESSION['Stack']['ip'];
    unset($_SESSION['Stack']['ip']);
}
$this->assign('currentIp', $currentIp);
$currentId  = isset($_SESSION['aCart']['id']) ? $_SESSION['aCart']['id'] : '';
$this->assign('currentId', $currentId);

$result     = productlicensehandle_controller::singleton()->getProductNameById($productId);
$this->assign('productName', $result);

$result     = productlicensehandle_controller::singleton()->getProductById($productId);
$this->assign('aProduct', $result);

$result     = productlicensehandle_controller::singleton()->isPartner(array());
$this->assign('isPartner', $result);

//echo '<pre>'. print_r($_SESSION, true) .'</pre>';


