<?php

/**
 * New estimate has just been created with ID=$details
 * Following variable is available to use in this file:  $details This variable keeps estimate id
 */

 // --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

//require_once(APPDIR . 'class.discount.custom.php');
require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

$estimateId    = $details;
invoicehandle_controller::singleton()->hookAfterEstimateCreate($estimateId);
