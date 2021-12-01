<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


require_once(APPDIR . 'modules/Site/addresshandle/admin/class.addresshandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aDraft     = $this->get_template_vars('draft');
// --- Get template variable ---

$orderDraftId   = isset($aDraft['id']) ? $aDraft['id'] : 0;
$clientId       = isset($aDraft['client_id']) ? $aDraft['client_id'] : 0;

$result         = $db->query("
    SELECT
        od.*
    FROM
        hb_order_drafts od
    WHERE
        od.id = :id
    ", array(
        ':id'   => $orderDraftId
    ))->fetch();


$billingAddress   = $result['billing_address'];

if ($billingAddress == '') {
    $aParam     = array(
        'orderDraftId'  => $orderDraftId,
        'client_id'     => $clientId,
        'isReturn'      => 1,
    );
    $result     = addresshandle_controller::singleton()->updateToInvoice($aParam);
    $billingAddress = isset($result['billingAddress']) ? $result['billingAddress'] : '';
}

$this->assign('billingAddress', $billingAddress);


//echo '<pre>'.print_r($aDraft, true).'</pre>';