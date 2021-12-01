<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Other/netway_reseller/admin/class.netway_reseller_controller.php');
require_once(APPDIR_MODULES . 'Other/producthandle/admin/class.producthandle_controller.php');
require_once(APPDIR_MODULES . 'Site/domainhandle/admin/class.domainhandle_controller.php');


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aProduct   = $this->get_template_vars('product');
// --- Get template variable ---

// --- reseller enable for this product ---
if (isset($aProduct['id'])) {
    $result     = netway_reseller_controller::singleton()->isEnableProductForReseller($aProduct['id'], $aProduct['ptype']);
    $aProduct['is_reseller']    = $result;
    $this->assign('product', $aProduct);
}

// --- load additional product configuration ---
if (isset($aProduct['id'])) {
    $aProduct['isReturn']   = true;
    $result     = producthandle_controller::singleton()->getConfig($aProduct);
    $aProduct['aConfig']    = $result;
    $this->assign('product', $aProduct);
}

// --- load register domain document ---
if (isset($aProduct['id'])) {
    $result     = domainhandle_controller::singleton()->getDomainRegisterDocument($aProduct['id']);
    $aProduct['reg_document']    = $result;
    $this->assign('product', $aProduct);
}
