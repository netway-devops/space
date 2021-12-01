<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR .'modules/Site/orderhandle/admin/class.orderhandle_controller.php');
require_once(APPDIR .'modules/Other/producthandle/admin/class.producthandle_controller.php');
require_once(APPDIR .'modules/Site/fulfillmenthandle/admin/class.fulfillmenthandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
// --- Get template variable ---

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

if (isset($aDetails['id'])) {
    
    orderhandle_controller::updateInvoiceStaffOwner($aDetails['id']);

    $result     = producthandle_controller::singleton()->provisionWithCapture($aDetails);
    $this->assign('aProvisionWithCapture', $result);
    
    if ($aDetails['status'] == 'Pending') {
        // ยกเลิก fulfillmenthandle_controller::singleton()->orderFulfillmentProcess($aDetails);
    }
    
    $result     = fulfillmenthandle_controller::singleton()->orderFulfillmentTicket($aDetails);
    $this->assign('aFulfillmentTicket', $result);
    
    $isAcceptableOrder      = fulfillmenthandle_controller::singleton()->isAcceptableOrder($aDetails);
    $this->assign('isAcceptableOrder', $isAcceptableOrder);
    $aDetails               = fulfillmenthandle_controller::singleton()->provisionActivate($aDetails);
    $this->assign('details', $aDetails);
    
    
}



