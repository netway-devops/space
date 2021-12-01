<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/fulfillmenthandle/admin/class.fulfillmenthandle_controller.php');


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
$aSteps     = $this->get_template_vars('steps');
// --- Get template variable ---

$orderId    = $aDetails['id'];
$invoiceId  = $aDetails['invoice_id'];

$result     = fulfillmenthandle_controller::singleton()->listFulfillmentProcess(array('aDetail'=>$aDetails));
$this->assign('aProcessGroup', $result);

$result     = fulfillmenthandle_controller::singleton()->listManualFulfillmentTicket(array('orderId'=>$orderId));
$this->assign('aManualFulfillmentTicket', $result);

//echo '<pre>'. print_r($result, true) .'</pre>';