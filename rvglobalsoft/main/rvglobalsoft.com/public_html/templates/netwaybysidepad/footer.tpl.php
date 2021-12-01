<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- Get template variable ---
$aClient        = hbm_logged_client();
// --- Get template variable ---

$this->assign('aClient', $aClient);