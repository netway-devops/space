<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aFields        = $this->get_template_vars('fields');
// --- Get template variable ---

/*
$AllowedAttachmentExt       = ConfigCustom::singleton()->getValue('AllowedAttachmentExt');

$this->assign('AllowedAttachmentExt', $AllowedAttachmentExt);
*/
