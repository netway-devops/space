<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aInvoice       = $this->get_template_vars('invoice');
// --- Get template variable ---


$result     = invoicehandle_controller::singleton()->verifyDeleteInvoice($aInvoice);

$this->assign('isCanDelete', $result);
