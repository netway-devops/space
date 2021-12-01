<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
//$aDomains   = $this->get_template_vars('domains');
// --- Get template variable ---
