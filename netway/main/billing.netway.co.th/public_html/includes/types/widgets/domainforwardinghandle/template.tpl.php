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
$aDetails       = $this->get_template_vars('details');
// --- Get template variable ---

if (@preg_match('/domainforwardinghandle/', $_SERVER['QUERY_STRING'])) {
    $this->assign('rvcustomtemplate', APPDIR_MODULES . 'Other/netway_common/templates/domain/user/domainforwarding.tpl');
} 


