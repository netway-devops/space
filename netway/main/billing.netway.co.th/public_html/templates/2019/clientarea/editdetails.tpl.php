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
$aClient            = $this->get_template_vars('client');
$aFields            = $this->get_template_vars('fields');
// --- Get template variable ---

