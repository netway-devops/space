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
// --- Get template variable ---

$orderId    = $aDetails['id'];
$invoiceId  = $aDetails['invoice_id'];

$aBankTransfer  = array(
    'scb'   => 'ไทยพาณิชย์',
    'bbl'   => 'กรุงเทพ',
    'boa'   => 'กรุงศรีอยุธยา',
    'ktb'   => 'กรุงไทย',
    'tfb'   => 'กสิกรไทย',
    'tmb'   => 'ทหารไทย',
    'gsb'   => 'ออมสิน',
    'tbp'   => 'ธนชาต'
    );
$this->assign('aBankTransfer', $aBankTransfer);

$aAuthorize     = fulfillmenthandle_controller::singleton()->authorizeLists(array('orderId'=>$orderId));
$this->assign('aAuthorize', $aAuthorize);

$aTotal        = fulfillmenthandle_controller::singleton()->invoiceTotal(array('invoiceId'=>$invoiceId));
$this->assign('aTotal', $aTotal);

