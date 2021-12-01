<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$aService           = $this->get_template_vars('service');

$serviceId          = isset($aService['id']) ? $aService['id'] : 0;

$this->assign('serviceId', $serviceId);

//echo '<pre>'. print_r($aService, true) .'</pre>';