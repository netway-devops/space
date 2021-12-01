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
$aDraft     = $this->get_template_vars('draft');
// --- Get template variable ---

//echo '<pre>'. print_r($aDraft, true) .'</pre>';
