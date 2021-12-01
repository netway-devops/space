<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// ยกเลิก require_once(APPDIR . 'modules/Site/loghandle/admin/class.loghandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aTemplateVars      = $this->get_template_vars();
// --- Get template variable ---

$result     = array(); // ยกเลิก loghandle_controller::singleton()->getInfo();
$this->assign('aLogsInfo', $result);

