<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Other/producthandle/admin/class.producthandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aCategory          = $this->get_template_vars('category');
$aProducts          = $this->get_template_vars('products');
// --- Get template variable ---

if (count($aProducts)) {
    $result         = producthandle_controller::getTotalServiceStatus($aCategory, $aProducts);
    $this->assign('aProducts', $result);
}