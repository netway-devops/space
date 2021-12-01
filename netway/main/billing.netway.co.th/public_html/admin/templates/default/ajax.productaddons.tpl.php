<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Other/netway_reseller/admin/class.netway_reseller_controller.php');
require_once(APPDIR_MODULES . 'Other/producthandle/admin/class.producthandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aAddon     = $this->get_template_vars('addon');
// --- Get template variable ---


// --- load additional product configuration ---
if (isset($aAddon['id'])) {
    $aAddon['isReturn']     = true;
    $result     = producthandle_controller::singleton()->getConfigAddon($aAddon);
    $aAddon['aConfig']      = $result;
    $this->assign('addon', $aAddon);
}

$listProductAddon = array();

foreach($aAddon['products'] as $product){
    if($product != '') $listProductAddon[$product] = $product;
}

if (count($listProductAddon)) {
    
    $result         = producthandle_controller::getAccountAddonByAddonStatus($listProductAddon, $aAddon['id']);
    $this->assign('aProductAccounts', $result);
}

