<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

/**
 * ถ้าทำ provision แล้วจะไม่ให้เลือก provision เป็น default
 */

$isProvisionCompleted   = false;

$aSteps     = $this->get_template_vars('steps');
if (is_array($aSteps)) {
    foreach ($aSteps as $aStep) {
        if ($aStep['name'] == 'Provision' && $aStep['status'] == 'Completed') {
            $isProvisionCompleted   = true;
        }
    }
}

$this->assign('isProvisionCompleted', $isProvisionCompleted);