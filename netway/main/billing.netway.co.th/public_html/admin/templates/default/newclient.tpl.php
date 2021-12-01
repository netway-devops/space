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
$aSubmit           = $this->get_template_vars('submit');
// --- Get template variable ---

/* --- set company type เป็น default --- */
if ( !isset($aSubmit['type'])) {
    $aSubmit['type']    = 'Company';
    $this->assign('submit', $aSubmit);
}