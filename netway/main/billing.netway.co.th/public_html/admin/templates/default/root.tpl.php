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
$aAdmindata  = $this->get_template_vars('admindata');
// --- Get template variable ---

/* --- Admin widget --- */
$aWidgets   = array();

foreach ($aAdmindata['access'] as $k => $v) {
    if (preg_match('/^widget/', $v)) {
        array_push($aWidgets, $v);
    }
}

$this->assign('aWidgets', $aWidgets);
