<?php

require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$accountId  = isset($details['service']['id']) ? $details['service']['id'] : 0;

invoicehandle_controller::singleton()->extendDeveloperLicenseTrialAccount(array('accountId'=>$accountId));
