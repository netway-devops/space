<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
//$aGateways           = $this->get_template_vars('gateways');
// --- Get template variable ---




//$this->assign('gateways2', $aGateway);

//echo '<pre>'.print_r($_SESSION, true).'</pre>';