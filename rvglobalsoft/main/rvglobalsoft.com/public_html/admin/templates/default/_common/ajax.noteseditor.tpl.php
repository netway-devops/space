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
$aNotes         = $this->get_template_vars('notes');
// --- Get template variable ---


$this->assign('editable', ((isset($_GET['editable']) && $_GET['editable']) ? 'true' : ''));