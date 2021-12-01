<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

//ดึง
$aServices = $this->get_template_vars('provisioning_type');
$aUpgrades = $this->get_template_vars('upgrades');

print_r($aUpgrades);


//กำหนดค่า
//$this->assign('upgrades', 'xxx');
?>
