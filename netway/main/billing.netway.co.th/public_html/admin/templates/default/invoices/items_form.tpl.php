<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/adminhandle/model/class.adminhandle_model.php');
require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aAdmins    = hbm_logged_admin();
// --- hostbill helper ---

// --- Get template variable ---
$aInvoice           = $this->get_template_vars('invoice');
// --- Get template variable ---
$aEstimate          = $this->get_template_vars('estimate');

if (isset($_GET['reload']) && isset($_GET['isEstimate'])) {

    $aParam = array(
        'invoiceId'     => $aInvoice['id'],
        'isEstimate'    => count($aEstimate)
    );

    invoicehandle_controller::singleton()->updateTaxWithholding($aParam);

    if ($_GET['isEstimate']) {
        echo '<script>document.location = "?cmd=estimates&action=edit&id='. $aEstimate['id'] .'";</script>';
    }
    else {
        echo '<script>document.location = "?cmd=invoices&action=edit&id='. $aInvoice['id'] .'";</script>';

    }
    exit;



}

if ($aInvoice['taxrate'] && isset($aInvoice['taxes'][0])) {
    $aInvoice['taxes'][7]   = $aInvoice['taxes'][0];
    $aInvoice['taxes'][7]['subtotal']       = $aInvoice['subtotal'];
    $aInvoice['taxes'][7]['name']           = '7 %';
    $aInvoice['taxes'][7]['rate']           = 7;
    $aInvoice['taxes'][7]['total']          = ($aInvoice['subtotal'] + ($aInvoice['subtotal'] * 7 / 100));
    $aInvoice['taxes'][7]['tax']            = ($aInvoice['subtotal'] * 7 / 100);
}
//$this->assign('invoice', $aInvoice);


if(count($aEstimate)){


    foreach ($aEstimate['items'] as $aItem){
        if($aItem['unit_price'] < 1 && !preg_match('/^Discount/',$aItem['description']) && $aItem['status'] != 'Dead'){
            invoicehandle_controller::singleton()->hookAfterEstimateCreate($aEstimate);
                echo '<script>document.location = "?cmd=estimates&action=edit&id='. $aEstimate['id'] .'&reload=1&isEstimate=1";</script>';
                exit;
        }
    }
}
/*
$aAdmin     = adminhandle_model::singleton()->listActive();
$this->assign('aStaffs', $aAdmin);
*/

$aAdmin     = adminhandle_model::singleton()->listActiveWithTeam(array('Sales (SSL)','Sales','Admin', 'Admin Active (Officer)', 'Admin Renew (Officer)'));
$this->assign('aStaffs2', $aAdmin);

//echo '<pre>'.print_r($aInvoice['taxes'], true).'</pre>';