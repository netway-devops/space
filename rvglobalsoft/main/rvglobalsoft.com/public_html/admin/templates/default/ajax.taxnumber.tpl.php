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
$aDetails   = $this->get_template_vars('details');
// --- Get template variable ---

require_once(APPDIR . 'class.config.custom.php');
$nwTaxNumber    = ConfigCustom::singleton()->getValue('nwTaxNumber');

$this->assign('nwTaxNumber', $nwTaxNumber);
